<%--
	Copyright 2013 - x10c.Lab

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp" %>
<%!
public JSONArray get_list_dir (Connection db_con, int berkas_id)
{
	JSONArray	nodes	= new JSONArray ();
try {
	Statement	db_stmt = db_con.createStatement ();
	ResultSet	rs		= null;
	String		q		= "";
	String		nama	= "";
	JSONArray	childs	= null;
	JSONObject	node	= null;

	q	=" select	id"
		+" ,		pid"
		+" ,		nama"
		+" from		m_berkas"
		+" where	pid			= "+ berkas_id
		+" and		tipe_file	= 0"
		+" and		status		= 1";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node		= new JSONObject ();
		nama		= rs.getString ("nama");
		berkas_id	= rs.getInt ("id");

		node.put ("id", berkas_id);
		node.put ("pid", rs.getInt ("pid"));
		node.put ("text", nama);

		childs = get_list_dir (db_con, berkas_id);

		if (childs.length () <= 0) {
			node.put ("children", new JSONArray());
		} else {
			node.put ("children", childs);
		}

		nodes.put (node);
	}

	rs.close();
	db_stmt.close ();

} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
} finally {
	return nodes;
}}

public JSONArray get_top_list_dir (Connection db_con, String user_id, int peg_id, int berkas_id)
{
	JSONArray	nodes	= new JSONArray ();
try {
	Statement	db_stmt = db_con.createStatement ();
	ResultSet	rs		= null;
	String		q		= "";
	String		name	= "";
	JSONArray	childs	= null;
	JSONObject	node	= null;

	q	=" select	distinct"
		+" 			id"
		+" ,		pid"
		+" ,		nama"
		+" from		m_berkas"
		+" where	tipe_file	= 0"
		+" and		status		= 1"
		+" and		pegawai_id	= "+ peg_id
		+" and		akses_berbagi_id in (3,4)"
		+" union all"
		+" select	distinct"
		+" 			m_berkas.id"
		+" ,		pid"
		+" ,		nama"
		+" from		m_berkas"
		+" ,		m_berkas_berbagi"
		+" where	tipe_file		= 0"
		+" and		status			= 1"
		+" and		pegawai_id		= "+ peg_id
		+" and		m_berkas.id		= berkas_id"
		+" and		bagi_ke_peg_id	= "+ user_id
		+" and		akses_berbagi_id in (1,2)"
		+" order by nama";

	if (berkas_id != 0) {
		q +=" and pid = "+ berkas_id;
	}

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node		= new JSONObject ();
		name		= rs.getString ("nama");
		berkas_id	= rs.getInt ("id");

		node.put ("id", berkas_id);
		node.put ("pid", rs.getInt ("pid"));
		node.put ("text", name);
		node.put ("pegawai_id", peg_id);

		childs = get_list_dir (db_con, berkas_id);

		if (childs.length () <= 0) {
			node.put ("children", new JSONArray());
		} else {
			node.put ("children", childs);
		}

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
try {
	db_stmt		= db_con.createStatement();

	String		data		= "";
	JSONArray	childs		= null;
	JSONObject	root		= new JSONObject ();
	JSONArray	roots		= new JSONArray ();
	JSONObject	node		= null;
	int			peg_id		= 0;
	String		nama		= "";

	q	=" select	distinct"
		+"			m_berkas.id"
		+" ,		pegawai_id"
		+" ,		m_pegawai.nama"
		+" from		m_berkas"
		+" ,		m_pegawai"
		+" where	akses_berbagi_id in (3,4)"
		+" and		pegawai_id	= m_pegawai.id"
		+" union all"
		+" select	distinct"
		+"			m_berkas.id"
		+" ,		pegawai_id"
		+" ,		m_pegawai.nama"
		+" from		m_berkas"
		+" ,		m_berkas_berbagi"
		+" ,		m_pegawai"
		+" where	(akses_berbagi_id in (1,2)"
		+" and		m_berkas.id		= berkas_id"
		+" and		bagi_ke_peg_id	= "+ _user_id +")"
		+" and		pegawai_id		= m_pegawai.id"
		+" order by pegawai_id";

	rs = db_stmt.executeQuery (q);

	root.put ("id", 0);
	root.put ("pid", 0);
	root.put ("text", "Berkas berbagi pegawai");
	root.put ("pegawai_id", 0);

	while (rs.next ()) {
		node	= new JSONObject ();
		peg_id	= rs.getInt ("pegawai_id");
		nama	= rs.getString ("nama");

		node.put ("id", rs.getString ("id"));
		node.put ("pid", 0);
		node.put ("text", nama);
		node.put ("pegawai_id", peg_id);

		childs = get_top_list_dir (db_con, _user_id, peg_id, 0);

		if (childs.length () <= 0) {
			node.put ("children", new JSONArray());
		} else {
			node.put ("children", childs);
		}

		roots.put (node);
	}

	root.put ("children", roots);

	rs.close ();
	db_stmt.close ();

	_r.put ("success", true);
	_r.put ("data", root);
} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
} finally {
	out.print (_r);
}
%>
