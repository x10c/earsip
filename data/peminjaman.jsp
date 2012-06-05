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
	
	q	=" select		distinct(id)"
		+" ,			unit_kerja_peminjam_id"
		+" ,			nama_petugas"
		+" ,			nama_pimpinan_petugas"
		+" ,			nama_peminjam"
		+" ,			nama_pimpinan_peminjam"
		+" ,			tgl_pinjam"
		+" ,			tgl_batas_kembali"
		+" ,			tgl_kembali"
		+" ,			keterangan"
		+" from			t_peminjaman A, peminjaman_rinci B"
		+" where		A.id = B.peminjaman_id";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id						: "+ rs.getString ("id")
				+ "\n, unit_kerja_peminjam_id	: "+ rs.getString ("unit_kerja_peminjam_id")
				+ "\n, nama_petugas				:'"+ rs.getString ("nama_petugas") +"'"
				+ "\n, nama_pimpinan_petugas	:'"+ rs.getString ("nama_pimpinan_petugas") +"'"
				+ "\n, nama_peminjam			:'"+ rs.getString ("nama_peminjam") +"'"
				+ "\n, nama_pimpinan_peminjam	:'"+ rs.getString ("nama_pimpinan_peminjam") +"'"
				+ "\n, tgl_pinjam				:'"+ rs.getString ("tgl_pinjam") +"'"
				+ "\n, tgl_batas_kembali		:'"+ rs.getString ("tgl_batas_kembali") +"'"
				+ "\n, tgl_kembali				:'"+ rs.getString ("tgl_kembali") +"'"
				+ "\n, keterangan				:'"+ rs.getString ("keterangan") +"'"
				+ "\n, status					: "+ (rs.getDate ("tgl_kembali") == null?0:1)
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
