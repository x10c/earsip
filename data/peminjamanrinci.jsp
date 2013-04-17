<%@ include file="init.jsp" %>
<%
try {
	String peminjaman_id	 = request.getParameter ("peminjaman_id");

	q	=" select	A.peminjaman_id"
		+" ,		A.berkas_id"
		+" ,		B.nama"
		+" ,		B.nomor"
		+" ,		B.pembuat"
		+" ,		B.judul"
		+" ,		B.masalah"
		+" ,		B.jra_aktif"
		+" ,		B.jra_inaktif"
		+" ,		B.status"
		+" ,		B.status_hapus"
		+" ,		B.arsip_status_id"
		+" from		peminjaman_rinci	A"
		+" ,		m_berkas			B"
		+" where	peminjaman_id	= "+ peminjaman_id
		+" and		A.berkas_id		= B.id";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();

	while (rs.next ()) {
		_o		= new JSONObject ();
		_o.put ("peminjaman_id"		, rs.getString ("peminjaman_id"));
		_o.put ("berkas_id"			, rs.getString ("berkas_id"));
		_o.put ("nama"				, rs.getString ("nama"));
		_o.put ("nomor"				, rs.getString ("nomor"));
		_o.put ("pembuat"			, rs.getString ("pembuat"));
		_o.put ("judul"				, rs.getString ("judul"));
		_o.put ("masalah"			, rs.getString ("masalah"));
		_o.put ("jra_aktif"			, rs.getString ("jra_aktif"));
		_o.put ("jra_inaktif"		, rs.getString ("jra_inaktif"));
		_o.put ("status"			, rs.getString ("status"));
		_o.put ("status_hapus"		, rs.getString ("status_hapus"));
		_o.put ("arsip_status_id"	, rs.getString ("arsip_status_id"));

		_a.put (_o);
	}

	rs.close ();
	db_stmt.close ();

	_r.put ("success"	, true);
	_r.put ("data"		, _a);
}
catch (Exception e) {
	_r.put ("success"	,false);
	_r.put ("info"		,e);
}
out.print (_r);
%>
