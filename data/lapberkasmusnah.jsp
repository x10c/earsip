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

	String setelah_tgl	= request.getParameter ("setelah_tgl");
	String sebelum_tgl	= request.getParameter ("sebelum_tgl");

	q   =" 		SELECT C.id"
		+"	,	A.nama"
		+"	, 	A.judul"
		+"	,	D.kode as kode_klas"
		+"	,	E.kode as kode_unit"
		+"	,	C.tgl"
		+"	, 	B.keterangan"
		+"		FROM m_berkas A"
		+"		LEFT JOIN t_pemusnahan_rinci B ON A.id = B.berkas_id"
		+"		LEFT JOIN t_pemusnahan C ON B.pemusnahan_id = C.id"
		+"		LEFT JOIN r_berkas_klas D ON A.berkas_klas_id = D.id"
		+"		LEFT JOIN m_unit_kerja E ON A.unit_kerja_id = E.id"
		+"		WHERE A.arsip_status_id = 3"
		+"		AND C.tgl >= '" + setelah_tgl + "'"
		+"		AND C.tgl <= '" + sebelum_tgl + "'";
	

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id			 : "+ rs.getString ("id")
				+ "\n, nama          : '"+ rs.getString ("nama") + "'"
				+ "\n, kode		     : '"+ rs.getString ("kode_unit") + " " + rs.getString ("kode_klas") + "'"
				+ "\n, judul         : '"+ rs.getString ("judul") + "'"
				+ "\n, tgl    		 : '"+ rs.getString ("tgl") + "'"
				+ "\n, keterangan	 : '"+ rs.getString ("keterangan") + "'"
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
