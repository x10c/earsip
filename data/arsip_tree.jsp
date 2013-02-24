<%--
	Copyright 2013 - kilabit.org

	Author(s):
	- m.shulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp"%>
<%!
public JSONArray get_list_dir (Connection db_con, int unit_kerja_id
								, String kode_rak, String kode_box
								, String kode_folder, int pid
								, int depth)
{
	JSONArray	nodes	= new JSONArray ();
	Statement	db_stmt = null;
	ResultSet	rs		= null;
	String		q		= "";
	JSONObject	node	= null;
	JSONArray	childs	= null;
	JSONArray	_r		= new JSONArray ();
	int			id		= 0;
	String		nama	= "";
	int			index	= 0;

	try {
		db_stmt = db_con.createStatement ();

		q	=" select	id"
			+" ,		nama"
			+" from		m_berkas"
			+" where	pid			= "+ pid
			+" and		tipe_file	= 0"
			+" and		status		= 1";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			id		= rs.getInt ("id");
			nama	= rs.getString ("nama");
			node	= new JSONObject ();

			node.put ("id"				, id);
			node.put ("pid"				, pid);
			node.put ("text"			, nama);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, kode_box);
			node.put ("kode_folder"		, kode_folder);
			node.put ("type"			, "arsip_folder");
			node.put ("depth"			, depth);
			node.put ("index"			, index++);
			node.put ("leaf"			, true);

			childs = get_list_dir (db_con, unit_kerja_id, kode_rak, kode_box
									, kode_folder, id, depth + 1);

			if (childs.length () > 0) {
				node.put ("leaf"	, false);
				node.put ("children", childs);
			}

			nodes.put (node);
		}
		rs.close ();
		db_stmt.close ();

	} catch (Exception e) {
		throw e;
	} finally {
		return nodes;
	}
}

public JSONArray get_list_arsip_folder (Connection db_con, String pid
										, int unit_kerja_id
										, String kode_rak, String kode_box
										, String kode_folder, int depth)
{
	JSONArray	nodes		= new JSONArray ();
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		id			= "";
	int			arsip_id	= 0;
	JSONArray	childs		= null;
	JSONObject	node		= null;
	int			index		= 0;

	try {
		db_stmt = db_con.createStatement ();

		q	=" select	m_berkas.id"
			+" ,		nama"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		tipe_file		= 0"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'"
			+" and		kode_box		= '"+ kode_box +"'"
			+" and		kode_folder		= '"+ kode_folder +"'"
			+" and		arsip_status_id	in (0,1)";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			arsip_id	= rs.getInt ("id");

			node.put ("id"				, arsip_id);
			node.put ("pid"				, pid);
			node.put ("text"			, rs.getString ("nama"));
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, kode_box);
			node.put ("kode_folder"		, kode_folder);
			node.put ("type"			, "arsip_folder");
			node.put ("depth"			, depth);
			node.put ("index"			, index++);
			node.put ("leaf"			, true);

			childs = get_list_dir (db_con, unit_kerja_id, kode_rak, kode_box, kode_folder, arsip_id, depth + 1);

			if (childs.length () > 0) {
				node.put ("leaf", false);
				node.put ("children", childs);
			}

			nodes.put (node);
		}
		rs.close ();
		db_stmt.close ();

	} catch (Exception e) {
		throw e;
	} finally {
		return nodes;
	}
}

public JSONArray get_list_folder (Connection db_con, String pid, int unit_kerja_id
								, String kode_rak, String kode_box, int depth)
{
	JSONArray	nodes		= new JSONArray ();
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		id			= "";
	String		kode_folder	= "";
	JSONArray	childs		= null;
	JSONObject	node		= null;
	int			index		= 0;

	try {
		db_stmt = db_con.createStatement ();

		q	=" select	distinct"
			+" 			kode_folder"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'"
			+" and		kode_box		= '"+ kode_box +"'";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			kode_folder	= rs.getString ("kode_folder");
			id			= unit_kerja_id +"."+ kode_rak +"."+ kode_box +"."+ kode_folder;

			node.put ("id"				, id);
			node.put ("pid"				, pid);
			node.put ("text"			, "FOLDER - "+ kode_folder);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, kode_box);
			node.put ("kode_folder"		, kode_folder);
			node.put ("type"			, "folder");
			node.put ("depth"			, depth);
			node.put ("index"			, index++);
			node.put ("leaf"			, true);

			childs = get_list_arsip_folder (db_con, id, unit_kerja_id, kode_rak, kode_box, kode_folder, depth + 1);

			if (childs.length () > 0) {
				node.put ("leaf", false);
				node.put ("children", childs);
			}

			nodes.put (node);
		}
		rs.close ();
		db_stmt.close ();

	} catch (Exception e) {
		throw e;
	} finally {
		return nodes;
	}
}

public JSONArray get_list_box (Connection db_con, String pid, int unit_kerja_id, String kode_rak, int depth)
{
	JSONArray	nodes		= new JSONArray ();
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		id			= "";
	String		kode_box	= "";
	JSONArray	childs		= null;
	JSONObject	node		= null;
	int			index		= 0;

	try {
		db_stmt = db_con.createStatement ();

		q	=" select	distinct"
			+" 			kode_box"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			kode_box	= rs.getString ("kode_box");
			id			= unit_kerja_id +"."+ kode_rak +"."+ kode_box +".0";

			node.put ("id"				, id);
			node.put ("pid"				, pid);
			node.put ("text"			, "BOX - "+ kode_box);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, kode_box);
			node.put ("kode_folder"		, 0);
			node.put ("type"			, "box");
			node.put ("depth"			, depth);
			node.put ("index"			, index++);
			node.put ("leaf"			, true);

			childs = get_list_folder (db_con, id, unit_kerja_id, kode_rak, kode_box, depth + 1);

			if (childs.length () > 0) {
				node.put ("leaf", false);
				node.put ("children", childs);
			}

			nodes.put (node);
		}
		rs.close ();
		db_stmt.close ();
	} catch (Exception e) {
		throw e;
	} finally {
		return nodes;
	}
}

public JSONArray get_list_rak (Connection db_con, String pid, int unit_kerja_id, int depth)
{
	JSONArray	nodes		= new JSONArray ();
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		kode_rak	= "";
	String		id			= "";
	JSONArray	childs		= null;
	JSONObject	node		= null;
	int			index		= 0;

	try {
		db_stmt = db_con.createStatement ();

		q	=" select	distinct"
			+" 			kode_rak"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id;

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			kode_rak	= rs.getString ("kode_rak");
			id			= unit_kerja_id +"."+ kode_rak +".0.0";

			node.put ("id"				, id);
			node.put ("pid"				, pid);
			node.put ("text"			, "RAK - "+ kode_rak);
			node.put ("unit_kerja_id"	, unit_kerja_id);
			node.put ("kode_rak"		, kode_rak);
			node.put ("kode_box"		, 0);
			node.put ("kode_folder"		, 0);
			node.put ("type"			, "rak");
			node.put ("depth"			, depth);
			node.put ("index"			, index++);
			node.put ("leaf"			, true);

			childs = get_list_box (db_con, id, unit_kerja_id, kode_rak, depth + 1);

			if (childs.length () > 0) {
				node.put ("leaf", false);
				node.put ("children", childs);
			}

			nodes.put (node);
		}
		rs.close ();
		db_stmt.close ();
	} catch (Exception e) {
		throw e;
	} finally {
		return nodes;
	}
}
%>
<%-- Main --%>
<%
try {
	String		data			= "";
	JSONArray	childs			= null;
	JSONArray	unit_kerja		= new JSONArray ();
	JSONObject	node			= null;
	JSONObject	root			= new JSONObject ();
	int			grup_id			= Integer.parseInt (_user_gid);
	String		id				= "";
	String		nama			= "";
	int			uk_id			= 0;
	int			depth			= 1;
	int			index			= 0;

	db_stmt	= db_con.createStatement();

	q	=" select	id"
		+" ,		nama"
		+" from		m_unit_kerja";

	/* if user is  not in grup arsip, they can see all files from all unit-kerja */
	if (grup_id != 3) {
		q +=" where	id = "+ _user_uk;
	}

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		uk_id	= rs.getInt ("id");
		nama	= rs.getString ("nama");
		id		= uk_id +".0.0.0";
		node	= new JSONObject ();

		node.put ("id", id);
		node.put ("pid", 0);
		node.put ("text", nama);
		node.put ("unit_kerja_id", uk_id);
		node.put ("kode_rak", 0);
		node.put ("kode_box", 0);
		node.put ("kode_folder", 0);
		node.put ("type", "unit_kerja");
		node.put ("index", index++);
		node.put ("leaf", true);

		childs = get_list_rak (db_con, id, uk_id, depth + 1);

		if (childs.length () > 0) {
			node.put ("leaf", false);
			node.put ("children", childs);
		}

		unit_kerja.put (node);
	}

	rs.close ();
	db_stmt.close ();

	root.put ("id", 0);
	root.put ("pid", 0);
	root.put ("text", "Folder arsip");
	root.put ("unit_kerja_id", 0);
	root.put ("kode_rak", 0);
	root.put ("kode_box", 0);
	root.put ("kode_folder", 0);
	root.put ("type", "root");
	root.put ("depth", depth);
	root.put ("index", 0);
	root.put ("leaf", true);
	root.put ("children", unit_kerja);

	if (unit_kerja.length () > 0) {
		root.put ("leaf", false);
	}

	childs = new JSONArray ();
	childs.put (root);

	_r.put ("success", true);
	_r.put ("children", childs);
} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("children", "[]");
	_r.put ("info", e);
} finally {
	out.print (_r);
}
%>
