<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%
Connection			db_con	= null;
PreparedStatement	db_stmt	= null;
Statement			db_stmt2= null;
ResultSet			rs		= null;
String				db_url	= "";
String				q		= "";
String				data	= "";

BufferedReader	reader		= null;
StringBuilder	sb			= new StringBuilder();
JSONObject		o			= null;
String			line		= "";
String			action		= "";

String			pemindahan_id	= "";
String			berkas_id		= "";
String			nama            = "";
String			arsip_status_id = "";
String			kode_folder     = "";
String			kode_rak        = "";
String			kode_box        = "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	action	= request.getParameter ("action");
	pemindahan_id = request.getParameter ("pemindahan_id");
	berkas_id = request.getParameter ("berkas_id");

	if (pemindahan_id == null || berkas_id == null)
	{
		reader	= request.getReader ();
		line	= reader.readLine ();
		while (line != null) {
			sb.append (line + "\n");
			line = reader.readLine();
		}
		reader.close();

		data			= sb.toString();
		o				= (JSONObject) new JSONObject (data);

		pemindahan_id	= o.getString ("pemindahan_id");
		berkas_id 		= o.getString ("berkas_id");
		nama			= o.getString ("nama");
		arsip_status_id = o.getString ("arsip_status_id");
		kode_folder     = o.getString ("kode_folder");
		kode_rak        = o.getString ("kode_rak");
		kode_box        = o.getString ("kode_box");
	} else
	{
		nama			= request.getParameter ("nama");
		arsip_status_id = request.getParameter ("arsip_status_id");
		kode_folder     = request.getParameter ("kode_folder");
		kode_rak        = request.getParameter ("kode_rak");
		kode_box        = request.getParameter ("kode_box");
	}

	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into t_pemindahan_rinci (pemindahan_id, berkas_id)"
			+" values (?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (pemindahan_id));
		db_stmt.setInt (2, Integer.parseInt (berkas_id));
	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update 	m_berkas"
			+" set 		status = 0"
			+" where 	id = ? or pid = ?";

		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (berkas_id));
		db_stmt.setInt (2, Integer.parseInt (berkas_id));

		db_stmt.executeUpdate ();

		q	=" select * from m_arsip where berkas_id = "+berkas_id;

		db_stmt2 = db_con.createStatement ();
		rs		 = db_stmt2.executeQuery (q);
		if (rs.next ())
		{
			q	=" update 	m_arsip"
				+" set 		kode_folder = ?"
				+" , 		kode_rak = ?"
				+" , 		kode_box = ?"
				+" where	berkas_id = ?";
		}else
		{
			q	=" insert into 	m_arsip"
				+" ( 		kode_folder"
				+" , 		kode_rak"
				+" , 		kode_box"
				+" ,		berkas_id)"
				+" values 	(?, ?, ?, ?)";
		}

		db_stmt = db_con.prepareStatement (q);

		db_stmt.setString (1, kode_folder);
		db_stmt.setString (2, kode_rak);
		db_stmt.setString (3, kode_box);
		db_stmt.setInt (4, Integer.parseInt (berkas_id));

		rs.close ();
	} else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from t_pemindahan_rinci where pemindahan_id = ? and berkas_id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (pemindahan_id));
		db_stmt.setInt (2, Integer.parseInt (berkas_id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true,info:'Data Berkas berhasil disimpan'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
