<%--
 % Copyright 2012 - kilabit.org
 %
 % Author(s):
 %	- m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%
try {
	String				rpath	= config.getServletContext ().getRealPath ("/");
	String				repo	= (String) session.getAttribute ("sys.repository_root");
	String				berkas	= request.getParameter ("berkas");
	String				nama	= request.getParameter ("nama");
	File				f		= new File (rpath + repo +"/"+ berkas);
	FileInputStream		fis		= new FileInputStream (f);
	ServletOutputStream	ostream	= response.getOutputStream();
	byte[]				obyte	= new byte[4096];

	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition","attachment;filename="+ nama);

	while (fis.read (obyte, 0, 4096) != -1) {
		ostream.write (obyte, 0, 4096);
	}

	fis.close ();
	ostream.flush ();
	ostream.close ();
} catch (Exception e) {
	out.print ("{success:false,info:'"
			+ e.toString ().replace ("'","\\'").replace ("\"","\\\"") +"'}");
}
%>
