<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%
Connection	db_con		= null;
Statement	db_stmt		= null;
ResultSet	rs			= null;
String		q			= "";
String		data		= "";
int			i			= 0;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	String	user_id				= (String) session.getAttribute ("user.id");
	String	grup_id				= (String) session.getAttribute ("user.grup_id");
	String	text				= request.getParameter ("text");
	String	metoda_id			= request.getParameter ("metoda_id");
	String	nm_petugas			= request.getParameter ("nama_petugas");
	String	tgl_setelah			= request.getParameter ("tgl_setelah");
	String	tgl_sebelum			= request.getParameter ("tgl_sebelum");
	String	pj_unit_kerja		= request.getParameter ("pj_unit_kerja");
	String	pj_berkas_arsip		= request.getParameter ("pj_berkas_arsip");

	q	=" select		distinct(A.id)"
		+" ,			metoda_id"
		+" ,			nama_petugas"
		+" ,			tgl"
		+" ,			A.pj_unit_kerja"
		+" ,			A.pj_berkas_arsip"		
		+" from			t_pemusnahan A"
		+" left join	t_pemusnahan_rinci B "
		+" on			A.id = B.pemusnahan_id" 
		+" left join	m_berkas C"
		+" on 			C.id = B.berkas_id"
		+" where";
		if (Integer.parseInt (grup_id)== 3){ 
			q +=" C.status = 0";
		}else
		{
			q +=" C.status = 1"
			  +" and C.pegawai_id = " + user_id;
		}
		

	if (text != null && ! text.equals ("")) {
		q	+=" and (nama_petugas ilike '%"+ text +"%'"
			+ " or pj_unit_kerja ilike '%"+ text +"%'"
			+ " or pj_berkas_arsip ilike '%"+ text +"%'"
			+ " )";
	}
	if (metoda_id != null && ! metoda_id.equals ("")) {
		q += " and metoda_id = "+ metoda_id;
	}
	if (nm_petugas != null && ! nm_petugas.equals ("")) {
		q += " and nama_petugas ilike '%"+ nm_petugas +"%'";
	}
		
	if (tgl_setelah != null && ! tgl_setelah.equals ("")) {
		q += " and tgl  >= '"+ tgl_setelah +"'";
	}
	if (tgl_sebelum != null && ! tgl_sebelum.equals ("")) {
		q += " and tgl  <= '"+ tgl_sebelum +"'";
	}
	
	if (pj_unit_kerja != null && ! pj_unit_kerja.equals ("")) {
		q += " and pj_unit_kerja ilike '%"+ pj_unit_kerja +"%'";
	}
	
	if (pj_berkas_arsip != null && ! pj_berkas_arsip.equals ("")) {
		q += " and pj_berkas_arsip ilike '%"+ pj_berkas_arsip +"%'";
	}


	q += " order by tgl";
	
	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id						: "+ rs.getString ("id")
				+ "\n, metoda_id				: "+ rs.getString ("metoda_id")
				+ "\n, nama_petugas				:'"+ rs.getString ("nama_petugas") +"'"
				+ "\n, tgl						:'"+ rs.getString ("tgl") +"'"
				+ "\n, pj_unit_kerja			:'"+ rs.getString ("pj_unit_kerja") +"'"
				+ "\n, pj_berkas_arsip			:'"+ rs.getString ("pj_berkas_arsip") +"'"
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
