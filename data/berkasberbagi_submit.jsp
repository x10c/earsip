<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%
Connection	db_con	= null;
Statement	db_stmt	= null;
String		db_url	= "";
String		q		= "";
String		data	= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	db_stmt = db_con.createStatement ();
	String		berkas_id		= request.getParameter ("berkas_id");
	String		hak_akses_id	= request.getParameter ("hak_akses_id");
	JSONArray	pegs			= new JSONArray (request.getParameter ("bagi_ke_peg_id"));

	q	=" delete from m_berkas_berbagi"
		+" where berkas_id = "+ berkas_id;

	db_stmt.executeUpdate (q);

	q	=" update m_berkas set akses_berbagi_id = "+ hak_akses_id +" where id = "+ berkas_id +";";

	int len = pegs.length ();
	if (len > 0) {
		q	+=" insert into m_berkas_berbagi (berkas_id, bagi_ke_peg_id)"
			+ " values ";

		for (int i = 0; i < len; i++) {
			if (i > 0) {
				q += ",";
			}
			q +=" ("+ berkas_id +","+ pegs.getString (i) +")";
		}
	}

	db_stmt.executeUpdate (q);

	out.print ("{success:true,info:'Data berkas berbagi telah tersimpan.'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
