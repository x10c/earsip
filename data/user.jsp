<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
String		db_url		= "";
String		data		= "";

int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || db_con.isClosed ()) {
		db_url = (String) session.getAttribute ("db.url");
		if (db_url == null) {
			response.sendRedirect (request.getContextPath ());
			return;
		}

		Class.forName ((String) session.getAttribute ("db.class"));

		db_con = DriverManager.getConnection (db_url);

		session.setAttribute ("db.con", (Object) db_con);
	}

	db_stmt = db_con.createStatement ();

	q	=" select	A.user_id"
		+" ,		B.div_id"
		+" ,		A.subdiv_id"
		+" ,		A.user_nip"
		+" ,		A.user_name"
		+" from		m_user		A"
		+" ,		m_subdiv	B"
		+" where	A.subdiv_id = B.subdiv_id";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data	+="{ user_id	: "+ rs.getString ("user_id")
				+ ", div_id		: "+ rs.getString ("div_id")
				+ ", subdiv_id	: "+ rs.getString ("subdiv_id")
				+ ", user_nip	: "+ rs.getString ("user_nip")
				+ ", user_name	:'"+ rs.getString ("user_name") +"'"
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
