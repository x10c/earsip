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
		+" ,		tipe_file"
		+" ,		nama"
		+" ,		tgl_unggah"
		+" ,		berkas_tipe_id"
		+" ,		status"
		+" ,		jra"
		+" from		m_berkas"
		+" where	pegawai_id	= "+ user_id
		+" and		pid			= "+ arsip_id
		+" order by tipe_file, nama";

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
				+ "\n, node_type     : "+ rs.getString ("tipe_file")
				+ "\n, name          :'"+ rs.getString ("nama") +"'"
				+ "\n, date_created  :'"+ rs.getString ("tgl_unggah") +"'"
				+ "\n, arsip_tipe_id : "+ rs.getString ("berkas_tipe_id")
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n, jra           : "+ rs.getString ("jra")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
