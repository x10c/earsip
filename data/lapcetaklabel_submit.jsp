<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
  
<%@ page import="net.sf.jasperreports.engine.JasperExportManager" %>
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
Locale	locale				= null;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}
	
	String unit_kerja_id	= request.getParameter ("unit_kerja_id");
	String kode_rak			= request.getParameter ("kode_rak");
	String kode_box			= request.getParameter ("kode_box");
	
	locale = new Locale ("in", "ID");
	parameters = new HashMap ();
	
	parameters.put ("div_id", Integer.parseInt(unit_kerja_id));
	parameters.put ("kode_rak", kode_rak);
	parameters.put ("kode_box", kode_box);
	parameters.put ("REPORT_LOCALE", locale);
	
	jasperreport = (JasperReport) JRLoader.loadObject(application.getRealPath ("report" + File.separator + "label.jasper"));
	jasperprint = JasperFillManager.fillReport(jasperreport, parameters, db_con);
	response.setContentType("Application/pdf");
	JasperExportManager.exportReportToPdfStream(jasperprint, response.getOutputStream ());
	
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''").replace("\"", "\\\"") +"'}");
}

%>