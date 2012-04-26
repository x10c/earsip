<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%
Properties props = new Properties ();

props.load (new FileInputStream (application.getRealPath ("WEB-INF"+ File.separator +"web.conf")));

String		db_url		= props.getProperty ("db");
String		db_class	= props.getProperty ("db.class");

Class.forName (db_class);

Connection	db_con			= DriverManager.getConnection (db_url, props);
Statement	db_stmt			= db_con.createStatement ();
ResultSet	rs				= null;
Object		user			= session.getAttribute ("user.id");
Cookie[]	cookies			= request.getCookies ();
String		q				= "";
String		sid				= "";
String		c_name			= "";
String		repo_root		= "";
String		user_id			= null;
String		user_subdiv_id	= null;
String		user_name		= null;
String		user_nip		= null;
int			is_login		= 0;

/* get user cookies data */
if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		c_name = cookies[i].getName ();
		if (c_name.equalsIgnoreCase ("earsip.sid")) {
			sid				= cookies[i].getValue ();
			is_login		= 1;
		} else if (c_name.equalsIgnoreCase ("earsip.user.id")) {
			user_id			= cookies[i].getValue ();
		} else if (c_name.equalsIgnoreCase ("earsip.user.subdiv_id")) {
			user_subdiv_id	= cookies[i].getValue ();
		} else if (c_name.equalsIgnoreCase ("earsip.user.name")) {
			user_name		= cookies[i].getValue ();
		} else if (c_name.equalsIgnoreCase ("earsip.user.nip")) {
			user_nip		= cookies[i].getValue ();
		}
	}
}

/* load system config */
q	=" select repository_root from m_sysconfig";
rs	= db_stmt.executeQuery (q);

if (rs.next ()) {
	repo_root = rs.getString ("repository_root");

	if (repo_root != null) {
		session.setAttribute ("sys.repository_root", (Object) repo_root);
	}
}

session.setAttribute ("db.class", (Object) db_class);
session.setAttribute ("db.url", (Object) db_url);
session.setAttribute ("db.con", (Object) db_con);

if (user == null) {
	/* if user cookie exist then skip login window */
	if (user_id != null && user_subdiv_id != null && user_name != null
	&& user_nip != null) {
		session.setAttribute ("user.id", user_id);
		session.setAttribute ("user.subdiv_id", user_subdiv_id);
		session.setAttribute ("user.name", user_name);
		session.setAttribute ("user.nip", user_nip);
		is_login = 1;
	}
} else {
	is_login = 1;
}
%>
<html>
<head>
	<title>e-Arsip</title>
	<link rel="stylesheet" type="text/css" href="extjs/resources/css/ext-all.css">
	<script>
		var is_login = <%= is_login %>;
	</script>
	<script type="text/javascript" src="extjs/ext-all-debug.js"></script>
	<script type="text/javascript" src="app.js"></script>
</head>
<body>
</body>
</html>
