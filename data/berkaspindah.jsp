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
int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	String user_id		= (String) session.getAttribute ("user.id");
	
	
	
	q	=" SELECT	id"
		+" ,		pegawai_id"
		+" ,		unit_kerja_id"
		+" ,		nama"
		+" ,		status"
		+" FROM		m_berkas A"
		+" WHERE	id NOT IN (SELECT berkas_id AS id FROM t_pemindahan_rinci)"
		+" AND 		pegawai_id		= "+ user_id
		+" AND		status_hapus	= 1"
		+" AND 		unit_kerja_id	IS NOT null"
		+" ORDER BY nama";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	
	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id            : "+ rs.getString ("id")
				+ "\n, pegawai_id    : "+ rs.getString ("pegawai_id")
				+ "\n, unit_kerja_id : "+ rs.getString ("unit_kerja_id")
				+ "\n, nama          :'"+ rs.getString ("nama") +"'"
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
