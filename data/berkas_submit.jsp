<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con	= null;
PreparedStatement	db_stmt	= null;
String				db_url	= "";
String				q		= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	String	id			= request.getParameter ("id");
	String	nama		= request.getParameter ("nama");
	String	tgl_dibuat	= request.getParameter ("tgl_dibuat");
	String	klas_id		= request.getParameter ("berkas_klas_id");
	String	tipe_id		= request.getParameter ("berkas_tipe_id");
	String	nomor		= request.getParameter ("nomor");
	String	pembuat		= request.getParameter ("pembuat");
	String	judul		= request.getParameter ("judul");
	String	masalah		= request.getParameter ("masalah");
	String	jra			= request.getParameter ("jra");
	String	stat_hapus	= request.getParameter ("status_hapus");

	q	=" update	m_berkas"
		+" set		nama			= ?"
		+" ,		tgl_dibuat		= ?"
		+" ,		berkas_klas_id	= ?"
		+" ,		berkas_tipe_id	= ?"
		+" ,		nomor			= ?"
		+" ,		pembuat			= ?"
		+" ,		judul			= ?"
		+" ,		masalah			= ?"
		+" ,		jra				= ?"
		+" ,		status_hapus	= ?"
		+" where	id				= ?";

	db_stmt	= db_con.prepareStatement (q);

	db_stmt.setString	(1, nama);
	db_stmt.setDate		(2, Date.valueOf (tgl_dibuat));
	db_stmt.setInt		(3, Integer.parseInt (klas_id));
	db_stmt.setInt		(4, Integer.parseInt (tipe_id));
	db_stmt.setString	(5, nomor);
	db_stmt.setString	(6, pembuat);
	db_stmt.setString	(7, judul);
	db_stmt.setString	(8, masalah);
	db_stmt.setInt		(9, Integer.parseInt (jra));
	db_stmt.setInt		(10, Integer.parseInt (stat_hapus));
	db_stmt.setInt		(11, Integer.parseInt (id));

	db_stmt.executeUpdate ();

	out.print ("{success:true,info:'Data berkas telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
