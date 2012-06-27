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

	int		user_id		= Integer.parseInt ((String) session.getAttribute ("user.id"));
	int		uk_id		= Integer.parseInt ((String) session.getAttribute ("user.unit_kerja_id"));
	int		dir_id		= Integer.parseInt (request.getParameter ("berkas_id"));
	String nama			= request.getParameter ("nama");
	String tgl_dibuat	= request.getParameter ("tgl_dibuat");
	int		klas_id		= Integer.parseInt (request.getParameter ("berkas_klas_id"));
	int		tipe_id		= Integer.parseInt (request.getParameter ("berkas_tipe_id"));
	String nomor		= request.getParameter ("nomor");
	String judul		= request.getParameter ("judul");
	String pembuat		= request.getParameter ("pembuat");
	String masalah		= request.getParameter ("masalah");
	int		jra_aktif	= Integer.parseInt (request.getParameter ("jra_aktif"));
	int		jra_inaktif	= Integer.parseInt (request.getParameter ("jra_inaktif"));
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
		+" ,	jra_aktif"
		+" ,	jra_inaktif)"
		+" values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	db_stmt = db_con.prepareStatement (q);

	db_stmt.setInt (1, dir_id);
	db_stmt.setInt (2, user_id);
	db_stmt.setInt (3, uk_id);
	db_stmt.setString (4, nama);
	db_stmt.setDate (5, dt_dibuat);
	db_stmt.setInt (6, klas_id);
	db_stmt.setInt (7, tipe_id);
	db_stmt.setString (8, nomor);
	db_stmt.setString (9, judul);
	db_stmt.setString (10, pembuat);
	db_stmt.setString (11, masalah);
	db_stmt.setInt (12, jra_aktif);
	db_stmt.setInt (13, jra_inaktif);

	db_stmt.executeUpdate ();

	out.print ("{success:true}");
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
