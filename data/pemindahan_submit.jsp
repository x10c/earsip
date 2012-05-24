<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%
Connection			db_con	= null;
PreparedStatement	db_pstmt= null;
String				db_url	= "";
String				q		= "";
String				data	= "";

BufferedReader	reader		= null;
StringBuilder	sb			= new StringBuilder();
JSONObject		o			= null;
String			line		= "";
String			action		= "";

String			id			= "";
String			uk_id		= "";
String			kode		= "";
String			tgl			= "";
String			status			= "";
String			nm_petugas		= "";
String			pj_unit_kerja	= "";
String			pj_unit_arsip	= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	action	= request.getParameter ("action");
	id	= request.getParameter ("id");
	

	if (id == null) {
		reader	= request.getReader ();
		line	= reader.readLine ();
		while (line != null) {
			sb.append (line + "\n");
			line = reader.readLine();
		}
		reader.close();

		data			= sb.toString();
		o				= (JSONObject) new JSONObject (data);
		id				= o.getString ("id");
		uk_id			= o.getString ("unit_kerja_id");
		kode			= o.getString ("kode");
		tgl				= o.getString ("tgl");
		nm_petugas		= o.getString ("nama_petugas");
		status			= o.getString ("status");
		pj_unit_kerja	= o.getString ("pj_unit_kerja");
		pj_unit_arsip	= o.getString ("pj_unit_arsip");
		
		
		
	} else {
		uk_id			= request.getParameter ("unit_kerja_id");
		kode			= request.getParameter ("kode");
		tgl				= request.getParameter ("tgl");
		nm_petugas		= request.getParameter ("nama_petugas");
		status			= request.getParameter ("status");
		pj_unit_kerja	= request.getParameter ("pj_unit_kerja");
		pj_unit_arsip	= request.getParameter ("pj_unit_arsip");
	}
	
	
	if (status == null || status.equals ("")||(status.equals ("0"))) {
			status = "0";
		} else {
			status = "1";
		}
	
	if (uk_id == null || uk_id.equals (""))
	{
		uk_id = (String)session.getAttribute ("user.unit_kerja_id");
	}
		
	if (action.equalsIgnoreCase ("create")) {
		q	=" 	insert into t_pemindahan ("
			+" 	unit_kerja_id"
			+",	kode"
			+",	tgl"
			+",	pj_unit_kerja)"
			+" 	values (?, ?, ?, ?)";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (uk_id));
		db_pstmt.setString (2, kode);
		db_pstmt.setDate (3, Date.valueOf (tgl));
		db_pstmt.setString (4, pj_unit_kerja);
		

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" 	update	t_pemindahan "
			+" 	set	unit_kerja_id = ?"
			+",	kode = ?"
			+",	tgl = ?"
			+", status = ?"
			+", nama_petugas = ?"
			+",	pj_unit_kerja = ?"
			+", pj_unit_arsip = ?"
			+" where	id	 = ?";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (uk_id));
		db_pstmt.setString (2, kode);
		db_pstmt.setDate (3, Date.valueOf (tgl));
		db_pstmt.setInt (4, Integer.parseInt(status));
		db_pstmt.setString (5, nm_petugas);
		db_pstmt.setString (6, pj_unit_kerja);
		db_pstmt.setString (7, pj_unit_arsip);
		db_pstmt.setInt (8, Integer.parseInt (id));

	} else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from t_pemindahan where id = ?";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (id));
	}

	db_pstmt.executeUpdate ();
	out.print ("{success:true,info:'Data Pemindahan telah tersimpan'}");
	
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
