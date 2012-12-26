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

	int		id			= Integer.parseInt (request.getParameter ("id"));
	String	nama		= request.getParameter ("nama");
	String	tgl_dibuat	= request.getParameter ("tgl_dibuat");
	int		klas_id		= Integer.parseInt (request.getParameter ("berkas_klas_id"));
	int		tipe_id		= Integer.parseInt (request.getParameter ("berkas_tipe_id"));
	String	nomor		= request.getParameter ("nomor");
	String	pembuat		= request.getParameter ("pembuat");
	String	judul		= request.getParameter ("judul");
	String	masalah		= request.getParameter ("masalah");
	int		jra_aktif	= Integer.parseInt (request.getParameter ("jra_aktif"));
	int		jra_inaktif	= Integer.parseInt (request.getParameter ("jra_inaktif"));
	int		stat_hapus	= Integer.parseInt (request.getParameter ("status_hapus"));
	int		tipe_file	= Integer.parseInt (request.getParameter ("tipe_file"));

	if (0 == stat_hapus) {
		q =" delete from m_berkas where pid = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, id);
		db_stmt.executeUpdate();

		q = " delete from m_berkas where id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, id);
		db_stmt.executeUpdate ();
	} else {
		q	=" update	m_berkas"
			+" set		nama			= ?"
			+" ,		tgl_dibuat		= ?"
			+" ,		berkas_klas_id	= ?"
			+" ,		berkas_tipe_id	= ?"
			+" ,		nomor			= ?"
			+" ,		pembuat			= ?"
			+" ,		judul			= ?"
			+" ,		masalah			= ?"
			+" ,		jra_aktif		= ?"
			+" ,		jra_inaktif		= ?"
			+" ,		status_hapus	= ?"
			+" where	id				= ?";

		db_stmt	= db_con.prepareStatement (q);

		db_stmt.setString	(1, nama);
		db_stmt.setDate		(2, Date.valueOf (tgl_dibuat));
		db_stmt.setInt		(3, klas_id);
		db_stmt.setInt		(4, tipe_id);
		db_stmt.setString	(5, nomor);
		db_stmt.setString	(6, pembuat);
		db_stmt.setString	(7, judul);
		db_stmt.setString	(8, masalah);
		db_stmt.setInt		(9, jra_aktif);
		db_stmt.setInt		(10, jra_inaktif);
		db_stmt.setInt		(11, stat_hapus);
		db_stmt.setInt		(12, id);

		db_stmt.executeUpdate ();
	}

	db_stmt.close ();

	out.print ("{success:true,info:'Data berkas telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
