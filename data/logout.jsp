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
			} else if (c_name.equalsIgnoreCase ("earsip.user.subdiv_id")) {
				cookies[i].setMaxAge (0);
				cookies[i].setPath (c_path);
				response.addCookie (cookies[i]);
			} else if (c_name.equalsIgnoreCase ("earsip.user.name")) {
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
	session.removeAttribute ("user.subdiv_id");
	session.removeAttribute ("user.name");
	session.removeAttribute ("user.nip");

	out.print ("{success:true}");
%>
