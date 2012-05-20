<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%
Connection			db_con	= null;
PreparedStatement	db_stmt	= null;
String				db_url	= "";
String				q		= "";
String				data	= "";

BufferedReader	reader		= null;
StringBuilder	sb			= new StringBuilder();
JSONObject		o			= null;
String			line		= "";
String			action		= "";

String			pemindahan_id	= "";
String			berkas_id		= "";

try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	action	= request.getParameter ("action");

	pemindahan_id	= request.getParameter ("pemindahan_id");
	berkas_id		= request.getParameter ("berkas_id");

		
	

	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into t_pemindahan_rinci (pemindahan_id, berkas_id)"
			+" values (?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (pemindahan_id));
		db_stmt.setInt (2, Integer.parseInt (berkas_id));

	} else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from t_pemindahan_rinci where pemindahan_id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (pemindahan_id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true,info:'Data Berkas berhasil disimnpan'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
