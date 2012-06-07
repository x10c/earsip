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

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath ());
		return;
	}
	String pemusnahan_id	 = request.getParameter ("pemusnahan_id");
	q	=" select	berkas_id"
		+" ,		keterangan"
		+" ,		jml_lembar"
		+" ,		jml_set"
		+" ,		jml_berkas"
		+" from		t_pemusnahan_rinci"
		+" where	pemusnahan_id = "+ pemusnahan_id;

	db_stmt	= db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ berkas_id		: "+ rs.getString ("berkas_id")
				+ "\n, keterangan		:'"+ rs.getString ("keterangan") + "'"
				+ "\n, jml_lembar		: "+ rs.getString ("jml_lembar")
				+ "\n, jml_set			: "+ rs.getString ("jml_set")
				+ "\n, jml_berkas		: "+ rs.getString ("jml_berkas")
				+ "\n}";
	}

	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
