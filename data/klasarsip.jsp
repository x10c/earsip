<%--
	Author:
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp" %>
<%
try {
	String	query	= request.getParameter ("query");

	q	=" select	A.id"
		+" , 		A.unit_kerja_id"
		+" , 		A.kode"
		+" , 		B.nama ||' - '|| A.kode ||' - '|| A.nama as nama"
		+" , 		A.keterangan"
		+" ,		A.jra_aktif"
		+" ,		A.jra_inaktif"
		+" from 	r_berkas_klas	A"
		+" ,		m_unit_kerja	B"
		+" where	A.unit_kerja_id = B.id";

		if (! _user_gid.equals ("1") && ! _user_gid.equals ("3")) {
			q	+=" and	A.unit_kerja_id = " + _user_uk;
		}
		if (query != null && ! query.equals ("")) {
			q	+="	and A.nama ilike '%"+ query +"%'";
		}

		q +=" order by B.nama, A.kode, A.nama";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();
	while (rs.next ()) {
		_o = new JSONObject ();
		_o.put ("id"			, rs.getInt ("id"));
		_o.put ("unit_kerja_id"	, rs.getInt ("unit_kerja_id"));
		_o.put ("kode"			, rs.getString ("kode"));
		_o.put ("nama"			, rs.getString ("nama"));
		_o.put ("keterangan"	, rs.getString ("keterangan"));
		_o.put ("jra_aktif"		, rs.getString ("jra_aktif"));
		_o.put ("jra_inaktif"	, rs.getString ("jra_inaktif"));

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
