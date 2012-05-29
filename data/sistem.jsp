<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con				= null;
Statement			db_stmt				= null;
ResultSet			rs					= null;
String				db_url				= "";
String				q					= "";
String				data				= "";
int					i					= 0;
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

	q	=" select	repository_root"
		+" ,		max_upload_size"
		+" from		m_sysconfig";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	if (! rs.next ()) {
		out.print ("{success:true,data:{"+ data +"}}");
		return;
	}

	data	+=" repository_root : '"+ rs.getString ("repository_root") +"'"
			+ ",max_upload_size : "+ rs.getString ("max_upload_size");

	out.print ("{success:true,data:{"+ data +"}}");
	rs.close ();
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
