<%--
 % Copyright 2012 - kilabit.org
 %
 % Author(s):
 %	- m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileFilter" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.Runtime" %>
<%@ page import="java.lang.Process" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%@ page import="org.apache.commons.io.filefilter.WildcardFileFilter" %>
<%!
public int pdf2image (String filename, String errmsg)
{ try {
	String[]			cmds	= { "convert", filename, filename +"_%d.png" };
	Runtime				rt		= Runtime.getRuntime ();
	Process				proc	= rt.exec (cmds);
	InputStream			stderr	= proc.getErrorStream();
	InputStreamReader	isr		= new InputStreamReader(stderr);
	BufferedReader		br		= new BufferedReader(isr);
	String				line	= "";

	while ((line = br.readLine ()) != null) {
		errmsg += line;
	}

	return proc.waitFor ();
} catch (Exception e) {
	return 1;
}}
%>
<%
Connection	db_con			= null;
boolean		is_multipart	= false;
String		q				= "";
ResultSet	rs				= null;
try {
	db_con = (Connection) session.getAttribute ("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect(request.getContextPath ());
		return;
	}

	is_multipart = ServletFileUpload.isMultipartContent (request);
	if (! is_multipart) {
		out.print ("{success:false,info:'Data tidak ada!'}");
		return;
	}

	Statement			db_stmt	= db_con.createStatement ();
	String				rpath	= config.getServletContext ().getRealPath ("/");
	String				user_id	= (String) session.getAttribute ("user.id");
	String				uk_id	= (String) session.getAttribute ("user.unit_kerja_id");
	String				repo	= (String) session.getAttribute ("sys.repository_root");

	FileItemFactory		factory	= new DiskFileItemFactory ();
	ServletFileUpload	upload	= new ServletFileUpload (factory);
	List				items	= upload.parseRequest (request);
	Iterator			itr		= items.iterator ();

	File		file		= null;
	FileItem	item		= null;
	FileItem	item_up		= null;
	String		k			= null;
	String		v			= null;
	String		pid			= "";
	String		name		= "";
	String		filename	= "";
	String		mime		= "";
	String		errmsg		= "";
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
			} else if (k.equals ("name")) {
				name = v;
			}
		} else {
			item_up		= item;
			filesize	= item.getSize ();
			mime		= item.getContentType ();
		}
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
	String	user_dir	= rpath + repo +"/"+ user_id;
	File	f_user_dir	= new File (user_dir);

	if (! f_user_dir.exists ()) {
		f_user_dir.mkdir ();
	}

	/* save file stream to filesystem */
	filename	= user_dir +"/"+ sha;
	file		= new File (filename);

	if (file.exists ()) {
		q	=" select	nama"
			+" from		m_berkas"
			+" where	sha = '"+ sha +"'";

		rs = db_stmt.executeQuery (q);

		if (rs.next ()) {
			name = rs.getString ("nama");

			out.print ("{success:false"
					+",message:'Berkas yang sama telah ada dengan nama \""+ name +"\".'}");
			return;
		}
	}

	item_up.write (file);

	if (mime.equalsIgnoreCase ("application/pdf")) {
		exec_stat = pdf2image (filename, errmsg);
		if (exec_stat != 0) {
			out.print ("{success:false,message:'"+ exec_stat +":"+ errmsg +"'}");
			return;
		}
	}

	File[] outs = f_user_dir.listFiles ((FileFilter) new WildcardFileFilter (sha +"_*.png"));

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
		+" ,	"+ user_id
		+" ,	"+ uk_id
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

	out.print ("{success:true,message:'File telah tersimpan.'}");
} catch (Exception e) {
	out.print ("{success:false,info:'"
			+ e.toString ().replace ("'","\\'") +"'}");
}
%>
