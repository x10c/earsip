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

	q	=" select	dir_id"
		+" ,		parent_dir_id"
		+" ,		dir_name"
		+" from		m_direktori"
		+" where	parent_dir_id = "+ id;

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		node	= new JSONObject ();
		name	= rs.getString ("dir_name");
		id		= Integer.parseInt (rs.getString ("dir_id"));

		node.put ("id", id);
		node.put ("pid", rs.getString("parent_dir_id"));
		node.put ("text", name);
		node.put ("iconCls", "dir16");

		childs = get_list_dir (id, db_con);

		if (childs.length () <= 0) {
			node.put ("leaf", true);
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
	String		user_name	= (String) session.getAttribute ("user.name");
	int			id			= 0;

	q	=" select	dir_id"
		+" from		m_direktori"
		+" where	user_id			= "+ user_id
		+" and		parent_dir_id	= 0";

	rs = db_stmt.executeQuery (q);

	if (! rs.next ()) {
		out.print("{success:false,info:'Direktori user \""+ user_id +"\"  belum ada!'}");
		return;
	}

	id = Integer.parseInt(rs.getString("dir_id"));

	node.put("id", id);
	node.put("pid", 0);
	node.put("text", user_name);
	node.put("iconCls", "dir16");

	childs = get_list_dir (id, db_con);

	if (childs.length () <= 0) {
		node.put ("leaf", true);
	} else {
		node.put ("children", childs);
	}

	rs.close ();
	out.print ("{success:true,data:"+ node +"}");
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","\\'") +"'}");
}
%>
