<%@ include file="init.jsp"%>
<%
try {
	int		id			= Integer.parseInt (request.getParameter ("id"));
	String	nama		= request.getParameter ("nama");
	String	tgl_dibuat	= request.getParameter ("tgl_dibuat");
	String	klas_id		= request.getParameter ("berkas_klas_id");
	String	tipe_id		= request.getParameter ("berkas_tipe_id");
	String	nomor		= request.getParameter ("nomor");
	String	pembuat		= request.getParameter ("pembuat");
	String	judul		= request.getParameter ("judul");
	String	masalah		= request.getParameter ("masalah");
	int		jra_aktif	= Integer.parseInt (request.getParameter ("jra_aktif"));
	int		jra_inaktif	= Integer.parseInt (request.getParameter ("jra_inaktif"));
	int		stat_hapus	= Integer.parseInt (request.getParameter ("status_hapus"));
	int		tipe_file	= Integer.parseInt (request.getParameter ("tipe_file"));

	if (0 == stat_hapus) {
		q =" delete from m_berkas where pid = ?";
		db_ps = db_con.prepareStatement (q);
		db_ps.setInt (1, id);
		db_ps.executeUpdate();
		db_ps.close ();

		q =" delete from m_berkas where id = ?";
		db_ps = db_con.prepareStatement (q);
		db_ps.setInt (1, id);
		db_ps.executeUpdate ();
		db_ps.close ();
	} else {
		q	=" update	m_berkas"
			+" set		nama			= ?"
			+" ,		tgl_dibuat		= ?"
			+" ,		berkas_klas_id	= ?"
			+" ,		berkas_tipe_id	= ?"
			+" ,		nomor			= ?"
			+" ,		pembuat			= ?"
			+" ,		judul			= ?"
			+" ,		masalah			= ?"
			+" ,		jra_aktif		= ?"
			+" ,		jra_inaktif		= ?"
			+" ,		status_hapus	= ?"
			+" where	id				= ?";

		db_ps	= db_con.prepareStatement (q);

		db_ps.setString	(1, nama);
		db_ps.setDate	(2, Date.valueOf (tgl_dibuat));
		db_ps.setString	(3, klas_id);
		db_ps.setString	(4, tipe_id);
		db_ps.setString	(5, nomor);
		db_ps.setString	(6, pembuat);
		db_ps.setString	(7, judul);
		db_ps.setString	(8, masalah);
		db_ps.setInt	(9, jra_aktif);
		db_ps.setInt	(10, jra_inaktif);
		db_ps.setInt	(11, stat_hapus);
		db_ps.setInt	(12, id);

		db_ps.executeUpdate ();
		db_ps.close ();
	}

	_r.put ("success", true);
	_r.put ("info", "Data berkas telah tersimpan.");
}
catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
	_r.put ("q", q);
}
out.print (_r);
%>
