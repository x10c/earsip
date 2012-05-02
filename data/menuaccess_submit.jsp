<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%
Connection	db_con	= null;
Statement	db_stmt	= null;
String		db_url	= "";
String		q		= "";
String		data	= "";

BufferedReader	reader			= null;
StringBuilder	sb				= new StringBuilder();
JSONObject		o				= null;
String			line			= "";
String			action			= "";
String			menu_id			= "";
String			access_level	= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || db_con.isClosed ()) {
		db_url = (String) session.getAttribute ("db.url");

		if (db_url == null) {
			response.sendRedirect(request.getContextPath());
			return;
		}

		Class.forName ((String) session.getAttribute ("db.class"));

		db_con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) db_con);
	}

	reader	= request.getReader();
	line	= reader.readLine();
	while (line != null) {
		sb.append(line + "\n");
		line = reader.readLine();
	}
	reader.close();

	data			= sb.toString();
	o				= (JSONObject) new JSONObject (data);
	menu_id			= o.getString ("menu_id");
	access_level	= o.getString ("hak_akses");
	action			= (String) request.getParameter ("action");

	if (action.equalsIgnoreCase ("update")) {
		q	=" update	menu_akses"
			+" set		hak_akses_id	= "+ access_level
			+" where	menu_id			= "+ menu_id;
	}

	db_stmt	= db_con.createStatement();
	db_stmt.executeUpdate (q);

	out.print ("{success:true}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
