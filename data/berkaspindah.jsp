<%@ include file="init.jsp" %>
<%
try {
	q	="	SELECT	id"
		+"	,		nama"
		+"	FROM	m_berkas"
		+"	WHERE	id NOT IN (SELECT berkas_id FROM t_pemindahan_rinci)"
		+"	and		pegawai_id		= "+ _user_id
		+"	AND		status_hapus	= 1"
		+"	AND		arsip_status_id	= 0"
		+"	AND 	unit_kerja_id	is not null"
		+"	and		datediff('month', current_date, dateadd ('year', jra_aktif, tgl_dibuat)) <= 3";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	_a		= new JSONArray ();
	while (rs.next ()) {
		_o	= new JSONObject ();
		_o.put ("id"	, rs.getString ("id"));
		_o.put ("nama"	, rs.getString ("nama"));

		_a.put (_o);
	}

	rs.close ();
	db_stmt.close ();

	_r.put ("success"	,true);
	_r.put ("data"		,_a);

} catch (Exception e) {
	_r.put ("success"	,false);
	_r.put ("data"		,e);
} finally {
	out.print (_r);
}
%>
