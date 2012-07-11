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

	String user_id = (String) session.getAttribute ("user.id");

	q   =" 	SELECT 	id"
		+"	,	coalesce (tgl_dibuat,tgl_unggah) as tgl_dibuat"
	    +"	,	nama"
	    +"	, 	date_part('year',age (tgl_dibuat)) AS tahun"
	    +"	, 	date_part('month',age (tgl_dibuat)) AS bulan"
	    +"	, 	date_part('day',age (tgl_dibuat)) AS hari"
	    +"	,	jra_aktif"
	    +"	, 	get_berkas_path (pid) as lokasi"
	    +"	FROM 	m_berkas"
	    +"	WHERE 	date_part ('years',age (tgl_dibuat)) >= jra_aktif"
	    +"	AND 	status = 1"
	    +"	AND 	status_hapus  = 1"
	    +"	AND 	pegawai_id   = " + user_id
	    +"	ORDER BY tgl_dibuat ASC";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id			 : "+ rs.getString ("id")
				+ "\n, tgl_dibuat    : '"+ rs.getString ("tgl_dibuat") + "'"
				+ "\n, nama          : '"+ rs.getString ("nama") + "'"
				+ "\n, tahun	     : "+ rs.getString ("tahun")
				+ "\n, bulan         : "+ rs.getString ("bulan")
				+ "\n, hari    		 : "+ rs.getString ("hari")
				+ "\n, jra		 	 : "+ rs.getString ("jra_aktif")
				+ "\n, lokasi		 :'"+ rs.getString ("lokasi") + "'"
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
