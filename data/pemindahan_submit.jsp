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
Statement			db_stmt	= null;
ResultSet			rs		= null;
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
		
		if (status.equalsIgnoreCase ("true")) {
			status = "1";
		} else {
			status = "0";
		}
		
	} else {
		uk_id			= request.getParameter ("unit_kerja_id");
		kode			= request.getParameter ("kode");
		tgl				= request.getParameter ("tgl");
		nm_petugas		= request.getParameter ("nama_petugas");
		status			= request.getParameter ("status");
		pj_unit_kerja	= request.getParameter ("pj_unit_kerja");
		pj_unit_arsip	= request.getParameter ("pj_unit_arsip");
	}
	
	
	if ((uk_id == null) || (nm_petugas == null))
	{
		String	user_id = (String)session.getAttribute ("user.id");
		q ="	select unit_kerja_id as uk_id, nama from m_pegawai where id = "+ user_id;
		db_stmt = db_con.createStatement();
		rs		= db_stmt.executeQuery (q);
		if (rs.next ()){
			uk_id = rs.getString ("uk_id");
			nm_petugas	= rs.getString ("nama");
		}
		
	}
	
	if (action.equalsIgnoreCase ("create")) {
		q	=" 	insert into t_pemindahan ("
			+" 	unit_kerja_id"
			+",	kode"
			+",	tgl"
			+", nama_petugas"
			+",	pj_unit_kerja"
			+", pj_unit_arsip)"
			+" 	values (?, ?, ?, ?, ?, ?)";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (uk_id));
		db_pstmt.setString (2, kode);
		db_pstmt.setDate (3, Date.valueOf (tgl));
		db_pstmt.setString (4, nm_petugas);
		db_pstmt.setString (5, pj_unit_kerja);
		db_pstmt.setString (6, pj_unit_arsip);
		

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" 	update	t_pemindahan "
			+" 	set	unit_kerja_id = ?"
			+",	kode = ?"
			+",	tgl = ?"
			+", nama_petugas = ?"
			+",	pj_unit_kerja = ?"
			+", pj_unit_arsip = ?"
			+" where	id	 = ?";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (uk_id));
		db_pstmt.setString (2, kode);
		db_pstmt.setDate (3, Date.valueOf (tgl));
		db_pstmt.setString (4, nm_petugas);
		db_pstmt.setString (5, pj_unit_kerja);
		db_pstmt.setString (6, pj_unit_arsip);
		db_pstmt.setInt (7, Integer.parseInt (id));

	} else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from t_pemindahan where id = ?";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (id));
	}

	db_pstmt.executeUpdate ();
	out.print ("{success:true,info:'Data Pemindahan telah tersimpan.Silahkan isi Daftar Berkas'}");
	rs.close ();
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
