<%@ include file="init.jsp" %>
<%
try {
	int		dir_id		= Integer.parseInt (request.getParameter ("berkas_id"));
	String	nama		= request.getParameter ("nama");
	String	tgl_dibuat	= request.getParameter ("tgl_dibuat");
	String	klas_id		= request.getParameter ("berkas_klas_id");
	String	tipe_id		= request.getParameter ("berkas_tipe_id");
	String	nomor		= request.getParameter ("nomor");
	String	judul		= request.getParameter ("judul");
	String	pembuat		= request.getParameter ("pembuat");
	String	masalah		= request.getParameter ("masalah");
	String	jra_aktif	= request.getParameter ("jra_aktif");
	String	jra_inaktif	= request.getParameter ("jra_inaktif");

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
		+" ) values (?, ?, ?, ?, to_date (?, 'YYYY-MM-DD')"
		+"	, ?, ?, ?, ?, ?"
		+"	, ?, ?, ?)";

	db_ps = db_con.prepareStatement (q);

	_i = 1;
	db_ps.setInt	(_i++, dir_id);
	db_ps.setInt	(_i++, Integer.parseInt (_user_id));
	db_ps.setInt	(_i++, Integer.parseInt (_user_uk));
	db_ps.setString (_i++, nama);
	db_ps.setString (_i++, tgl_dibuat);

	db_ps.setInt	(_i++, Integer.parseInt (klas_id.isEmpty () ? "1" : klas_id));
	db_ps.setInt	(_i++, Integer.parseInt (tipe_id.isEmpty () ? "1" : tipe_id));
	db_ps.setString (_i++, nomor);
	db_ps.setString (_i++, judul);
	db_ps.setString (_i++, pembuat);

	db_ps.setString (_i++, masalah);
	db_ps.setInt	(_i++, Integer.parseInt (jra_aktif.isEmpty () ? "1" : jra_aktif));
	db_ps.setInt	(_i++, Integer.parseInt (jra_inaktif.isEmpty () ? "1" : jra_inaktif));

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
