<%@ page import="java.sql.Connection" %>
<%
	Connection	db_con	= (Connection) session.getAttribute("db.con");
	Cookie[]	cookies	= request.getCookies ();
	String		c_path	= request.getContextPath ();
	String		c_name	= "";

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			c_name = cookies[i].getName ();
			if (c_name.equalsIgnoreCase ("earsip.sid")
			||  c_name.equalsIgnoreCase ("earsip.user.id")
			||  c_name.equalsIgnoreCase ("earsip.user.unit_kerja_id")
			||  c_name.equalsIgnoreCase ("earsip.user.grup_id")
			||  c_name.equalsIgnoreCase ("earsip.user.nama")
			||  c_name.equalsIgnoreCase ("earsip.user.nip")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			}
		}
	}

	session.removeAttribute ("user.id");
	session.removeAttribute ("user.unit_kerja_id");
	session.removeAttribute ("user.grup_id");
	session.removeAttribute ("user.nama");
	session.removeAttribute ("user.nip");

	if (db_con != null && !db_con.isClosed()) {
		db_con.close();
	}

	out.print ("{success:true}");
%>
