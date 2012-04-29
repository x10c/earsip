<%@ page import="java.io.File" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con		= null;
PreparedStatement	db_stmt		= null;
ResultSet			rs			= null;
String				q			= "";
String				user_id		= "";
String				pid			= "";
String				name		= "";
String				repo_root	= "";
String				path		= "";
File				new_dir		= null;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	user_id		= (String) session.getAttribute ("user.id");
	repo_root	= (String) session.getAttribute ("sys.repository_root");
	pid			= request.getParameter ("pid");
	name		= request.getParameter ("name");
	path		= request.getParameter ("path");

	new_dir = new File (config.getServletContext().getRealPath("/")
						+ repo_root +"/"+ path +"/"+ name);
	new_dir.mkdir ();

	q	=" insert into m_arsip (pid, name, user_id)"
		+" values (?, ?, ?)";

	db_stmt = db_con.prepareStatement (q);

	db_stmt.setInt (1, Integer.parseInt (pid));
	db_stmt.setString (2, name);
	db_stmt.setInt (3, Integer.parseInt (user_id));

	db_stmt.executeUpdate ();

	out.print ("{success:true}");
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
