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
	String	kode_rak	= request.getParameter ("kode_rak");
	String	kode_box	= request.getParameter ("kode_box");
	String	kode_folder	= request.getParameter ("kode_folder");

	q	=" update	m_arsip"
		+" set		kode_rak		= ?"
		+" ,		kode_box		= ?"
		+" ,		kode_folder		= ?"
		+" where	berkas_id		= ?";

	db_stmt	= db_con.prepareStatement (q);

	db_stmt.setString	(1, kode_rak);
	db_stmt.setString	(2, kode_box);
	db_stmt.setString	(3, kode_folder);
	db_stmt.setInt		(4, id);

	db_stmt.executeUpdate ();

	out.print ("{success:true,info:'Data arsip telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
