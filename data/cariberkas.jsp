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
	String	nama				= request.getParameter ("nama");
	String	tgl_dibuat_setelah	= request.getParameter ("tgl_dibuat_setelah");
	String	tgl_dibuat_sebelum	= request.getParameter ("tgl_dibuat_sebelum");
	String	berkas_klas_id		= request.getParameter ("berkas_klas_id");
	String	berkas_tipe_id		= request.getParameter ("berkas_tipe_id");
	String	nomor				= request.getParameter ("nomor");
	String	pembuat				= request.getParameter ("pembuat");
	String	judul				= request.getParameter ("judul");

	q	=" select	id"
		+" ,		pid"
		+" ,		tipe_file"
		+" ,		sha"
		+" ,		pegawai_id"
		+" ,		unit_kerja_id"
		+" ,		berkas_klas_id"
		+" ,		berkas_tipe_id"
		+" ,		nama"
		+" ,		tgl_unggah"
		+" ,		coalesce (tgl_dibuat, tgl_unggah) as tgl_dibuat"
		+" ,		nomor"
		+" ,		pembuat"
		+" ,		judul"
		+" ,		masalah"
		+" ,		jra_aktif"
		+" ,		jra_inaktif"
		+" ,		status"
		+" ,		status_hapus"
		+" ,		akses_berbagi_id"
		+" from		m_berkas"
		+" where	pegawai_id		= "+ user_id
		+" and		status			= 1"
		+" and		status_hapus	= 1";

	if (text != null && ! text.equals ("")) {
		q	+=" and (nama ilike '%"+ text +"%'"
			+ " or nomor ilike '%"+ text +"%'"
			+ " or pembuat ilike '%"+ text +"%'"
			+ " or judul ilike '%"+ text +"%'"
			+ " or masalah ilike '%"+ text +"%'"
			+ " )";
	}
	if (nama != null && ! nama.equals ("")) {
		q += " and nama ilike '%"+ nama +"%'";
	}
	if (tgl_dibuat_setelah != null && ! tgl_dibuat_setelah.equals ("")) {
		q += " and tgl_dibuat >= '"+ tgl_dibuat_setelah +"'";
	}
	if (tgl_dibuat_sebelum != null && ! tgl_dibuat_sebelum.equals ("")) {
		q += " and tgl_dibuat <= '"+ tgl_dibuat_sebelum +"'";
	}
	if (berkas_klas_id != null && ! berkas_klas_id.equals ("")) {
		q += " and berkas_klas_id = "+ berkas_klas_id;
	}
	if (berkas_tipe_id != null && ! berkas_tipe_id.equals ("")) {
		q += " and berkas_tipe_id = "+ berkas_tipe_id;
	}
	if (nomor != null && ! nomor.equals ("")) {
		q += " and nomor ilike '%"+ nomor +"%'";
	}
	if (pembuat != null && ! pembuat.equals ("")) {
		q += " and pembuat ilike '%"+ pembuat +"%'";
	}
	if (judul != null && ! judul.equals ("")) {
		q += " and judul ilike '%"+ judul +"%'";
	}

	q += " order by tipe_file, nama";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id            : "+ rs.getString ("id")
				+ "\n, pid           : "+ rs.getString ("pid")
				+ "\n, tipe_file     : "+ rs.getString ("tipe_file")
				+ "\n, sha           :'"+ rs.getString ("sha") +"'"
				+ "\n, pegawai_id    : "+ rs.getString ("pegawai_id")
				+ "\n, unit_kerja_id : "+ rs.getString ("unit_kerja_id")
				+ "\n, berkas_klas_id: "+ rs.getString ("berkas_klas_id")
				+ "\n, berkas_tipe_id: "+ rs.getString ("berkas_tipe_id")
				+ "\n, nama          :'"+ rs.getString ("nama") +"'"
				+ "\n, tgl_unggah    :'"+ rs.getString ("tgl_unggah") +"'"
				+ "\n, tgl_dibuat    :'"+ rs.getString ("tgl_dibuat") +"'"
				+ "\n, nomor         :'"+ rs.getString ("nomor") +"'"
				+ "\n, pembuat       :'"+ rs.getString ("pembuat") +"'"
				+ "\n, judul         :'"+ rs.getString ("judul") +"'"
				+ "\n, masalah       :'"+ rs.getString ("masalah") +"'"
				+ "\n, jra_aktif     : "+ rs.getString ("jra_aktif")
				+ "\n, jra_inaktif   : "+ rs.getString ("jra_inaktif")
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n, status_hapus  : "+ rs.getString ("status_hapus")
				+" \n, akses_berbagi_id : "+ rs.getString ("akses_berbagi_id")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
