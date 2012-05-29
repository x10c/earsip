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

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	Enumeration<String>	params			= request.getParameterNames ();
	String				repo_root		= request.getParameter ("repository_root");
	String				max_upload_size	= request.getParameter ("max_upload_size");

	db_stmt = db_con.createStatement ();

	q	=" update	m_sysconfig"
		+" set ";

	if (repo_root != null) {
		q += " repository_root = '"+ repo_root +"'";

		session.setAttribute ("sys.repository_root", repo_root);
	}
	if (max_upload_size != null) {
		q += ", max_upload_size = "+ max_upload_size;

		session.setAttribute ("sys.max_upload_size", max_upload_size);
	}

	db_stmt.executeUpdate (q);
	out.print ("{success:true, data:{"
				+" repository_root:'"+ repo_root +"'"
				+",max_upload_size:"+ max_upload_size
				+"}}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
