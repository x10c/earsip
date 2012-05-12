<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
String		db_url		= "";
String		data		= "";
int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath ());
		return;
	}

	q	=" select	id"
		+" ,		kode"
		+" ,		nama"
		+" ,		nama_pimpinan"
		+" ,		keterangan"
		+" from		m_unit_kerja"
		+" order by id";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id				: "+ rs.getString ("id")
				+ "\n, kode				:'"+ rs.getString ("kode") +"'"
				+ "\n, nama				:'"+ rs.getString ("nama") +"'"
				+ "\n, nama_pimpinan	:'"+ rs.getString ("nama_pimpinan") +"'"
				+ "\n, keterangan		:'"+ rs.getString ("keterangan") +"'"
				+ "\n}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
