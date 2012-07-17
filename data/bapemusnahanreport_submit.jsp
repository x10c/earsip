<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

  
<%@ page import="net.sf.jasperreports.engine.JRExporter" %>
<%@ page import="net.sf.jasperreports.engine.JRExporterParameter" %>
<%@ page import="net.sf.jasperreports.engine.export.JRPdfExporter" %>
<%@ page import="net.sf.jasperreports.engine.JasperFillManager" %>
<%@ page import="net.sf.jasperreports.engine.JasperPrint" %>
<%@ page import="net.sf.jasperreports.engine.JasperReport" %>
<%@ page import="net.sf.jasperreports.engine.util.JRLoader" %>
  
<%@ page import="java.sql.Connection" %>


<%	
Connection	db_con			= null;
Map parameters 				= null;
JasperReport jasperreport 	= null;
JasperPrint	 jasperprint	= null;
Locale		locale			= null;
JRExporter	exporter		= null;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}
	
	String pemusnahan_id	= request.getParameter ("pemusnahan_id");
	locale = new Locale ("in", "ID");
	parameters = new HashMap ();
	
	parameters.put ("pemusnahan_id",Integer.parseInt(pemusnahan_id));
	parameters.put ("REPORT_LOCALE", locale);
	
	List <JasperPrint> jlist= new ArrayList ();
	jasperreport = (JasperReport) JRLoader.loadObject(application.getRealPath ("report" + File.separator + "pemusnahan.jasper"));
	jasperprint = JasperFillManager.fillReport(jasperreport, parameters, db_con);
	jlist.add (jasperprint);
	jasperreport = (JasperReport) JRLoader.loadObject(application.getRealPath ("report" + File.separator + "pemusnahan_sub.jasper"));
	jasperprint = JasperFillManager.fillReport(jasperreport, parameters, db_con);
	jlist.add (jasperprint);
	exporter	= new JRPdfExporter ();
	response.setHeader("Content-Disposition","attachment;filename=Berita Acara Pemusnahan.pdf");
	exporter.setParameter (JRExporterParameter.JASPER_PRINT_LIST, jlist);
	exporter.setParameter (JRExporterParameter.OUTPUT_STREAM, response.getOutputStream ());
	exporter.exportReport ();
	
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''").replace("\"", "\\\"") +"'}");
}

%>