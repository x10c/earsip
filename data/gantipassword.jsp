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

	String user_nip		= (String) session.getAttribute ("user.nip");
	String old_psw		= request.getParameter ("old_psw");
	String new_psw		= request.getParameter ("new_psw");
	String conf_psw		= request.getParameter ("conf_psw");

	if (! new_psw.equals (conf_psw)){
		out.print ("{success:false,info:'Konfirmasi Password tidak sama dengan Password Baru'}");
		return;
	}

	/* matching old password (input) with password(database)*/
	q	=" select 	id"
		+" from		m_pegawai"
		+" where	nip = ?"
		+" and		psw = MD5(?)";

	db_stmt = db_con.prepareStatement (q);
	db_stmt.setString (1, user_nip);
	db_stmt.setString (2, old_psw);

	rs = db_stmt.executeQuery ();
	if (! rs.next ()) {
		out.print (	"{success:false,info:'Password lama anda salah'}");
		return;
	}

	/* update password in database*/
	String user_id = rs.getString("id");

	q	=" update 	m_pegawai"
		+" set		psw = MD5(?)"
		+" ,		psw_expire = current_date + 30"
		+" where	id	= ?";

	db_stmt = db_con.prepareStatement (q);
	db_stmt.setString (1, conf_psw);
	db_stmt.setInt (2, Integer.parseInt (user_id));

	db_stmt.executeUpdate ();
	out.print ("{success:true, info:'Password berhasil diganti!'}");
	rs.close();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
