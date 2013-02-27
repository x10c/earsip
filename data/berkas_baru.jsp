<%@ include file="init.jsp" %>
<%
try {
	int		dir_id		= ServletUtilities.getIntParameter (request, "berkas_id", 0);
	int		tipe_file	= ServletUtilities.getIntParameter (request, "tipe_file", 0);
	String	nama		= request.getParameter ("nama");
	String	tgl_dibuat	= request.getParameter ("tgl_dibuat");
	int		klas_id		= ServletUtilities.getIntParameter (request, "berkas_klas_id", 1);
	int		tipe_id		= ServletUtilities.getIntParameter (request, "berkas_tipe_id", 1);
	String	nomor		= request.getParameter ("nomor");
	String	judul		= request.getParameter ("judul");
	String	pembuat		= request.getParameter ("pembuat");
	String	masalah		= request.getParameter ("masalah");
	int		jra_aktif	= ServletUtilities.getIntParameter (request, "jra_aktif", 1);
	int		jra_inaktif	= ServletUtilities.getIntParameter (request, "jra_inaktif", 1);

	if (null == tgl_dibuat || tgl_dibuat.isEmpty ()) {
		tgl_dibuat = _sdf.format (new Date ());
	}

	q	=" insert into m_berkas ("
		+"		pid"
		+" ,	pegawai_id"
		+" ,	unit_kerja_id"
		+" ,	nama"
		+" ,	tgl_dibuat"

		+" ,	berkas_klas_id"
		+" ,	berkas_tipe_id"
		+" ,	nomor"
		+" ,	judul"
		+" ,	pembuat"

		+" ,	masalah"
		+" ,	jra_aktif"
		+" ,	jra_inaktif"

		+" ,	tipe_file"
		+" ) values ("
		+"		?, ?, ?, ?, to_date (?, 'YYYY-MM-DD')"
		+"	,	?, ?, ?, ?, ?"
		+"	,	?, ?, ?, ?"
		+" )";

	db_ps = db_con.prepareStatement (q);

	_i = 1;
	db_ps.setInt	(_i++, dir_id);
	db_ps.setInt	(_i++, Integer.parseInt (_user_id));
	db_ps.setInt	(_i++, Integer.parseInt (_user_uk));
	db_ps.setString (_i++, nama);
	db_ps.setString (_i++, tgl_dibuat);

	db_ps.setInt	(_i++, klas_id);
	db_ps.setInt	(_i++, tipe_id);
	db_ps.setString (_i++, nomor);
	db_ps.setString (_i++, judul);
	db_ps.setString (_i++, pembuat);

	db_ps.setString (_i++, masalah);
	db_ps.setInt	(_i++, jra_aktif);
	db_ps.setInt	(_i++, jra_inaktif);
	db_ps.setInt	(_i++, tipe_file);

	db_ps.executeUpdate ();
	db_ps.close ();

	_r.put ("success", true);
	_r.put ("data", "Folder baru telah tersimpan.");
}
catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
}
out.print (_r);
%>
