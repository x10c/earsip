<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
String		data		= "";
String		user_id		= "";
String		arsip_id	= "";
int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	user_id		= (String) session.getAttribute ("user.id");
	arsip_id	= request.getParameter ("arsip_id");

	q	=" select	id"
		+" ,		pid"
		+" ,		node_type"
		+" ,		name"
		+" ,		date_created"
		+" ,		arsip_tipe_id"
		+" ,		status"
		+" ,		jra"
		+" ,		kode_rak"
		+" ,		kode_box"
		+" from		m_arsip"
		+" where	user_id = "+ user_id
		+" and		pid		= "+ arsip_id
		+" order by	node_type, name";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id            : "+ rs.getString ("id")
				+ "\n, pid           : "+ rs.getString ("pid")
				+ "\n, node_type     : "+ rs.getString ("node_type")
				+ "\n, name          :'"+ rs.getString ("name") +"'"
				+ "\n, date_created  :'"+ rs.getString ("date_created") +"'"
				+ "\n, arsip_tipe_id : "+ rs.getString ("arsip_tipe_id")
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n, jra           : "+ rs.getString ("jra")
				+ "\n, kode_rak      :'"+ rs.getString ("kode_rak") +"'"
				+ "\n, kode_box      :'"+ rs.getString ("kode_box") +"'"
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
