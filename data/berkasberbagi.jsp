<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
String		data		= "";
int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	String user_id		= (String) session.getAttribute ("user.id");
	String berkas_id	= request.getParameter ("berkas_id");

	q	=" select	id"
		+" ,		bagi_ke_peg_id"
		+" from		m_berkas_berbagi"
		+" where	berkas_id = "+ berkas_id;

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}

		data	+="\n{ id             :"+ rs.getString ("id")
				+ "\n, berkas_id      :"+ berkas_id
				+ "\n, bagi_ke_peg_id :"+ rs.getString ("bagi_ke_peg_id")
				+ "\n}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
