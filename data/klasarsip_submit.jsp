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

String			id			= "";
String			uk_id		= "";
String			kode		= "";
String			nama		= "";
String			ket			= "";
int				jra_aktif	= 0;
int				jra_inaktif	= 0;
int				mode_arsip_id = 0;

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
		uk_id 			= o.getString ("unit_kerja_id");
		kode			= o.getString ("kode");
		nama			= o.getString ("nama");
		ket				= o.getString ("keterangan");
		jra_aktif		= o.getInt ("jra_aktif");
		jra_inaktif		= o.getInt ("jra_inaktif");
		mode_arsip_id	= o.getInt ("mode_arsip_id");
	} else {
		uk_id 			= request.getParameter ("unit_kerja_id");
		kode			= request.getParameter ("kode");
		nama			= request.getParameter ("nama");
		ket				= request.getParameter ("keterangan");
		jra_aktif		= Integer.parseInt (request.getParameter ("jra_aktif"));
		jra_inaktif		= Integer.parseInt (request.getParameter ("jra_inaktif"));
		mode_arsip_id	= Integer.parseInt (request.getParameter ("mode_arsip_id"));
	}

	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into r_berkas_klas (unit_kerja_id, kode, nama, keterangan, jra_aktif, jra_inaktif, mode_arsip_id)"
			+" values (?, ?, ?, ?, ?, ?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt(uk_id));
		db_stmt.setString (2, kode);
		db_stmt.setString (3, nama);
		db_stmt.setString (4, ket);
		db_stmt.setInt (5, jra_aktif);
		db_stmt.setInt (6, jra_inaktif);
		db_stmt.setInt (7, mode_arsip_id);

	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	r_berkas_klas "
			+" set		unit_kerja_id 	= ?"
			+" , 		kode		 	= ?"
			+" , 		nama		 	= ?"
			+" ,		keterangan		= ?"
			+" ,		jra_aktif		= ?"
			+" ,		jra_inaktif		= ?"
			+" ,		mode_arsip_id	= ?"
			+" where	id				= ?";

		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt(1, Integer.parseInt (uk_id));
		db_stmt.setString (2, kode);
		db_stmt.setString (3, nama);
		db_stmt.setString (4, ket);
		db_stmt.setInt (5, jra_aktif);
		db_stmt.setInt (6, jra_inaktif);
		db_stmt.setInt (7, mode_arsip_id);
		db_stmt.setInt (8, Integer.parseInt (id));

	}else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from r_berkas_klas where id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true,info:'Klasifikasi Arsip \""+ kode +"\" telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
