<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect(request.getContextPath());
		return;
	}

	db_stmt				= db_con.createStatement ();
	String user_nip		= (String) session.getAttribute ("user.nip");
	String from_peg		= request.getParameter ("from_peg");
	String to_peg		= request.getParameter ("to_peg");
	String to_peg_id	= "";

	if (from_peg.equals (to_peg)) {
		out.print ("{success:false,info:'Data Pegawai sumber sama dengan Pegawai tujuan'}");
		return;
	}

	q	=" select id from m_berkas where pid = 0 and pegawai_id = "+ to_peg;

	rs = db_stmt.executeQuery (q);

	if (! rs.next ()) {
		out.print ("{success:false,info:'Berkas pegawai tujuan belum ada.'}");
		return;
	}

	to_peg_id = rs.getString ("id");

	/* set old berkas pid to new pegawai */
	q	=" update	m_berkas"
		+" set		pid			= "+ to_peg_id
		+" where id in ("
		+"	select id from m_berkas where pid = (select id from m_berkas where pid = 0 and pegawai_id = "+ from_peg
		+" ))";

	db_stmt.executeUpdate (q);

	/* set all old berkas pegawai_id to new pegawai */
	q	=" update	m_berkas"
		+" set		pegawai_id	= "+ to_peg
		+" where	pegawai_id	= "+ from_peg
		+" and		pid			!= 0";

	db_stmt.executeUpdate (q);

	out.print ("{success:true, info:'Semua berkas telah dipindahkan!'}");
	rs.close ();
	db_stmt.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
