<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
String		db_url		= "";
String		data		= "";

int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || db_con.isClosed ()) {
		db_url = (String) session.getAttribute ("db.url");
		if (db_url == null) {
			response.sendRedirect (request.getContextPath ());
			return;
		}

		Class.forName ((String) session.getAttribute ("db.class"));

		db_con = DriverManager.getConnection (db_url);

		session.setAttribute ("db.con", (Object) db_con);
	}

	db_stmt = db_con.createStatement ();

	q	=" select	PEG.id"
		+" ,		PEG.grup_id"
		+" ,		PEG.nip"
		+" ,		PEG.nama"
		+" from		m_pegawai		PEG"
		+" ,		m_grup			GRUP"
		+" where	PEG.grup_id		= GRUP.id";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data	+="{ user_id	: "+ rs.getString ("id")
				+ ", grup_id	: "+ rs.getString ("grup_id")
				+ ", user_nip	:'"+ rs.getString ("nip") +"'"
				+ ", user_name	:'"+ rs.getString ("nama") +"'"
				+ "}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
