<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con		= null;
PreparedStatement	db_stmt		= null;
ResultSet			rs			= null;
String				q			= "";
String				db_url		= "";
String				data		= "";
int					i			= 0;

String				user_id_s	= "";
int					user_id		= 0;
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

	user_id_s = request.getParameter ("user_id");
	if (user_id_s == null) {
		user_id_s	= (String) session.getAttribute ("user.id");
		if (user_id_s == null) {
			out.print ("{success:false,info:'User ID tidak diketahui!'}");
			return;
		}
	}
	user_id	= Integer.parseInt (user_id_s);

	q	=" select	A.menu_id"
		+" ,		A.menu_parent_id"
		+" ,		A.menu_name"
		+" ,		A.menu_index"
		+" ,		B.access_level"
		+" from		m_menu		A"
		+" ,		menu_access	B"
		+" where	A.menu_id	= B.menu_id"
		+" and		B.user_id	= ?"
		+" order by A.menu_id, A.menu_parent_id";

	db_stmt = db_con.prepareStatement (q);
	db_stmt.setInt (1, user_id);

	rs = db_stmt.executeQuery ();

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ menu_id		: "+ rs.getString ("menu_id")
				+ ", menu_parent_id	: "+ rs.getString ("menu_parent_id")
				+ ", menu_name		:'"+ rs.getString ("menu_name") +"'"
				+ ", menu_index		:'"+ rs.getString ("menu_index") +"'"
				+ ", user_id		: "+ user_id
				+ ", access_level	: "+ rs.getString ("access_level")
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
