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
		+" , 		unit_kerja_id"
		+" , 		kode"
		+" , 		nama"
		+" , 		keterangan"
		+" ,		jra_aktif"
		+" ,		jra_inaktif"
		+" from 	r_berkas_klas"
		+" order by nama";

	db_stmt = db_con.createStatement ();
	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id			: "+ rs.getString ("id")
				+ "\n, unit_kerja_id: "+ rs.getString ("unit_kerja_id")
				+ "\n, kode			:'"+ rs.getString ("kode") +"'"
				+ "\n, nama			:'"+ rs.getString ("nama") +"'"
				+ "\n, keterangan	:'"+ rs.getString ("keterangan") +"'"
				+ "\n, jra_aktif	: "+ rs.getString ("jra_aktif")
				+ "\n, jra_inaktif  : "+ rs.getString ("jra_inaktif")
				+ "\n}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
