<%@ include file="init.jsp" %>
<%
try {
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
		+" ,		n_output_images"
		+" ,		kode_rak"
		+" ,		kode_box"
		+" ,		kode_folder"
		+" from		m_berkas"
		+" ,		m_arsip"
		+" where	m_berkas.id		= m_arsip.berkas_id"
		+" and		status			= 0"
		+" and		status_hapus	= 1";

	if (! _user_gid.equals ("1") && ! _user_gid.equals ("3")) {
		q += " and unit_kerja_id = "+ _user_uk;
	}
	if (text != null && ! text.equals ("")) {
		q	+=" and (nama like '%"+ text +"%'"
			+ " or nomor like '%"+ text +"%'"
			+ " or pembuat like '%"+ text +"%'"
			+ " or judul like '%"+ text +"%'"
			+ " or masalah like '%"+ text +"%'"
			+ " )";
	}
	if (nama != null && ! nama.equals ("")) {
		q += " and nama like '%"+ nama +"%'";
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
		q += " and nomor like '%"+ nomor +"%'";
	}
	if (pembuat != null && ! pembuat.equals ("")) {
		q += " and pembuat like '%"+ pembuat +"%'";
	}
	if (judul != null && ! judul.equals ("")) {
		q += " and judul like '%"+ judul +"%'";
	}

	q += " order by tipe_file, nama";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();
	while (rs.next ()) {
		_o	= new JSONObject ();
		_o.put ("id"				, rs.getString ("id"));
		_o.put ("pid"				, rs.getString ("pid"));
		_o.put ("tipe_file"			, rs.getString ("tipe_file"));
		_o.put ("sha"				, rs.getString ("sha"));
		_o.put ("pegawai_id"		, rs.getString ("pegawai_id"));
		_o.put ("unit_kerja_id"		, rs.getString ("unit_kerja_id"));
		_o.put ("berkas_klas_id"	, rs.getString ("berkas_klas_id"));
		_o.put ("berkas_tipe_id"	, rs.getString ("berkas_tipe_id"));
		_o.put ("nama"				, rs.getString ("nama"));
		_o.put ("tgl_unggah"		, rs.getString ("tgl_unggah"));
		_o.put ("tgl_dibuat"		, rs.getString ("tgl_dibuat"));
		_o.put ("nomor"				, rs.getString ("nomor"));
		_o.put ("pembuat"			, rs.getString ("pembuat"));
		_o.put ("judul"				, rs.getString ("judul"));
		_o.put ("masalah"			, rs.getString ("masalah"));
		_o.put ("jra_aktif"			, rs.getString ("jra_aktif"));
		_o.put ("jra_inaktif"		, rs.getString ("jra_inaktif"));
		_o.put ("status"			, rs.getString ("status"));
		_o.put ("status_hapus"		, rs.getString ("status_hapus"));
		_o.put ("akses_berbagi_id"	, rs.getString ("akses_berbagi_id"));
		_o.put ("n_output_images"	, rs.getString ("n_output_images"));
		_o.put ("kode_rak"			, rs.getString ("kode_rak"));
		_o.put ("kode_box"			, rs.getString ("kode_box"));
		_o.put ("kode_folder"		, rs.getString ("kode_folder"));

		_a.put (_o);
	}

	rs.close ();
	db_stmt.close ();

	_r.put ("success"	, true);
	_r.put ("data"		, _a);
	_r.put ("q"			, q);

} catch (Exception e) {
	_r.put ("success"	, true);
	_r.put ("info"		, e);
} finally {
	out.print (_r);
}
%>
