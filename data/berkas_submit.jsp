<%--
	Copyright 2014 - kilabit.info

	Author(s):
	- m.shulhan (ms@kilabit.info)
--%>
<%@ include file="init.jsp"%>
<%!
	public int delete_recursively (Connection db_con, int org_id)
	{
		PreparedStatement	db_ps		= null;
		ResultSet			db_rs		= null;
		String				q			= "";
		Statement			del_st		= null;
		String				del_q		= "";
		int					id			= 0;
		int					pid			= 0;
		int					tipe_file	= 0;

		try {
			q	="	select	id"
				+"	,		pid"
				+"	,		tipe_file"
				+"	from	m_berkas"
				+"	where	pid = ?";

			db_ps	= db_con.prepareStatement (q);
			db_ps.setInt (1, org_id);
			db_rs	= db_ps.executeQuery ();

			while (db_rs.next ()) {
				id			= db_rs.getInt ("id");
				pid			= db_rs.getInt ("pid");
				tipe_file	= db_rs.getInt ("tipe_file");

				if (tipe_file == 0) {
					delete_recursively (db_con, id);
				}
			}

			db_rs.close ();
			db_ps.close ();

			del_st	= db_con.createStatement ();

			del_q	="	delete from m_berkas where pid = "+ org_id;
			del_st.executeUpdate (del_q);

			del_q	="	delete from m_berkas where id = "+ org_id;
			del_st.executeUpdate (del_q);

			del_st.close ();
		} catch (Exception e) {
			return 1;
		} finally {
			return 0;
		}
	}
%>
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
	String	jra_aktif	= request.getParameter ("jra_aktif");
	String	jra_inaktif	= request.getParameter ("jra_inaktif");
	int		stat_hapus	= Integer.parseInt (request.getParameter ("status_hapus"));
	int		tipe_file	= Integer.parseInt (request.getParameter ("tipe_file"));

	if (0 == stat_hapus) {
		delete_recursively (db_con, id);
	} else {
		q	=" update	m_berkas"
			+" set		nama			= ?"
			+" ,		tgl_dibuat		= to_date (?, 'YYYY-MM-DD')"
			+" ,		berkas_klas_id	= cast (? as int)"
			+" ,		berkas_tipe_id	= cast (? as int)"
			+" ,		nomor			= ?"
			+" ,		pembuat			= ?"
			+" ,		judul			= ?"
			+" ,		masalah			= ?"
			+" ,		jra_aktif		= cast (? as int)"
			+" ,		jra_inaktif		= cast (? as int)"
			+" ,		status_hapus	= ?"
			+" where	id				= ?";

		db_ps	= db_con.prepareStatement (q);

		_i = 1;
		db_ps.setString	(_i++, nama.trim ());
		db_ps.setString	(_i++, tgl_dibuat);
		db_ps.setString	(_i++, klas_id);
		db_ps.setString	(_i++, tipe_id);
		db_ps.setString	(_i++, nomor);
		db_ps.setString	(_i++, pembuat.trim ());
		db_ps.setString	(_i++, judul.trim ());
		db_ps.setString	(_i++, masalah.trim ());
		db_ps.setString	(_i++, jra_aktif);
		db_ps.setString	(_i++, jra_inaktif);
		db_ps.setInt	(_i++, stat_hapus);
		db_ps.setInt	(_i++, id);

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
