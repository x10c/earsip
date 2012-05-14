<%--
 % Copyright 2012 - kilabit.org
 %
 % Author(s):
 %	- m.shulhan (ms@kilabit.org)
--%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.DataInputStream" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%
try {
	String				rpath	= config.getServletContext ().getRealPath ("/");
	String				repo	= (String) session.getAttribute ("sys.repository_root");
	String				berkas	= request.getParameter ("berkas");
	String				nama	= request.getParameter ("nama");
	String				fpath	= rpath + repo +"/"+ berkas;
	File				f		= new File (fpath);
	ServletOutputStream	ostream	= response.getOutputStream();
	ServletContext      context	= getServletConfig().getServletContext();
	String              mimetype= context.getMimeType (fpath);
	byte[]				obyte	= new byte[4096];
	int					length	= 0;

	response.setContentType ((mimetype != null) ? mimetype : "application/octet-stream");
	response.setContentLength ((int) f.length());
	response.setHeader("Content-Disposition","attachment;filename="+ nama);

	DataInputStream dis = new DataInputStream (new FileInputStream(f));

	while ((dis != null) && ((length = dis.read (obyte)) != -1)) {
		ostream.write (obyte, 0, length);
	}

	dis.close ();
	ostream.flush ();
	ostream.close ();
} catch (Exception e) {
	out.print ("{success:false,info:'"
			+ e.toString ().replace ("'","\\'").replace ("\"","\\\"") +"'}");
}
%>
