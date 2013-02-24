<%@ include file="init.jsp" %>
<%
String		data		= "";
int			i			= 0;
try {
	String	id			= request.getParameter ("id");
	String	pid			= request.getParameter ("pid");
	String	peg_id		= request.getParameter ("peg_id");
	String	nama		= "";

	if (id.equalsIgnoreCase ("0")) {
		q	=" select	distinct"
			+"			A.id"
			+" ,		A.pegawai_id"
			+" ,		B.nama"
			+" from		m_berkas	as A"
			+" ,		m_pegawai	as B"
			+" where	A.akses_berbagi_id in (3,4)"
			+" and		A.pegawai_id	= B.id"
			+" union all"
			+" select	distinct"
			+"			A.id"
			+" ,		A.pegawai_id"
			+" ,		C.nama"
			+" from		m_berkas			as A"
			+" ,		m_berkas_berbagi	as B"
			+" ,		m_pegawai			as C"
			+" where	("
			+"				A.akses_berbagi_id	in (1,2)"
			+"		and		A.id				= B.berkas_id"
			+"		and		B.bagi_ke_peg_id	= "+ _user_id
			+" )"
			+" and		A.pegawai_id		= C.id"
			+" order by pegawai_id";

		db_stmt	= db_con.createStatement ();
		rs	= db_stmt.executeQuery (q);
		_a	= new JSONArray ();

		while (rs.next ()) {
			peg_id	= rs.getString ("pegawai_id");
			nama	= rs.getString ("nama");
			_o		= new JSONObject ();

			_o.put ("id", rs.getString ("id"));
			_o.put ("pid", 0);
			_o.put ("nama", nama);
			_o.put ("pegawai_id", peg_id);
			_o.put ("tipe_file", 0);

			_a.put (_o);
		}

		rs.close ();
		db_stmt.close ();

		_r.put ("success", true);
		_r.put ("data", _a);

		out.print (_r);
		return;
	}

	q	=" select	m_berkas.id"
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
		+" from		m_berkas";

	if (pid.equalsIgnoreCase ("0")) {
		q += " where	akses_berbagi_id in (3,4)"
			+" and		pegawai_id = "+ peg_id
			+" union all"
			+" select	m_berkas.id"
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
			+" ,		m_berkas_berbagi"
			+" where	akses_berbagi_id in (1,2)"
			+"	and		berkas_id		= m_berkas.id"
			+"	and		bagi_ke_peg_id	= "+ _user_id
			+" and		pegawai_id		= "+ peg_id;
	} else if (id.equalsIgnoreCase ("0")) {
		q	+=" where id = "+ pid;
	} else {
		q	+=" where pid = "+ id;
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
				+ "\n, mime          :'"+ rs.getString ("mime") +"'"
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
				+" \n, n_output_images  : "+ rs.getString ("n_output_images")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
