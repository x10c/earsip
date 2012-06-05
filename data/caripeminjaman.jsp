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

	String	user_id				= (String) session.getAttribute ("user.id");
	String	text				= request.getParameter ("text");
	String	uk_peminjam_id		= request.getParameter ("unit_kerja_peminjam");
	String	nm_peminjam			= request.getParameter ("nama_peminjam");
	String	nm_pim_peminjam		= request.getParameter ("nama_pimpinan_peminjam");
	String	nm_petugas			= request.getParameter ("nama_petugas");
	String	nm_pim_petugas		= request.getParameter ("nama_pimpinan_petugas");
	String	pil_tgl_id			= request.getParameter ("pilihan_tanggal");
	String	tgl_setelah			= request.getParameter ("tgl_setelah");
	String	tgl_sebelum			= request.getParameter ("tgl_sebelum");
	String	ket					= request.getParameter ("keterangan");
	String	status_id			= request.getParameter ("status");

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
		

	if (text != null && ! text.equals ("")) {
		q	+=" and (nama_petugas ilike '%"+ text +"%'"
			+ " or nama_pimpinan_petugas ilike '%"+ text +"%'"
			+ " or nama_peminjam ilike '%"+ text +"%'"
			+ " or nama_pimpinan_peminjam ilike '%"+ text +"%'"
			+ " or keterangan ilike '%"+ text +"%'"
			+ " )";
	}
	if (uk_peminjam_id != null && ! uk_peminjam_id.equals ("")) {
		q += " and unit_kerja_peminjam_id = "+ uk_peminjam_id;
	}
	if (nm_petugas != null && ! nm_petugas.equals ("")) {
		q += " and nama_petugas ilike '%"+ nm_petugas +"%'";
	}
	if (nm_pim_petugas != null && ! nm_pim_petugas.equals ("")) {
		q += " and nama_pimpinan_petugas ilike '%"+ nm_pim_petugas +"%'";
	}
	if (nm_peminjam != null && ! nm_peminjam.equals ("")) {
		q += " and nama_peminjam ilike '%"+ nm_peminjam +"%'";
	}
	if (nm_pim_peminjam != null && ! nm_pim_peminjam.equals ("")) {
		q += " and nama_pimpinan_peminjam ilike '%"+ nm_pim_peminjam +"%'";
	}
	if (pil_tgl_id != null && ! pil_tgl_id.equals ("")) {
		String pil_tgl_s = "";
		if (Integer.parseInt (pil_tgl_id) == 0){
			pil_tgl_s = "tgl_pinjam";
		}
		else if (Integer.parseInt (pil_tgl_id) == 1){
			pil_tgl_s = "tgl_batas_kembali";
		}
		else {
			pil_tgl_s = "tgl_kembali";
		}
		
		if (tgl_setelah != null && ! tgl_setelah.equals ("")) {
			q += " and " + pil_tgl_s + " >= '"+ tgl_setelah +"'";
		}
		if (tgl_sebelum != null && ! tgl_sebelum.equals ("")) {
			q += " and " + pil_tgl_s + " <= '"+ tgl_sebelum +"'";
		}
	}
	if (ket != null && ! ket.equals ("")) {
		q += " and keterangan ilike '%"+ ket +"%'";
	}
	if (status_id != null && !status_id.equals ("")) {
		if (Integer.parseInt (status_id) == 0){
			q += " and tgl_kembali is null";
		} else {
			q += " and tgl_kembali is not null";
		}
	}


	q += " order by tgl_pinjam, tgl_batas_kembali";
	
	db_stmt = db_con.createStatement ();
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
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
