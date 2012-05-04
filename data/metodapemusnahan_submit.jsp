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

String			id			= "";
String			nama		= "";
String			ket			= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	action	= request.getParameter ("action");

	reader	= request.getReader ();
	line	= reader.readLine ();
	while (line != null) {
		sb.append (line + "\n");
		line = reader.readLine();
	}
	reader.close();

	data			= sb.toString();
	o				= (JSONObject) new JSONObject (data);


	id		= o.getString ("id");
	nama	= o.getString ("nama");
	ket		= o.getString ("keterangan");

	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into r_pemusnahan_metoda (nama, keterangan)"
			+" values (?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setString (1, nama);
		db_stmt.setString (2, ket);

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	r_pemusnahan_metoda "
			+" set		nama		= ?"
			+" ,		keterangan	= ?"
			+" where	id			= ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setString (1, nama);
		db_stmt.setString (2, ket);
		db_stmt.setInt (3, Integer.parseInt (id));

	} else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from r_pemusnahan_metoda where id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
