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
	
	String user_id = (String) session.getAttribute ("user.id");
	String grup_id = (String) session.getAttribute ("user.grup_id");
	
		q	=" select	id"
			+" ,		unit_kerja_id"
			+" ,		kode"
			+" ,		tgl"
			+" ,		nama_petugas"
			+" ,		pj_unit_kerja"
			+" ,		pj_unit_arsip"
			+" ,		status"
			+" from		t_pemindahan";
			
	if (!grup_id.equals ("3")) // if not Pusat Arsip
	{
		q	+=" where	unit_kerja_id = (select A.unit_kerja_id as id"
			+"  from 	m_pegawai A where A.id = "+ user_id +")"
			+"  order by tgl desc";
	} else 
	{
		q	+=" right join t_pemindahan_rinci"
			+" 	on	id = pemindahan_id"
			+"  order by tgl desc";
	}

	

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
				+ ", kode			:'"+ rs.getString ("kode") +"'"
				+ ", tgl			:'"+ rs.getString ("tgl") +"'"
				+ ", status			: "+ rs.getString ("status")
				+ ", nama_petugas	:'"+ rs.getString ("nama_petugas") +"'"
				+ ", pj_unit_kerja	:'"+ rs.getString ("pj_unit_kerja") +"'"
				+ ", pj_unit_arsip	:'"+ rs.getString ("pj_unit_arsip") +"'"
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
