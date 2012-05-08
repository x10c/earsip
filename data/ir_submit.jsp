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

String			id				= "";
String			berkas_klas_id	= "";
String			ket				= "";

try {
	
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}
	action	= request.getParameter ("action");
	id 		= request.getParameter ("id");
	
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
		berkas_klas_id	= o.getString ("berkas_klas_id");
		ket				= o.getString ("keterangan");

	} else {
		berkas_klas_id	= request.getParameter ("berkas_klas_id");
		ket				= request.getParameter ("keterangan");
	}
	
	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into r_ir (berkas_klas_id, keterangan)"
			+" values (?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt	  (1, Integer.parseInt(berkas_klas_id));
		db_stmt.setString (2, ket);

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	r_ir "
			+" set		berkas_klas_id 	= ?"
			+" ,		keterangan		= ?"
			+" where	id				= ?";
		
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt(1, Integer.parseInt (berkas_klas_id));
		db_stmt.setString (2, ket);
		db_stmt.setInt (3, Integer.parseInt (id));

	}else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from r_ir where id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true,info:'Indeks Relatif \""+ ket +"\" telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
