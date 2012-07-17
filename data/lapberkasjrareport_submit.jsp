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
Connection		db_con			= null;
Map				parameters 		= null;
JasperReport	jasperreport 	= null;
JasperPrint		jasperprint		= null;
Locale			locale			= null;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}
	
	String user_id	= (String) session.getAttribute ("user.id");
	
	locale = new Locale ("in", "ID");
	parameters = new HashMap ();
	
	parameters.put ("pegawai_id", Integer.parseInt(user_id));
	parameters.put ("REPORT_LOCALE", locale);
	if (user_id.equals ("3")) {
		jasperreport = (JasperReport) JRLoader.loadObject(application.getRealPath ("report" + File.separator + "lapjra_inaktif.jasper"));
	} else {
		jasperreport = (JasperReport) JRLoader.loadObject(application.getRealPath ("report" + File.separator + "lapjra_aktif.jasper"));
	}
	jasperprint = JasperFillManager.fillReport(jasperreport, parameters, db_con);
	response.setHeader("Content-Disposition","attachment;filename=Laporan Daftar Berkas JRA.pdf");
	JasperExportManager.exportReportToPdfStream(jasperprint, response.getOutputStream ());
	
} catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''").replace("\"", "\\\"") +"'}");
}

%>
