<%@ include file="init.jsp" %>
<%
String		data		= "";
int			i			= 0;
try {
	int			grup_id			= Integer.parseInt (_user_gid);
	String		id				= request.getParameter ("id");
	String		pid				= request.getParameter ("pid");
	String		unit_kerja_id	= request.getParameter ("unit_kerja_id");
	String		kode_rak		= request.getParameter ("kode_rak");
	String		kode_box		= request.getParameter ("kode_box");
	String		kode_folder		= request.getParameter ("kode_folder");
	String		type			= request.getParameter ("type");
	JSONArray	arr_data		= new JSONArray ();
	JSONObject	node			= null;

	db_stmt = db_con.createStatement ();

	if (type.equalsIgnoreCase ("root")) {
		q	=" select	id"
			+" ,		nama"
			+" from		m_unit_kerja";

		/* if user is  not in grup arsip, they can see all files from all unit-kerja */
		if (grup_id != 3) {
			q +=" where	id = "+ _user_uk;
		}

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			unit_kerja_id = rs.getString ("id");

			node = new JSONObject ();
			node.put ("id"				, unit_kerja_id +".0.0.0");
			node.put ("pid"				, 0);
			node.put ("tipe_file"		, 0);
			node.put ("nama"			, rs.getString ("nama"));
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, 0);
			node.put ("kode_box"		, 0);
			node.put ("kode_folder"		, 0);
			node.put ("type"			, "unit_kerja");

			arr_data.put (node);
		}

		rs.close ();
		db_stmt.close ();

		_r.put ("success"	,true);
		_r.put ("data"		,arr_data);

	} else if (type.equalsIgnoreCase ("unit_kerja")) {
		q	=" select	distinct"
			+" 			kode_rak"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id;

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			kode_rak = rs.getString ("kode_rak");

			node = new JSONObject ();
			node.put ("id"				, unit_kerja_id +"."+ kode_rak +".0.0");
			node.put ("pid"				, unit_kerja_id +".0.0.0");
			node.put ("tipe_file"		, 0);
			node.put ("nama"			, "RAK - "+ kode_rak);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, 0);
			node.put ("kode_folder"		, 0);
			node.put ("type"			, "rak");

			arr_data.put (node);
		}

		rs.close ();
		db_stmt.close ();

		_r.put ("success"	,true);
		_r.put ("data"		,arr_data);

	} else if (type.equalsIgnoreCase ("rak")) {
		q	=" select	distinct"
			+" 			kode_box"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			kode_box	= rs.getString ("kode_box");
			node		= new JSONObject ();

			node.put ("id"				, unit_kerja_id +"."+ kode_rak +"."+ kode_box +".0");
			node.put ("pid"				, unit_kerja_id +"."+ kode_rak +".0.0");
			node.put ("tipe_file"		, 0);
			node.put ("nama"			, "BOX - "+ kode_box);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, kode_box);
			node.put ("kode_folder"		, 0);
			node.put ("type"			, "box");

			arr_data.put (node);
		}

		rs.close();
		db_stmt.close ();

		_r.put ("success"	,true);
		_r.put ("data"		,arr_data);

	} else if (type.equalsIgnoreCase ("box")) {
		q	=" select	distinct"
			+" 			kode_folder"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'"
			+" and		kode_box		= '"+ kode_box +"'";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			kode_folder	= rs.getString ("kode_folder");

			node.put ("id"				, unit_kerja_id +"."+ kode_rak +"."+ kode_box +"."+ kode_folder);
			node.put ("pid"				, unit_kerja_id +"."+ kode_rak +"."+ kode_box +".0");
			node.put ("tipe_file"		, 0);
			node.put ("nama"			, "FOLDER - "+ kode_folder);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, kode_box);
			node.put ("kode_folder"		, kode_folder);
			node.put ("type"			, "folder");

			arr_data.put (node);
		}

		rs.close();
		db_stmt.close ();

		_r.put ("success"	,true);
		_r.put ("data"		,arr_data);

	} else if (type.equalsIgnoreCase ("folder")) {
		q	=" select	m_berkas.id"
			+" ,		pid"
			+" ,		tipe_file"
			+" ,		sha"
			+" ,		pegawai_id"
			+" ,		unit_kerja_id"
			+" ,		berkas_klas_id"
			+" ,		berkas_tipe_id"
			+" ,		nama"
			+" ,		tgl_unggah"
			+" ,		tgl_dibuat"
			+" ,		nomor"
			+" ,		pembuat"
			+" ,		judul"
			+" ,		masalah"
			+" ,		jra_aktif"
			+" ,		jra_inaktif"
			+" ,		status"
			+" ,		status_hapus"
			+" ,		akses_berbagi_id"
			+" ,		kode_rak"
			+" ,		kode_box"
			+" ,		kode_folder"
			+" from		m_berkas"
			+" ,		m_arsip"
			+" where	m_berkas.id		= berkas_id"
			+" and		status			!= 1"
			+" and		status_hapus	= 1"
			+" and		arsip_status_id in (0,1)";

		if (unit_kerja_id != null && !unit_kerja_id.equalsIgnoreCase ("0")) {
			q +=" and unit_kerja_id = "+ unit_kerja_id;
		}
		if (kode_rak != null && !kode_rak.equalsIgnoreCase ("0")) {
			q +=" and kode_rak = '"+ kode_rak +"'";
		}
		if (kode_box != null && !kode_box.equalsIgnoreCase ("0")) {
			q +=" and kode_box = '"+ kode_box +"'";
		}
		if (kode_folder != null && !kode_folder.equalsIgnoreCase ("0")) {
			q +=" and kode_folder = '"+ kode_folder +"'";
		}

		q += " order by tipe_file, nama";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			node.put ("id"					, rs.getString ("id"));
			node.put ("pid"					, rs.getString ("pid"));
			node.put ("tipe_file"			, rs.getInt ("tipe_file"));
			node.put ("sha"					, rs.getString ("sha"));
			node.put ("pegawai_id"			, rs.getInt ("pegawai_id"));
			node.put ("unit_kerja_id"		, rs.getInt ("unit_kerja_id"));
			node.put ("berkas_klas_id"		, rs.getInt ("berkas_klas_id"));
			node.put ("berkas_tipe_id"		, rs.getInt ("berkas_tipe_id"));
			node.put ("nama"				, rs.getString ("nama"));
			node.put ("tgl_unggah"			, rs.getString ("tgl_unggah"));
			node.put ("tgl_dibuat"			, rs.getString ("tgl_dibuat"));
			node.put ("nomor"				, rs.getString ("nomor"));
			node.put ("pembuat"				, rs.getString ("pembuat"));
			node.put ("judul"				, rs.getString ("judul"));
			node.put ("masalah"				, rs.getString ("masalah"));
			node.put ("jra_aktif"			, rs.getInt ("jra_aktif"));
			node.put ("jra_inaktif"			, rs.getInt ("jra_inaktif"));
			node.put ("status"				, rs.getInt ("status"));
			node.put ("status_hapus"		, rs.getInt ("status_hapus"));
			node.put ("akses_berbagi_id"	, rs.getInt ("akses_berbagi_id"));
			node.put ("kode_rak"			, rs.getString ("kode_rak"));
			node.put ("kode_box"			, rs.getString ("kode_box"));
			node.put ("kode_folder"			, rs.getString ("kode_folder"));

			arr_data.put (node);
		}

		rs.close ();
		db_stmt.close ();

		_r.put ("success"	,true);
		_r.put ("data"		,arr_data);

	} else if (type.equalsIgnoreCase ("arsip_folder")) {
		q	=" select	m_berkas.id"
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
			+" where	m_berkas.id		= berkas_id"
			+" and		pid				= "+ id
			+" and		status_hapus	= 1"
			+" and		kode_rak		='"+ kode_rak +"'"
			+" and		kode_box		='"+ kode_box +"'"
			+" and		kode_folder		='"+ kode_folder +"'";

		q += " order by tipe_file, nama";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			node.put ("id"					, rs.getString ("id"));
			node.put ("pid"					, rs.getString ("pid"));
			node.put ("tipe_file"			, rs.getInt ("tipe_file"));
			node.put ("sha"					, rs.getString ("sha"));
			node.put ("pegawai_id"			, rs.getInt ("pegawai_id"));
			node.put ("unit_kerja_id"		, rs.getInt ("unit_kerja_id"));
			node.put ("berkas_klas_id"		, rs.getInt ("berkas_klas_id"));
			node.put ("berkas_tipe_id"		, rs.getInt ("berkas_tipe_id"));
			node.put ("nama"				, rs.getString ("nama"));
			node.put ("tgl_unggah"			, rs.getString ("tgl_unggah"));
			node.put ("tgl_dibuat"			, rs.getString ("tgl_dibuat"));
			node.put ("nomor"				, rs.getString ("nomor"));
			node.put ("pembuat"				, rs.getString ("pembuat"));
			node.put ("judul"				, rs.getString ("judul"));
			node.put ("masalah"				, rs.getString ("masalah"));
			node.put ("jra_aktif"			, rs.getInt ("jra_aktif"));
			node.put ("jra_inaktif"			, rs.getInt ("jra_inaktif"));
			node.put ("status"				, rs.getInt ("status"));
			node.put ("status_hapus"		, rs.getInt ("status_hapus"));
			node.put ("akses_berbagi_id"	, rs.getInt ("akses_berbagi_id"));
			node.put ("n_output_images"		, rs.getInt ("n_output_images"));

			arr_data.put (node);
		}
		rs.close ();
		db_stmt.close ();

		_r.put ("success"	,true);
		_r.put ("data"		,arr_data);
	}
}
catch (Exception e) {
	_r.put ("success"	,true);
	_r.put ("info"		,e);
} finally {
	out.print (_r);
}
%>
