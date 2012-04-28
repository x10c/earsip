<%@ page import="java.io.File" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con				= null;
PreparedStatement	db_pstmt			= null;
Statement			db_stmt				= null;
ResultSet			rs					= null;
Cookie				c_sid				= null;
Cookie				c_user_id			= null;
Cookie				c_user_div_id		= null;
Cookie				c_user_subdiv_id	= null;
Cookie				c_user_nip			= null;
Cookie				c_user_name			= null;
String				db_url				= "";
String				q					= "";
String				sid					= "";
String				repo_root			= "";
String				user_id				= "";
String				user_div_id			= "";
String				user_subdiv_id		= "";
String				user_name			= "";
String				user_nip			= "";
String				user_psw			= "";
String				user_dir			= "";
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

	q	=" select	A.user_id"
		+" ,		B.div_id"
		+" ,		A.subdiv_id"
		+" ,		A.user_name"
		+" from		m_user		A"
		+" ,		m_subdiv	B"
		+" where	A.user_nip	= ?"
		+" and		A.user_psw	= ?"
		+" and		A.subdiv_id	= B.subdiv_id";

	db_pstmt = db_con.prepareStatement (q);
	db_pstmt.setString (1, user_nip);
	db_pstmt.setString (2, user_psw);

	rs = db_pstmt.executeQuery ();

	if (! rs.next ()) {
		out.print (	"{success:false,info:'Password anda salah!'}");
		return;
	}

	user_id			= rs.getString ("user_id");
	user_div_id		= rs.getString ("div_id");
	user_subdiv_id	= rs.getString ("subdiv_id");
	user_name		= rs.getString ("user_name");

	session.setAttribute ("user.id", user_id);
	session.setAttribute ("user.div_id", user_id);
	session.setAttribute ("user.subdiv_id", user_subdiv_id);
	session.setAttribute ("user.name", user_name);
	session.setAttribute ("user.nip", user_nip);

	c_sid				= new Cookie ("earsip.sid", session.getId ());
	c_user_id			= new Cookie ("earsip.user.id", user_id);
	c_user_nip			= new Cookie ("earsip.user.nip", user_nip);
	c_user_div_id		= new Cookie ("earsip.user.div_id", user_div_id);
	c_user_subdiv_id	= new Cookie ("earsip.user.subdiv_id", user_subdiv_id);
	c_user_name			= new Cookie ("earsip.user.name", user_name);

	c_sid.setMaxAge (c_max_age);
	c_sid.setPath (c_path);
	c_user_id.setMaxAge (c_max_age);
	c_user_id.setPath (c_path);
	c_user_nip.setMaxAge (c_max_age);
	c_user_nip.setPath (c_path);
	c_user_div_id.setMaxAge (c_max_age);
	c_user_div_id.setPath (c_path);
	c_user_subdiv_id.setMaxAge (c_max_age);
	c_user_subdiv_id.setPath (c_path);
	c_user_name.setMaxAge (c_max_age);
	c_user_name.setPath (c_path);

	response.addCookie (c_sid);
	response.addCookie (c_user_id);
	response.addCookie (c_user_nip);
	response.addCookie (c_user_div_id);
	response.addCookie (c_user_subdiv_id);
	response.addCookie (c_user_name);

	/* create user repository if it doesn't exist yet */
	repo_root = (String) session.getAttribute ("sys.repository_root");

	if (repo_root != null) {
		user_dir	= config.getServletContext().getRealPath("/") + repo_root +"/"+ user_nip;
		File d		= new File (user_dir);

		d.mkdir ();

		q	=" select	dir_id"
			+" from		m_direktori"
			+" where	dir_name		='"+ user_nip +"'"
			+" and		parent_dir_id	= 0";

		db_stmt = db_con.createStatement ();

		rs = db_stmt.executeQuery (q);

		if (! rs.next ()) {
			q	=" insert into m_direktori (parent_dir_id, user_id, dir_name)"
				+" values (0, "+ user_id +",'"+ user_nip +"')";

			db_stmt.executeUpdate (q);
		}
	}

	out.print ("{success:true, user_dir:'"+ user_dir +"'}");
	rs.close ();
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
