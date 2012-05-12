<%@ page import="java.io.File" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con		= null;
PreparedStatement	db_stmt		= null;
ResultSet			rs			= null;
String				q			= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	String user_id		= (String) session.getAttribute ("user.id");
	String uk_id		= (String) session.getAttribute ("user.unit_kerja_id");
	String dir_id		= request.getParameter ("dir_id");
	String nama			= request.getParameter ("nama");
	String tgl_dibuat	= request.getParameter ("tgl_dibuat");
	String klas_id		= request.getParameter ("berkas_klas_id");
	String tipe_id		= request.getParameter ("berkas_tipe_id");
	String nomor		= request.getParameter ("nomor");
	String judul		= request.getParameter ("judul");
	String pembuat		= request.getParameter ("pembuat");
	String masalah		= request.getParameter ("masalah");
	String jra			= request.getParameter ("jra");
	Date dt_dibuat		= Date.valueOf (tgl_dibuat);

	q	=" insert into m_berkas ("
		+"		pid"
		+" ,	pegawai_id"
		+" ,	unit_kerja_id"
		+" ,	nama"
		+" ,	tgl_dibuat"
		+" ,	berkas_klas_id"
		+" ,	berkas_tipe_id"
		+" ,	nomor"
		+" ,	judul"
		+" ,	pembuat"
		+" ,	masalah"
		+" ,	jra)"
		+" values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	db_stmt = db_con.prepareStatement (q);

	db_stmt.setInt (1, Integer.parseInt (dir_id));
	db_stmt.setInt (2, Integer.parseInt (user_id));
	db_stmt.setInt (3, Integer.parseInt (uk_id));
	db_stmt.setString (4, nama);
	db_stmt.setDate (5, dt_dibuat);
	db_stmt.setInt (6, Integer.parseInt (klas_id));
	db_stmt.setInt (7, Integer.parseInt (tipe_id));
	db_stmt.setString (8, nomor);
	db_stmt.setString (9, judul);
	db_stmt.setString (10, pembuat);
	db_stmt.setString (11, masalah);
	db_stmt.setInt (12, Integer.parseInt (jra));

	db_stmt.executeUpdate ();

	out.print ("{success:true}");
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
