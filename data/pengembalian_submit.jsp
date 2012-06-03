<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Types" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%
Connection			db_con	= null;
PreparedStatement	db_pstmt	= null;
Statement			db_stmt	= null;
String				db_url	= "";
String				q		= "";
String				data	= "";
BufferedReader	reader		= null;
StringBuilder	sb			= new StringBuilder();
JSONObject		o			= null;
String			line		= "";
String			action		= "";

String		id						= "";
String		tgl_kembali        		= "";



try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}
	
	action	= request.getParameter ("action");
	id 		= request.getParameter ("id");
	tgl_kembali = request.getParameter ("tgl_kembali");
			
	q	=" update	t_peminjaman"
		+" set tgl_kembali = ?"
		+" where	id = ?";
	
	db_pstmt = db_con.prepareStatement (q);
	db_pstmt.setDate (1, Date.valueOf(tgl_kembali));
	db_pstmt.setInt (2, Integer.parseInt(id));
	db_pstmt.executeUpdate ();
		
	db_stmt = db_con.createStatement ();
	q	=" update m_berkas  set arsip_status_id = 0"
		+" where id in (select berkas_id as id from peminjaman_rinci where peminjaman_id = " + id + ")" ;
	db_stmt.executeUpdate (q);
			
	out.print ("{success:true,info:'Data Pengembalian berhasil disimpan'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
