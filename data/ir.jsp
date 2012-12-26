<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con			= null;
Statement	db_stmt			= null;
ResultSet	rs				= null;
String		q				= "";
String		db_url			= "";
String		data			= "";

int			i				= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath ());
		return;
	}
	
	String unit_kerja_id = (String) session.getAttribute ("user.unit_kerja_id");
	q	=" select	A.id"
		+" ,		A.berkas_klas_id"
		+" ,		A.keterangan"
		+" from		r_ir A"
		+" left join r_berkas_klas B on A.berkas_klas_id = B.id"
		+" where B.unit_kerja_id = " + unit_kerja_id
		+" order by berkas_klas_id, keterangan";

	db_stmt = db_con.createStatement ();
	rs = db_stmt.executeQuery (q);
	

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ id : "+ rs.getString ("id")
				+ ", berkas_klas_id	: "+ rs.getString ("berkas_klas_id")
				+ ", keterangan :'"+ rs.getString ("keterangan") +"'"
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
