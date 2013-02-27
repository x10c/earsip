<%--
	Copyright 2013 - x10c.lab

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp" %>
<%!
public JSONArray get_list_dir (int id, Connection db_con)
{
	JSONArray	nodes	= new JSONArray ();
try {
	Statement	db_stmt = db_con.createStatement ();
	ResultSet	rs		= null;
	String		q		= "";
	String		name	= "";
	JSONArray	childs	= null;
	JSONObject	node	= null;

	q	=" select	id"
		+" ,		pid"
		+" ,		nama"
		+" from		m_berkas"
		+" where	pid			= "+ id
		+" and		tipe_file	= 0"
		+" and		status		= 1" // 1:aktif, 0:inaktif
		+" and		status_hapus	= 1"
		+" order by nama";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node	= new JSONObject ();
		name	= rs.getString ("nama");
		id		= rs.getInt ("id");

		node.put ("id", id);
		node.put ("pid", rs.getInt ("pid"));
		node.put ("text", name);

		childs = get_list_dir (id, db_con);

		node.put ("children", childs);

		nodes.put (node);
	}

	rs.close();
	db_stmt.close ();

} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
} finally {
	return nodes;
}}
%>
<%
	JSONArray	childs		= null;
	int			id			= 0;

try {
	q	=" select	id"
		+" ,		nama"
		+" from		m_berkas"
		+" where	pegawai_id		= "+ _user_id
		+" and		pid				= 0"
		+" and		tipe_file		= 0"
		+" and		status			= 1" // 1:aktif, 0:inaktif
		+" and		status_hapus	= 1"
		+" order by nama";

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	if (! rs.next ()) {
		throw new Exception ("Direktori user \""+ _user_id +"\" belum ada!");
	}

	id = rs.getInt ("id");

	_o	= new JSONObject ();
	_o.put ("id"	, id);
	_o.put ("pid"	, 0);
	_o.put ("text"	, rs.getString ("nama"));

	rs.close ();
	db_stmt.close ();

	childs = get_list_dir (id, db_con);

	_o.put ("children", childs);

	_a	= new JSONArray ();
	_a.put (_o);

	_r.put ("success"	,true);
	_r.put ("children"	,_a);
} catch (Exception e) {
	_r.put ("success"	,false);
	_r.put ("info"		,e);
} finally {
	out.print (_r);
}
%>
