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
	String grup_id		= (String) session.getAttribute ("user.grup_id");
	
	q	=" select	id"
		+" ,		nama"
		+" ,		nomor"
		+" ,		pembuat"
		+" ,		judul"
		+" ,		masalah"
		+" ,		jra"
		+" ,		status"
		+" ,		status_hapus"
		+" ,		arsip_status_id"
		+" from		m_berkas";
		
	if (Integer.parseInt(grup_id) == 3) //  pusat arsip group
	{
		q 	+=" right join 	m_arsip"
			 +" on			m_berkas.id = m_arsip.berkas_id"
			 +" where 		status_hapus	= 1";
	}
	else
	{
		q 	+=" where 	status_hapus	= 1"
			 +" and 	petugas_id = " + user_id;
	}
	
	q	+=" and		unit_kerja_id is not null" // non root directory
		 +" order by nama";


	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	
	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{"
				+ "\nid            	 : "+ rs.getString ("id")
				+ "\n, nama          :'"+ rs.getString ("nama") +"'"
				+ "\n, nomor         :'"+ rs.getString ("nomor") +"'"
				+ "\n, pembuat       :'"+ rs.getString ("pembuat") +"'"
				+ "\n, judul         :'"+ rs.getString ("judul") +"'"
				+ "\n, masalah       :'"+ rs.getString ("masalah") +"'"
				+ "\n, jra           : "+ rs.getString ("jra")
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n, status_hapus  : "+ rs.getString ("status_hapus")
				+" \n, arsip_status_id : "+ rs.getString ("arsip_status_id")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
