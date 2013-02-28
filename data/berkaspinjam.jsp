<%@ include file="init.jsp" %>
<%
try {
	int		start	= ServletUtilities.getIntParameter (request, "start", 0);
	int		limit	= ServletUtilities.getIntParameter (request, "limit", 20);
	int		total	= 0;
	String	query	= request.getParameter ("query");

	q	=" select	count (*) as total"
		+" from		m_berkas"
		+" right join m_arsip"
		+" on		m_berkas.id = m_arsip.berkas_id"
		+" where	status			= 0"
		+" and		status_hapus	= 1"
		+" and		unit_kerja_id is not null";

	if (query != null && !query.equals ("")) {
		q	+=" and m_berkas.nama ilike '%"+ query +"%'";
	}

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	if (! rs.next ()) {
		total = 0;
	} else {
		total = rs.getInt ("total");
	}

	db_stmt.close ();
	rs.close ();

	q	=" select	id"
		+" ,		nama"
		+" ,		nomor"
		+" ,		pembuat"
		+" ,		judul"
		+" ,		masalah"
		+" ,		jra_aktif"
		+" ,		jra_inaktif"
		+" ,		status"
		+" ,		status_hapus"
		+" ,		arsip_status_id"
		+" from		m_berkas"
		+" right join m_arsip"
		+" on		m_berkas.id = m_arsip.berkas_id"
		+" where	status			= 0"
		+" and		status_hapus	= 1"
		+" and		unit_kerja_id is not null";

	if (query != null && !query.equals ("")) {
		q	+=" and m_berkas.nama ilike '%"+ query +"%'";
	}

	q	+=" order by nama"
		+" LIMIT	"+ limit
		+" OFFSET	"+ start;

	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);
	_a		= new JSONArray ();

	while (rs.next ()) {
		_o	= new JSONObject ();
		_o.put ("id"				, rs.getString ("id"));
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

	_r.put ("success"	,true);
	_r.put ("data"		,_a);
	_r.put ("total"		,total);
} catch (Exception e) {
	_r.put ("success"	,false);
	_r.put ("info"		,e);
} finally {
	out.print (_r);
}
%>
