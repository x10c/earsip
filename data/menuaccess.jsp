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

	q	=" select	MENU.id"
		+" ,		MENU.pid"
		+" ,		MENU.nama"
		+" ,		MENU.nama_ref"
		+" ,		MAKSES.hak_akses_id"
		+" from		m_menu		MENU"
		+" ,		menu_akses	MAKSES"
		+" where	MENU.id			= MAKSES.menu_id"
		+" and		MAKSES.grup_id	= ?"
		+" order by MENU.id, MENU.pid";

	db_stmt = db_con.prepareStatement (q);
	db_stmt.setInt (1, user_id);

	rs = db_stmt.executeQuery ();

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ menu_id	: "+ rs.getString ("id")
				+ ", menu_pid	: "+ rs.getString ("pid")
				+ ", menu_name	:'"+ rs.getString ("nama") +"'"
				+ ", menu_ref	:'"+ rs.getString ("nama_ref") +"'"
				+ ", user_id	: "+ user_id
				+ ", hak_akses	: "+ rs.getString ("hak_akses_id")
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
