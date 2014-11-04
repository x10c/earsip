<%@ include file="init.jsp" %>
<%
try {
	q	=" select	A.id"
		+" ,		A.berkas_klas_id"
		+" ,		A.keterangan"
		+" from		r_ir A"
		+" ,		r_berkas_klas B"
		+" where	A.berkas_klas_id = B.id";

	if (! _user_gid.equals ("1")) {
		q	+=" and	B.unit_kerja_id = " + _user_uk;
	}

	q	+=" order by berkas_klas_id, keterangan";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();

	while (rs.next ()) {
		_o = new JSONObject ();
		_o.put ("id", rs.getInt ("id"));
		_o.put ("berkas_klas_id", rs.getInt ("berkas_klas_id"));
		_o.put ("keterangan", rs.getString ("keterangan"));

		_a.put (_o);
	}

	rs.close ();
	db_stmt.close ();

	_r.put ("success"	, true);
	_r.put ("data"		, _a);
}
catch (Exception e) {
	_r.put ("success"	, false);
	_r.put ("info"		, e);
}
out.print (_r);
%>
