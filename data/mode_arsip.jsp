<%--
	Author:
	- mhd.sulhan (ms@kilabit.info)
--%>
<%@ include file="init.jsp" %>
<%
try {
	String	query	= request.getParameter ("query");

	q	="select	A.id "
		+",			A.nama "
		+"from 	r_mode_arsip A "
		+"order by A.id";

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();
	while (rs.next ()) {
		_o = new JSONObject ();
		_o.put ("id"			, rs.getInt ("id"));
		_o.put ("nama"			, rs.getString ("nama"));

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
