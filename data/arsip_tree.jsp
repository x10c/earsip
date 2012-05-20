<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%!
public JSONArray get_list_folder (Connection db_con, int unit_kerja_id, String kode_rak, String kode_box)
{
	JSONArray	nodes		= new JSONArray ();
	ResultSet	rs			= null;
	String		q			= "";
	String		kode_folder	= "";
	JSONArray	childs		= null;
	JSONObject	node		= null;
try {
	Statement	db_stmt = db_con.createStatement ();

	q	=" select	distinct"
		+" 			kode_folder"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		unit_kerja_id	= unit_kerja_id"
		+" and		kode_rak		= '"+ kode_rak +"'"
		+" and		kode_box		= '"+ kode_box +"'";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node		= new JSONObject ();
		kode_folder	= rs.getString ("kode_folder");

		node.put ("id", kode_folder);
		node.put ("pid", kode_box);
		node.put ("text", kode_folder);
		node.put ("unit_kerja_id", unit_kerja_id);
		node.put ("kode_rak", kode_rak);
		node.put ("kode_box", kode_box);
		node.put ("kode_folder", kode_folder);

		nodes.put (node);
	}

	rs.close();

	return nodes;
} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	return nodes;
}}

public JSONArray get_list_box (Connection db_con, int unit_kerja_id, String kode_rak)
{
	JSONArray	nodes		= new JSONArray ();
	ResultSet	rs			= null;
	String		q			= "";
	String		kode_box	= "";
	JSONArray	childs		= null;
	JSONObject	node		= null;
try {
	Statement	db_stmt = db_con.createStatement ();

	q	=" select	distinct"
		+" 			kode_box"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		unit_kerja_id	= unit_kerja_id"
		+" and		kode_rak		= '"+ kode_rak +"'";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node		= new JSONObject ();
		kode_box	= rs.getString ("kode_box");

		node.put ("id", kode_box);
		node.put ("pid", kode_rak);
		node.put ("text", kode_box);
		node.put ("unit_kerja_id", unit_kerja_id);
		node.put ("kode_rak", kode_rak);
		node.put ("kode_box", kode_box);
		node.put ("kode_folder", 0);

		childs = get_list_folder (db_con, unit_kerja_id, kode_rak, kode_box);

		if (childs.length () <= 0) {
			node.put ("children", new JSONArray());
		} else {
			node.put ("children", childs);
		}

		nodes.put (node);
	}

	rs.close();

	return nodes;
} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	return nodes;
}}

public JSONArray get_list_rak (Connection db_con, int unit_kerja_id)
{
	JSONArray	nodes	= new JSONArray ();
	ResultSet	rs			= null;
	String		q			= "";
	String		kode_rak	= "";
	JSONArray	childs		= null;
	JSONObject	node		= null;

try {
	Statement	db_stmt		= db_con.createStatement ();

	q	=" select	distinct"
		+" 			kode_rak"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		unit_kerja_id	= unit_kerja_id";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node		= new JSONObject ();
		kode_rak	= rs.getString ("kode_rak");

		node.put ("id", kode_rak);
		node.put ("pid", unit_kerja_id);
		node.put ("text", kode_rak);
		node.put ("unit_kerja_id", unit_kerja_id);
		node.put ("kode_rak", kode_rak);
		node.put ("kode_box", 0);
		node.put ("kode_folder", 0);

		childs = get_list_box (db_con, unit_kerja_id, kode_rak);

		if (childs.length () <= 0) {
			node.put ("children", new JSONArray());
		} else {
			node.put ("children", childs);
		}

		nodes.put (node);
	}

	rs.close();

	return nodes;
} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
	return nodes;
}}
%>
<%
String q = "";
try {
	Connection db_con = (Connection) session.getAttribute("db.con");
	if (db_con == null || (db_con != null && db_con.isClosed())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	Statement	db_stmt			= db_con.createStatement();
	ResultSet	rs				= null;
	String		data			= "";
	JSONArray	childs			= null;
	JSONArray	unit_kerja		= new JSONArray ();
	JSONObject	node			= null;
	JSONObject	root			= new JSONObject ();
	int			grup_id			= Integer.parseInt ((String) session.getAttribute ("user.grup_id"));
	String		unit_kerja_id	= (String) session.getAttribute ("user.unit_kerja_id");
	int			id				= 0;
	String		nama			= "";

	/* if user is in grup arsip they can see all files from all unit-kerja */
	if (grup_id == 3) {
		q	=" select	id"
			+" ,		nama"
			+" from		m_unit_kerja";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			id = rs.getInt ("id");

			node = new JSONObject ();
			node.put ("id", id);
			node.put ("pid", 0);
			node.put ("text", rs.getString ("nama"));
			node.put ("unit_kerja_id", id);
			node.put ("kode_rak", 0);
			node.put ("kode_box", 0);
			node.put ("kode_folder", 0);

			childs = get_list_rak (db_con, id);

			if (childs.length () <= 0) {
				node.put ("children", new JSONArray());
			} else {
				node.put ("children", childs);
			}

			unit_kerja.put (node);
		}

		root.put ("id", 1);
		root.put ("pid", 0);
		root.put ("text", "Folder arsip");
		root.put ("unit_kerja_id", 0);
		root.put ("kode_rak", 0);
		root.put ("kode_box", 0);
		root.put ("kode_folder", 0);

		root.put ("children", unit_kerja);
	/* otherwise he can only see files in their unit-kerja */
	} else {
		q	=" select	id"
			+" ,		nama"
			+" from		m_unit_kerja"
			+" where	id			= "+ unit_kerja_id;

		rs = db_stmt.executeQuery (q);

		if (! rs.next ()) {
			out.print("{success:false,info:'Unit kerja user \""+ unit_kerja_id +"\" tidak diketahui!'}");
			return;
		}

		id		= rs.getInt ("id");
		nama	= rs.getString ("nama");

		root.put ("id", nama);
		root.put ("pid", 0);
		root.put ("text", nama);
		root.put ("unit_kerja_id", 0);
		root.put ("kode_rak", 0);
		root.put ("kode_box", 0);
		root.put ("kode_folder", 0);

		childs = get_list_rak (db_con, id);

		if (childs.length () <= 0) {
			root.put ("children", new JSONArray());
		} else {
			root.put ("children", childs);
		}
	}

	rs.close ();
	out.print ("{success:true,data:"+ root +"}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
