<%@ include file="init.jsp"%>
<%
try {
	String berkas_id	= request.getParameter ("berkas_id");

	q	=" select	id"
		+" ,		pid"
		+" ,		tipe_file"
		+" ,		mime"
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
		+" from		m_berkas"
		+" where	pegawai_id		= "+ _user_id
		+" and		pid				= "+ berkas_id
		+" and		status			= 1" // 1: aktif, 0:inaktif
		+" and		status_hapus	= 1"
		+" order by tipe_file, nama";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();
	while (rs.next ()) {
		_o = new JSONObject ();
		_o.put ("id"				, rs.getString ("id"));
		_o.put ("pid"				, rs.getString ("pid"));
		_o.put ("tipe_file"			, rs.getString ("tipe_file"));
		_o.put ("mime"				, rs.getString ("mime"));
		_o.put ("sha"				, rs.getString ("sha"));
		_o.put ("pegawai_id"		, rs.getString ("pegawai_id"));
		_o.put ("unit_kerja_id"		, rs.getString ("unit_kerja_id"));
		_o.put ("berkas_klas_id"	, rs.getInt ("berkas_klas_id"));
		_o.put ("berkas_tipe_id"	, rs.getInt ("berkas_tipe_id"));
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

		_a.put (_o);
	}

	rs.close ();
	db_stmt.close ();

	_r.put ("success", true);
	_r.put ("data", _a);
} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("data", e);
}
out.print (_r);
%>
