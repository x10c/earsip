<%--
 % Copyright 2012 - kilabit.org
 %
 % Author(s):
 %  - m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
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

	return nodes;
} catch (Exception e) {
	log("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
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

	Statement	db_stmt		= db_con.createStatement();
	ResultSet	rs			= null;
	String		data		= "";
	JSONArray	childs		= null;
	JSONObject	root		= new JSONObject ();
	JSONArray	roots		= new JSONArray ();
	JSONObject	node		= null;
	String		user_id		= (String) session.getAttribute ("user.id");
	String		user_name	= (String) session.getAttribute ("user.nama");
	int			peg_id		= 0;
	String		nama		= "";

	q	=" select	distinct"
		+" 			pegawai_id"
		+" ,		m_pegawai.nama"
		+" from		m_berkas"
		+" ,		m_pegawai"
		+" where	akses_berbagi_id in (3,4)"
		+" and		pegawai_id	= m_pegawai.id"
		+" and		pegawai_id	!= "+ user_id
		+" union all"
		+" select	distinct"
		+"			pegawai_id"
		+" ,		m_pegawai.nama"
		+" from		m_berkas"
		+" ,		m_berkas_berbagi"
		+" ,		m_pegawai"
		+" where	(akses_berbagi_id in (1,2)"
		+" and		m_berkas.id		= berkas_id"
		+" and		bagi_ke_peg_id	= "+ user_id +")"
		+" and		pegawai_id		= m_pegawai.id"
		+" and		pegawai_id		!= "+ user_id
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

		node.put ("id", nama +"_"+ peg_id);
		node.put ("pid", 0);
		node.put ("text", nama);
		node.put ("pegawai_id", peg_id);

		childs = get_top_list_dir (db_con, user_id, peg_id, 0);

		if (childs.length () <= 0) {
			node.put ("children", new JSONArray());
		} else {
			node.put ("children", childs);
		}

		roots.put (node);
	}

	root.put ("children", roots);

	rs.close ();
	out.print ("{success:true,data:"+ root +"}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
