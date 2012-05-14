<%--
 % Copyright 2011 - PT. Perusahaan Gas Negara Tbk.
 %
 % Author(s):
 % + PT. Awakami
 %   - m.shulhan (ms@kilabit.org)
 %
 % TODO: replace with a single query.
--%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
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
		+" and		status		= 1";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node	= new JSONObject ();
		name	= rs.getString ("nama");
		id		= rs.getInt ("id");

		node.put ("id", id);
		node.put ("pid", rs.getInt ("pid"));
		node.put ("text", name);

		childs = get_list_dir (id, db_con);

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
	JSONObject	node		= new JSONObject();
	String		user_id		= (String) session.getAttribute ("user.id");
	String		user_name	= (String) session.getAttribute ("user.nama");
	int			id			= 0;

	q	=" select	id"
		+" ,		nama"
		+" from		m_berkas"
		+" where	pegawai_id	= "+ user_id
		+" and		pid			= 0"
		+" and		tipe_file	= 0";

	rs = db_stmt.executeQuery (q);

	if (! rs.next ()) {
		out.print("{success:false,info:'Direktori user \""+ user_id +"\"  belum ada!'}");
		return;
	}

	id = rs.getInt ("id");

	node.put ("id", id);
	node.put ("pid", 0);
	node.put ("text", rs.getString ("nama"));

	childs = get_list_dir (id, db_con);

	if (childs.length () <= 0) {
		node.put ("children", new JSONArray());
	} else {
		node.put ("children", childs);
	}

	rs.close ();
	out.print ("{success:true,data:"+ node +"}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
