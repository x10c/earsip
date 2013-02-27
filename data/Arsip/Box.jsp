<%--
	Copyright 2013 - kilabit.org

	Author(s):
	- m.shulhan (ms@kilabit.org)
--%>
<%@ include file="../init.jsp"%>
<%
try {
	int		id			= Integer.parseInt (request.getParameter ("id"));
	String	kode_rak	= request.getParameter ("kode_rak");

	q	="	select	distinct"
		+" 			kode_box"
		+"	from	m_arsip"
		+"	,		m_berkas"
		+"	where	berkas_id		= m_berkas.id"
		+"	and		unit_kerja_id	= ?"
		+"	and		kode_rak		= ?"
		+"	order by kode_box";

	db_ps	= db_con.prepareStatement (q);
	_i		= 1;
	db_ps.setInt (_i++, id);
	db_ps.setString (_i++, kode_rak);
	rs		= db_ps.executeQuery ();

	_a		= new JSONArray ();
	while (rs.next ()) {
		_o	= new JSONObject ();

		_o.put ("type"		, "box");
		_o.put ("kode_box"	, rs.getString ("kode_box"));

		_a.put (_o);
	};

	rs.close ();
	db_ps.close ();

	_r.put ("success"	,true);
	_r.put ("data"		,_a);

} catch (Exception e) {
	_r.put ("success"	,false);
	_r.put ("data"		,e);
} finally {
	out.print (_r);
}
%>
