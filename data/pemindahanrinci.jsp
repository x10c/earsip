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
	String pemindahan_id	= request.getParameter ("pemindahan_id");
	
		q	=" SELECT	A.pemindahan_id"
			+" ,		A.berkas_id"
			+" ,		B.nama"
			+" ,		B.status"
			+" ,		B.arsip_status_id"
			+" ,		C.kode_folder"
			+" ,		C.kode_rak"
			+" ,		C.kode_box"
			+" FROM		t_pemindahan_rinci A"
			+" LEFT JOIN	m_berkas B"
			+" ON			A.berkas_id = B.id"
			+" LEFT	JOIN	m_arsip C"
			+" ON			B.id = C.berkas_id"
			+" WHERE		A.pemindahan_id = "+ pemindahan_id
			+" ORDER BY B.nama";
	
	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ pemindahan_id	: "+ rs.getString ("pemindahan_id")
				+ "\n, berkas_id	: "+ rs.getString ("berkas_id")
				+ "\n, nama	: '"+ rs.getString ("nama") + "'"
				+ "\n, status	: "+ rs.getString ("status")
				+ "\n, arsip_status_id	: "+ rs.getString ("arsip_status_id") 
				+ "\n, kode_folder	: '"+ rs.getString ("kode_folder") + "'"
				+ "\n, kode_rak	: '"+ rs.getString ("kode_rak") + "'"
				+ "\n, kode_box	: '"+ rs.getString ("kode_box") + "'"
				+ "\n}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
