<%--
	Copyright 2013 X10C.Labs

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp"%>
<%
try {
	String				action			= request.getParameter ("action");
	int					id				= ServletUtilities.getIntParameter (request, "id", 0);
	int					pid				= ServletUtilities.getIntParameter (request, "pid", 0);
	int					uk_id			= ServletUtilities.getIntParameter (request, "unit_kerja_id", Integer.parseInt (_user_uk));
	String				nama			= request.getParameter ("nama");
	String				tgl_dibuat		= request.getParameter ("tgl_dibuat");
	int					berkas_klas_id	= ServletUtilities.getIntParameter (request, "berkas_klas_id", 1);
	int					berkas_tipe_id	= ServletUtilities.getIntParameter (request, "berkas_tipe_id", 1);
	String				kode_rak		= request.getParameter ("kode_rak");
	String				kode_box		= request.getParameter ("kode_box");
	String				kode_folder		= request.getParameter ("kode_folder");
	String				nomor			= request.getParameter ("nomor");
	String				pembuat			= request.getParameter ("pembuat");
	String				judul			= request.getParameter ("judul");
	String				masalah			= request.getParameter ("masalah");
	int					jra_inaktif		= ServletUtilities.getIntParameter (request, "jra_inaktif", 1);
	Date				date			= null;
	SimpleDateFormat	sdf				= null;

	if (null == tgl_dibuat) {
		date		= new Date ();
		sdf			= new SimpleDateFormat ("yyyy-MM-dd");
		tgl_dibuat	= sdf.format (date);
	}

	if ("create".equalsIgnoreCase (action)) {
		q	="	insert into	m_berkas ("
			+"		pid"
			+"	,	pegawai_id"
			+"	,	unit_kerja_id"

			+"	,	nama"
			+"	,	tgl_dibuat"
			+"	,	berkas_klas_id"
			+"	,	berkas_tipe_id"
			+"	,	tipe_file"

			+"	,	nomor"
			+"	,	pembuat"
			+"	,	judul"
			+"	,	masalah"

			+"	,	jra_aktif"
			+"	,	jra_inaktif"
			+"	,	status"
			+"	) values ("
			+"		?, ?, ?"
			+"	,	?, to_date (?, 'YYYY-MM-DD'), ?, ?, ?"
			+"	,	?, ?, ?, ?"
			+"	,	1, ?, 2"
			+"	)";

		db_ps	= db_con.prepareStatement (q, Statement.RETURN_GENERATED_KEYS);
		_i		= 1;

		db_ps.setInt	(_i++, 0);
		db_ps.setInt	(_i++, Integer.parseInt (_user_id));
		db_ps.setInt	(_i++, uk_id);

		db_ps.setString	(_i++, nama);
		db_ps.setString	(_i++, tgl_dibuat);
		db_ps.setInt	(_i++, berkas_klas_id);
		db_ps.setInt	(_i++, berkas_tipe_id);
		db_ps.setInt	(_i++, 1);

		db_ps.setString	(_i++, nomor);
		db_ps.setString	(_i++, pembuat);
		db_ps.setString	(_i++, judul);
		db_ps.setString	(_i++, masalah);

		db_ps.setInt	(_i++, jra_inaktif);

		_i = db_ps.executeUpdate ();
		if (_i == 0) {
			throw new SQLException ("Gagal membuat arsip baru!");
		}

		rs = db_ps.getGeneratedKeys ();

		if (rs.next ()) {
			id = rs.getInt (1);
		} else {
			throw new SQLException ("Gagal membuat arsip baru, ID baru tidak didapat!");
		}

		db_ps.close ();
		rs.close ();

		q	="	insert into	m_arsip ("
			+"		berkas_id"
			+"	,	kode_rak"
			+"	,	kode_box"
			+"	,	kode_folder"
			+"	) values ("
			+"		?, ?, ?, ?"
			+"	)";

		db_ps	= db_con.prepareStatement (q);
		_i		= 1;
		db_ps.setInt	(_i++,	id);
		db_ps.setString	(_i++, kode_rak);
		db_ps.setString	(_i++, kode_box);
		db_ps.setString	(_i++, kode_folder);

		db_ps.executeUpdate ();
		db_ps.close ();

	} else if ("update".equalsIgnoreCase (action)) {
		q	="	update	m_berkas"
			+"	set"
			+"			nama			= ?"
			+"	,		tgl_dibuat		= to_date (?, 'YYYY-MM-DD')"
			+"	,		berkas_klas_id	= ?"
			+"	,		berkas_tipe_id	= ?"
			+"	,		nomor			= ?"
			+"	,		pembuat			= ?"
			+"	,		judul			= ?"
			+"	,		masalah			= ?"
			+"	,		jra_inaktif		= ?"
			+"	where	id				= ?";

		db_ps	= db_con.prepareStatement (q);
		_i		= 1;
		db_ps.setString	(_i++, nama);
		db_ps.setString	(_i++, tgl_dibuat);
		db_ps.setInt	(_i++, berkas_klas_id);
		db_ps.setInt	(_i++, berkas_tipe_id);
		db_ps.setString (_i++, nomor);
		db_ps.setString (_i++, pembuat);
		db_ps.setString (_i++, judul);
		db_ps.setString (_i++, masalah);
		db_ps.setInt	(_i++, jra_inaktif);
		db_ps.setInt	(_i++, id);

		db_ps.executeUpdate ();
		db_ps.close ();

		q	="	update	m_arsip"
			+"	set		kode_rak		= ?"
			+"	,		kode_box		= ?"
			+"	,		kode_folder		= ?"
			+"	where	berkas_id		= ?";

		db_ps	= db_con.prepareStatement (q);
		_i		= 1;
		db_ps.setString	(_i++, kode_rak);
		db_ps.setString	(_i++, kode_box);
		db_ps.setString	(_i++, kode_folder);
		db_ps.setInt	(_i++, id);

		db_ps.executeUpdate ();
		db_ps.close ();
	}

	_r.put ("success", true);
	_r.put ("info", "Data arsip telah tersimpan.");
}
catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
}
out.print (_r);
%>
