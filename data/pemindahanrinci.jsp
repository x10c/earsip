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
	
		q	=" select	A.pemindahan_id"
			+" ,		B.nama"
			+" from		t_pemindahan_rinci A"
			+" left join m_berkas B"
			+" on 		A.berkas_id = B.id"
			+" where	pemindahan_id = "+pemindahan_id
			+" order by B.nama";
	

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="{ pemindahan_id	: "+ rs.getString ("pemindahan_id")
				+ ", berkas_nama	: '"+ rs.getString ("nama") + "'"
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
