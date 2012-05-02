<%
	Cookie[]	cookies	= request.getCookies ();
	String		c_path	= request.getContextPath ();
	String		c_name	= "";

	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			c_name = cookies[i].getName ();
			if (c_name.equalsIgnoreCase ("earsip.sid")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			} else if (c_name.equalsIgnoreCase ("earsip.user.id")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			} else if (c_name.equalsIgnoreCase ("earsip.user.unit_kerja_id")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			} else if (c_name.equalsIgnoreCase ("earsip.user.unit_kerja_id")) {
			} else if (c_name.equalsIgnoreCase ("earsip.user.grup_id")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			} else if (c_name.equalsIgnoreCase ("earsip.user.nama")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			} else if (c_name.equalsIgnoreCase ("earsip.user.nip")) {
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

	out.print ("{success:true}");
%>
