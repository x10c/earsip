<%--
	Copyright 2013 - x10c.Lab

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp" %>
<%
try {
	q	=" select	id"
		+" ,		kode"
		+" ,		nama"
		+" ,		nama_pimpinan"
		+" ,		keterangan"
		+" ,		urutan"
		+" from		m_unit_kerja";

	if (!_user_gid.equals ("1") && !_user_gid.equals ("3")) {
		q	+="	where	id = "+ _user_uk;
	}

	q	+=" order by urutan desc";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	_a		= new JSONArray ();
	while (rs.next ()) {
		_o	= new JSONObject ();
		_o.put ("id"			, rs.getInt ("id"));
		_o.put ("kode"			, rs.getString ("kode"));
		_o.put ("nama"			, rs.getString ("nama"));
		_o.put ("nama_pimpinan"	, rs.getString ("nama_pimpinan"));
		_o.put ("keterangan"	, rs.getString ("keterangan"));
		_o.put ("urutan"		, rs.getInt ("urutan"));
		_o.put ("type"			, "unit_kerja");

		_a.put (_o);
	}

	rs.close ();
	db_stmt.close ();

	_r.put ("success"	, true);
	_r.put ("data"		, _a);

} catch (Exception e) {
	_r.put ("success"	, false);
	_r.put ("info"		, e);
} finally {
	out.print (_r);
}
%>
