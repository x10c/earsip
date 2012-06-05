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
	String	user_id	= (String) session.getAttribute ("user.id");
	String	grup_id	= (String) session.getAttribute ("user.grup_id");
	q	=" select		distinct (A.id)"
		+" ,			A.metoda_id"
		+" ,			A.nama_petugas"
		+" ,			A.tgl"
		+" ,			A.pj_unit_kerja"
		+" ,			A.pj_berkas_arsip"
		+" from			t_pemusnahan A"
		+" left join	t_pemusnahan_rinci B "
		+" on			A.id = B.pemusnahan_id" 
		+" left join	m_berkas C"
		+" on 			C.id = B.berkas_id"
		+" where";
		if (Integer.parseInt (grup_id)== 3){ 
			q +=" C.status = 0";
		}else
		{
			q +=" C.status = 1"
			  +" and C.pegawai_id = " + user_id;
		}
		
		
	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id						: "+ rs.getString ("id")
				+ "\n, metoda_id				: "+ rs.getString ("metoda_id")
				+ "\n, nama_petugas				:'"+ rs.getString ("nama_petugas") +"'"
				+ "\n, tgl						:'"+ rs.getString ("tgl") +"'"
				+ "\n, pj_unit_kerja			:'"+ rs.getString ("pj_unit_kerja") +"'"
				+ "\n, pj_berkas_arsip			:'"+ rs.getString ("pj_berkas_arsip") +"'"
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
