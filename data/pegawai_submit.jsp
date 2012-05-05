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

BufferedReader	reader	= null;
StringBuilder	sb		= new StringBuilder();
JSONObject		o		= null;
String			line	= "";
String			data	= "";

String			action			= "";
String			id				= "";
String			nip				= "";
String			nama			= "";
String			unit_kerja_id	= "";
String			jabatan_id		= "";
String			grup_id			= "";
String			password		= "";
String			status			= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	action			= request.getParameter ("action");
	id				= request.getParameter ("id");

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
		nip				= o.getString ("nip");
		nama			= o.getString ("nama");
		unit_kerja_id	= o.getString ("unit_kerja_id");
		jabatan_id		= o.getString ("jabatan_id");
		grup_id			= o.getString ("grup_id");
		status			= o.getString ("status");

		if (status.equalsIgnoreCase ("true")) {
			status = "1";
		} else {
			status = "0";
		}
	} else {
		nip				= request.getParameter ("nip");
		nama			= request.getParameter ("nama");
		unit_kerja_id	= request.getParameter ("unit_kerja_id");
		jabatan_id		= request.getParameter ("jabatan_id");
		grup_id			= request.getParameter ("grup_id");
		password		= request.getParameter ("password");
		status			= request.getParameter ("status");
	}

	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into m_pegawai (nip, nama, unit_kerja_id, jabatan_id, grup_id, psw)"
			+" values (?, ?, ?, ?, ?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setString (1, nip);
		db_stmt.setString (2, nama);
		db_stmt.setInt (3, Integer.parseInt (unit_kerja_id));
		db_stmt.setInt (4, Integer.parseInt (jabatan_id));
		db_stmt.setInt (5, Integer.parseInt (grup_id));
		db_stmt.setString (6, password);

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	m_pegawai "
			+" set		nip				= ?"
			+" ,		nama			= ?"
			+" ,		unit_kerja_id	= ?"
			+" ,		jabatan_id		= ?"
			+" ,		grup_id			= ?"
			+" ,		status			= ?";
		if (! password.isEmpty () || ! password.equals ("")) {
			q	+=" ,	psw				= ?";
		}
		q	+=" where	id				= ?";
		
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setString (1, nip);
		db_stmt.setString (2, nama);
		db_stmt.setInt (3, Integer.parseInt (unit_kerja_id));
		db_stmt.setInt (4, Integer.parseInt (jabatan_id));
		db_stmt.setInt (5, Integer.parseInt (grup_id));
		db_stmt.setInt (6, Integer.parseInt (status));

		if (! password.isEmpty () || ! password.equals ("")) {
			db_stmt.setString (7, password);
			db_stmt.setInt (8, Integer.parseInt (id));
		} else {
			db_stmt.setInt (7, Integer.parseInt (id));
		}
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true,info:'Data pegawai \""+ nama +"\" telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
