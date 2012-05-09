<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection			db_con		= null;
PreparedStatement	db_stmt		= null;
PreparedStatement	mc_stmt		= null;
ResultSet			rs			= null;
ResultSet			mc_rs		= null;
String				q			= "";
String				db_url		= "";
int					grup_id		= 0;
String				menu		= "";
int					menu_id		= 0;
String				menu_name	= "";
String				menu_index	= "";
String				menu_acl	= "";
String				tmp			= "";
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

	tmp	= (String) session.getAttribute ("user.grup_id");
	if (tmp == null) {
		out.print ("{success:false,info:'User ID tidak diketahui!'}");
		return;
	}
	grup_id	= Integer.parseInt (tmp);

	q	=" select	MENU.id"
		+" ,		MENU.nama"
		+" ,		MENU.icon"
		+" ,		MENU.nama_ref"
		+" ,		MAKSES.hak_akses_id"
		+" from		m_menu		MENU"
		+" ,		menu_akses	MAKSES"
		+" where	MENU.id				= MAKSES.menu_id"
		+" and		MAKSES.grup_id		= ?"
		+" and		MAKSES.hak_akses_id > 0"
		+" and		MENU.pid			= ?";

	db_stmt = db_con.prepareStatement (q);

	db_stmt.setInt (1, grup_id);
	db_stmt.setInt (2, 0);

	rs = db_stmt.executeQuery ();

	while (rs.next ()) {
		menu_id		= rs.getInt ("id");
		menu_name	= rs.getString ("nama");
		menu_index	= rs.getString ("nama_ref");

		menu	+="\n\t{ text:'"+ menu_name +"'\n"
				+ "\t, itemId:'"+ menu_index +"'\n"
				+ "\t, iconCls:'"+ rs.getString ("icon") +"'\n";

		mc_stmt = db_con.prepareStatement (q);
		mc_stmt.setInt (1, grup_id);
		mc_stmt.setInt (2, menu_id);

		mc_rs = mc_stmt.executeQuery ();

		if (mc_rs.next ()) {
			menu	+="\t, menu:{\n"
					+ "\t\t  xtype : 'menu'\n"
					+ "\t\t, items : [\n";

			do {
				menu_id		= mc_rs.getInt ("id");
				menu_name	= mc_rs.getString ("nama");
				menu_index	= mc_rs.getString ("nama_ref");
				menu_acl	= mc_rs.getString ("hak_akses_id");

				menu	+="\t\t\t{ text:'"+ menu_name +"'\n"
						+ "\t\t\t, itemId:'"+ menu_index +"'\n"
						+ "\t\t\t, acl:'"+ menu_acl +"'\n"
						+ "\t\t\t, iconCls:'"+ mc_rs.getString ("icon") +"'\n"
						+ "\t\t\t},\n";
			} while (mc_rs.next ());

			menu	+="\t\t]}\n";
		}
		menu	+="\t},\n";
	}

	out.print ("{success:true,menu:["+ menu +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
