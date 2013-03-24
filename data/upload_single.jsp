<%--
	Copyright 2013 - kilabit.org

	Author(s):
	- m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.FileFilter" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.Process" %>
<%@ page import="java.lang.ProcessBuilder" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.io.filefilter.WildcardFileFilter" %>
<%@ include file="init.jsp"%>
<%!
String errmsg = "";

public static boolean isWindows()
{
	String os = System.getProperty("os.name").toLowerCase();
	return (os.indexOf("win") >= 0);
}

public int pdf2image (String dir, String filename)
{ try {
	List<String> cmds = new ArrayList<String>();

	if (isWindows ()) {
		cmds.add ("cmd.exe");
		cmds.add ("/c");
	}
	cmds.add ("convert");
	cmds.add ("-density");
	cmds.add ("148");
	cmds.add ("-quality");
	cmds.add ("100");
	cmds.add (filename);
	cmds.add (filename +"_%d.png");

	ProcessBuilder		pb		= new ProcessBuilder(cmds);

	pb.directory (new File (dir));

	final Process		proc	= pb.start();
	InputStream			is		= proc.getInputStream();
	InputStreamReader	isr		= new InputStreamReader(is);
	BufferedReader		br		= new BufferedReader(isr);
	String				line;

	while ((line = br.readLine ()) != null) {
		errmsg += line;
	}

	return proc.waitFor ();
} catch (Exception e) {
	errmsg += e.toString ();
	return 1;
}}
%>
<%
boolean		is_multipart	= false;
String		repo				= "";
long		max_upload_size_b	= 0;
long		max_upload_size		= 0;
try {
	is_multipart = ServletFileUpload.isMultipartContent (request);

	if (! is_multipart) {
		_r.put ("success", false);
		_r.put ("info", "Data tidak ada!");
		out.print (_r);
		return;
	}

	/* get upload configuration from database */
	q	="	select	repository_root"
		+"	,		coalesce (max_upload_size, 0) max_upload_size"
		+"	from	m_sysconfig";

	db_stmt	= db_con.createStatement ();
	rs	= db_stmt.executeQuery (q);

	if (! rs.next ()) {
		_r.put ("success", false);
		_r.put ("info", "Error: Konfigurasi repository belum di set!");
		out.print (_r);
		return;
	}

	repo				= rs.getString ("repository_root");
	max_upload_size		= rs.getInt ("max_upload_size");
	max_upload_size_b	= max_upload_size * 1024;

	if (repo.isEmpty ()) {
		_r.put ("success", false);
		_r.put ("info", "Error: Konfigurasi root repository belum di set!");
		out.print (_r);
		return;
	}

	String				rpath	= config.getServletContext ().getRealPath ("/");

	FileItemFactory		factory	= new DiskFileItemFactory ();
	ServletFileUpload	upload	= new ServletFileUpload (factory);
	List				items	= upload.parseRequest (request);
	Iterator			itr		= items.iterator ();

	File		file		= null;
	File[]		outs		= {};
	FileItem	item		= null;
	FileItem	item_up		= null;
	String		k			= null;
	String		v			= null;
	String		pid			= "";
	String		name		= "";
	String		filename	= "";
	String		mime		= "";
	int			exec_stat	= 0;
	long		filesize	= 0;

	/* parse request */
	while (itr.hasNext ()) {
		item = (FileItem) itr.next();
		if (item.isFormField ()) {
			k = item.getFieldName();
			v = item.getString ();

			if (k.equals("id")) {
				pid = v;
			}
		} else {
			item_up		= item;
			name		= item.getName ();
			filesize	= item.getSize ();
			mime		= item.getContentType ();
		}
	}

	/* check file size */
	if (max_upload_size_b > 0 && filesize > max_upload_size_b) {
		_r.put ("success", false);
		_r.put ("info", "Error: Ukuran file unggah besar dari batas maksimum ("+ max_upload_size +" KB)!");
		out.print (_r);
		return;
	}

	/* compute file SHA1 checksum */
	MessageDigest	md		= MessageDigest.getInstance ("SHA1");
	byte[]			result	= md.digest (item_up.get ());
	StringBuffer	sb		= new StringBuffer ();

	for (int i = 0; i < result.length; i++) {
		sb.append (Integer.toString ((result[i] & 0xff) + 0x100, 16).substring(1));
	}

	String sha = sb.toString ();

	/* check user directory */
	String	user_dir	= rpath + repo + File.separator + _user_id;
	File	f_user_dir	= new File (user_dir);

	if (! f_user_dir.exists ()) {
		f_user_dir.mkdir ();
	}

	/* save file stream to filesystem */
	filename	= user_dir + File.separator + sha;
	file		= new File (filename);

	/* IE : get filename without fake path */
	int idx = name.lastIndexOf ('\\');

	if (idx > 0) {
		name = name.substring (idx + 1, name.length ());
	} else {
		idx = name.lastIndexOf ('/');
		if (idx > 0) {
			name = name.substring (idx + 1, name.length ());
		}
	}

	if (file.exists ()) {
		q	=" select	nama"
			+" from		m_berkas"
			+" where	sha		= '"+ sha +"'"
			+" and		nama	= '"+ name +"'"
			+" and		pegawai_id		= "+ _user_id
			+" and		unit_kerja_id	= "+ _user_uk
			+" and		status_hapus	!= 0";

		rs = db_stmt.executeQuery (q);

		if (rs.next ()) {
			name = rs.getString ("nama");

			_r.put ("success", false);
			_r.put ("info", "Berkas yang sama telah ada dengan nama '"+ name +"'.");
			_r.put ("sha", sha);
			_r.put ("user_id", _user_id);

			out.print (_r);
			return;
		}
	}

	item_up.write (file);

	if (mime.equalsIgnoreCase ("application/pdf")) {
		exec_stat = pdf2image (user_dir, sha);
		if (exec_stat != 0) {
			_r.put ("success", false);
			_r.put ("info", exec_stat +":"+ errmsg);
			out.print (_r);
			return;
		}
		outs = f_user_dir.listFiles ((FileFilter) new WildcardFileFilter (sha +"_*.png"));
	}

	/* save file attribute to database */
	q	=" insert into m_berkas ("
		+"		pid"
		+" ,	tipe_file"
		+" ,	sha"
		+" ,	nama"
		+" ,	pegawai_id"
		+" ,	unit_kerja_id"
		+" ,	berkas_klas_id"
		+" ,	berkas_tipe_id"
		+" ,	tgl_dibuat"
		+" ,	nomor"
		+" ,	pembuat"
		+" ,	judul"
		+" ,	masalah"
		+" ,	jra_aktif"
		+" ,	jra_inaktif"
		+" ,	mime"
		+" ,	n_output_images"
		+" )"
		+" select "
		+		pid
		+" ,	1"
		+" ,	'"+ sha +"'"
		+" ,	'"+	name +"'"
		+" ,	"+ _user_id
		+" ,	"+ _user_uk
		+" ,	berkas_klas_id"
		+" ,	berkas_tipe_id"
		+" ,	now() "
		+" ,	nomor"
		+" ,	pembuat"
		+" ,	judul"
		+" ,	masalah"
		+" ,	jra_aktif"
		+" ,	jra_inaktif"
		+" ,	'"+ mime +"'"
		+" ,	"+ outs.length
		+" from		m_berkas "
		+" where	id = "+ pid;

	db_stmt.executeUpdate (q);
	db_stmt.close ();

	q	="	select	id"
		+"	from	m_berkas"
		+"	where	sha				= '"+ sha +"'"
		+"	and		pegawai_id		= "+ _user_id
		+"	and		unit_kerja_id	= "+ _user_uk;

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	rs.next ();

	_r.put ("id"		, rs.getString ("id"));

	db_stmt.close ();
	rs.close ();

	_r.put ("success"	, true);
	_r.put ("info"		, "Berkas '"+ name +"' telah tersimpan.");
	_r.put ("file"		, name);
} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
}
out.print (_r);
%>
