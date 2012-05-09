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
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileItemFactory" %>
<%
Connection	db_con			= null;
boolean		is_multipart	= false;
String		q				= "";
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
	String		path		= "";
	String		name		= "";
	String		filename	= "";
	long		filesize	= 0;

	/* parse request */
	while (itr.hasNext ()) {
		item = (FileItem) itr.next();
		if (item.isFormField ()) {
			k = item.getFieldName();
			v = item.getString ();

			if (k.equals("dir_id")) {
				pid = v;
			} else if (k.equals ("path")) {
				path = v;
			} else if (k.equals ("name")) {
				name = v;
			}
		} else {
			item_up		= item;
			filesize	= item.getSize ();
		}
	}

	/* save file stream to filesystem */
	filename	= rpath + repo +"/"+ path +"/"+ name;
	file		= new File (filename);

	item_up.write (file);

	/* save file attribute to database */
	q	=" insert into m_berkas ("
		+"		pid"
		+" ,	tipe_file"
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
		+" ,	jra"
		+" )"
		+" select "
		+		pid
		+" ,	1"
		+" ,	'"+	name +"'"
		+" ,	"+ user_id
		+" ,	"+ uk_id
		+" ,	berkas_klas_id"
		+" ,	berkas_tipe_id"
		+" ,	tgl_dibuat"
		+" ,	nomor"
		+" ,	pembuat"
		+" ,	judul"
		+" ,	masalah"
		+" ,	jra"
		+" from		m_berkas "
		+" where	id = "+ pid;

	db_stmt.executeUpdate (q);

	out.print ("{success:true,info:'File telah tersimpan.'}");
} catch (Exception e) {
	out.print ("{success:false,info:'"
			+ e.toString ().replace ("'","\\'").replace ("\"","\\\"") +"'}");
}
%>
