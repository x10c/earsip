<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
  
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
	
	String setelah_tgl	= request.getParameter ("setelah_tgl");
	String sebelum_tgl	= request.getParameter ("sebelum_tgl");
	
	
	locale = new Locale ("in", "ID");
	parameters = new HashMap ();
	
	SimpleDateFormat formater = new SimpleDateFormat ("yyyy-MM-dd");
	parameters.put ("REPORT_LOCALE", locale);
	parameters.put ("setelah_tgl", formater.parse(setelah_tgl));
	parameters.put ("sebelum_tgl", formater.parse(sebelum_tgl));
	
	
	jasperreport = (JasperReport) JRLoader.loadObject(application.getRealPath ("report" + File.separator + "lap_berkas_musnah.jasper"));
	jasperprint = JasperFillManager.fillReport(jasperreport, parameters, db_con);
	response.setContentType("Application/pdf");
	JasperExportManager.exportReportToPdfStream(jasperprint, response.getOutputStream ());
	
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''").replace("\"", "\\\"") +"'}");
}

%>