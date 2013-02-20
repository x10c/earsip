<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%
Connection			db_con	= null;
PreparedStatement	db_stmt	= null;
String				db_url	= "";
String				q		= "";
String				data	= "";

BufferedReader	reader		= null;
StringBuilder	sb			= new StringBuilder();
JSONObject		o			= null;
String			line		= "";
String			action		= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	action	= request.getParameter ("action");

	reader	= request.getReader ();
	line	= reader.readLine ();
	while (line != null) {
		sb.append (line + "\n");
		line = reader.readLine();
	}
	reader.close();

	data			= sb.toString();
	o				= (JSONObject) new JSONObject (data);

	String id		= o.getString ("id");
	String kode		= o.getString ("kode");
	String nama		= o.getString ("nama");
	String pimpinan	= o.getString ("nama_pimpinan");
	String ket		= o.getString ("keterangan");

	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into m_unit_kerja (kode, nama, nama_pimpinan, keterangan, urutan)"
			+" values (?, ?, ?, ?, (select max (urutan) + 1 from m_unit_kerja))";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setString (1, kode);
		db_stmt.setString (2, nama);
		db_stmt.setString (3, pimpinan);
		db_stmt.setString (4, ket);

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	m_unit_kerja "
			+" set		kode			= ?"
			+" ,		nama			= ?"
			+" ,		nama_pimpinan	= ?"
			+" ,		keterangan		= ?"
			+" where	id				= ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setString (1, kode);
		db_stmt.setString (2, nama);
		db_stmt.setString (3, pimpinan);
		db_stmt.setString (4, ket);
		db_stmt.setInt (5, Integer.parseInt (id));

	} else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from m_unit_kerja where id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
