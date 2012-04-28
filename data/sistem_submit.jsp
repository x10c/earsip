<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		db_url		= "";
String		p			= "";
String		q			= "";
String		data		= "";
int			i			= 0;
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

	Enumeration<String>	params		= request.getParameterNames ();
	String				repo_root	= request.getParameter ("repository_root");

	db_stmt = db_con.createStatement ();

	q	=" update	m_sysconfig"
		+" set ";

	if (repo_root != null) {
		q += " repository_root = '"+ repo_root +"'";

		session.setAttribute ("sys.repository_root", repo_root);
	}

	db_stmt.executeUpdate (q);
	out.print ("{success:true}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
