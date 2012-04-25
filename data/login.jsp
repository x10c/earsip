<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con				= null;
PreparedStatement	db_stmt				= null;
ResultSet			rs					= null;
Cookie				c_sid				= null;
Cookie				c_user_subdiv_id	= null;
Cookie				c_user_id			= null;
Cookie				c_user_nip			= null;
Cookie				c_user_name			= null;
String				db_url				= "";
String				q					= "";
String				sid					= "";
String				user_id				= "";
String				user_subdiv_id		= "";
String				user_name			= "";
String				user_nip			= "";
String				user_psw			= "";
String				c_path				= request.getContextPath ();
int					c_max_age			= 60 * 60 * 24 * 30;
try {
	user_nip	= request.getParameter ("user_nip");
	user_psw	= request.getParameter ("user_psw");
	db_con		= (Connection) session.getAttribute ("db.con");

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

	q	=" select	user_id"
		+" ,		subdiv_id"
		+" ,		user_name"
		+" from		m_user"
		+" where	user_nip	= ?"
		+" and		user_psw	= ?";

	db_stmt = db_con.prepareStatement (q);
	db_stmt.setString (1, user_nip);
	db_stmt.setString (2, user_psw);

	rs = db_stmt.executeQuery ();

	if (! rs.next ()) {
		out.print (	"{success:false,info:'Password anda salah!'}");
		return;
	}

	user_id			= rs.getString ("user_id");
	user_subdiv_id	= rs.getString ("subdiv_id");
	user_name		= rs.getString ("user_name");

	session.setAttribute ("user.id", user_id);
	session.setAttribute ("user.subdiv_id", user_subdiv_id);
	session.setAttribute ("user.name", user_name);
	session.setAttribute ("user.nip", user_nip);

	c_sid				= new Cookie ("earsip.sid", session.getId ());
	c_user_id			= new Cookie ("earsip.user.id", user_id);
	c_user_nip			= new Cookie ("earsip.user.nip", user_nip);
	c_user_subdiv_id	= new Cookie ("earsip.user.subdiv_id", user_subdiv_id);
	c_user_name			= new Cookie ("earsip.user.name", user_name);

	c_sid.setMaxAge (c_max_age);
	c_sid.setPath (c_path);
	c_user_id.setMaxAge (c_max_age);
	c_user_id.setPath (c_path);
	c_user_nip.setMaxAge (c_max_age);
	c_user_nip.setPath (c_path);
	c_user_subdiv_id.setMaxAge (c_max_age);
	c_user_subdiv_id.setPath (c_path);
	c_user_name.setMaxAge (c_max_age);
	c_user_name.setPath (c_path);

	response.addCookie (c_sid);
	response.addCookie (c_user_id);
	response.addCookie (c_user_nip);
	response.addCookie (c_user_subdiv_id);
	response.addCookie (c_user_name);

	out.print ("{success:true}");
	rs.close ();
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
