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
		+" ,		unit_kerja_id"
		+" ,		grup_id"
		+" ,		jabatan_id"
		+" ,		nip"
		+" ,		nama"
		+" ,		status"
		+" from		m_pegawai"
		+" order by nama";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ id				: "+ rs.getString ("id")
				+ ", unit_kerja_id	: "+ rs.getString ("unit_kerja_id")
				+ ", grup_id		: "+ rs.getString ("grup_id")
				+ ", jabatan_id		: "+ rs.getString ("jabatan_id")
				+ ", nip			:'"+ rs.getString ("nip") +"'"
				+ ", nama			:'"+ rs.getString ("nama") +"'"
				+ ", password		:''"
				+ ", status			: "+ rs.getString ("status")
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
