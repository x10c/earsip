<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Types" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%
Connection			db_con	= null;
PreparedStatement	db_pstmt= null;
Statement			db_stmt	= null;
String				db_url	= "";
String				q		= "";
String				data	= "";
ResultSet			rs		= null;

BufferedReader	reader		= null;
StringBuilder	sb			= new StringBuilder();
JSONObject		o			= null;
String			line		= "";
String			action		= "";

String		id				= "";
String		metoda_id		= "";
String	 	nm_ptgs         = "";
String		tgl		        = "";
String		pj_unit_kerja	= "";
String		pj_berkas_arsip	= "";


try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}
	
	action	= request.getParameter ("action");
	id 		= request.getParameter ("id");
	
	
	if (id == null) {
		reader	= request.getReader ();
		line	= reader.readLine ();
		while (line != null) {
			sb.append (line + "\n");
			line = reader.readLine();
		}
		reader.close();
		
		data						= sb.toString();
		o							= (JSONObject) new JSONObject (data);
		id							= o.getString ("id");
		metoda_id					= o.getString ("metoda_id");
		nm_ptgs            			= o.getString ("nama_petugas");
		tgl		         		    = o.getString ("tgl");
		pj_unit_kerja          		= o.getString ("pj_unit_kerja");    		
		pj_berkas_arsip        		= o.getString ("pj_berkas_arsip"); 		
		
	} else {
		metoda_id					= request.getParameter ("metoda_id");
		nm_ptgs            			= request.getParameter ("nama_petugas");
		tgl		        			= request.getParameter ("tgl");
		pj_unit_kerja      			= request.getParameter ("pj_unit_kerja");  
        pj_berkas_arsip    		    = request.getParameter ("pj_berkas_arsip");
	}
	
	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into t_pemusnahan ("
			+"   metoda_id"
			+" , nama_petugas"
			+" , tgl"
			+" , pj_unit_kerja"
			+" , pj_berkas_arsip)" 
			+" values (?, ?, ?, ?, ?) returning id";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt	  	(1, Integer.parseInt(metoda_id));
		db_pstmt.setString 	(2, nm_ptgs);
		db_pstmt.setDate 	(3, Date.valueOf (tgl));       
		db_pstmt.setString 	(4, pj_unit_kerja);
        db_pstmt.setString 	(5, pj_berkas_arsip);
		
		rs = db_pstmt.executeQuery ();
		if (rs.next ())
		{
			id = rs.getString ("id");
		}
		rs.close ();
	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	t_pemusnahan"
			+" set		metoda_id = ?"
			+" , 		nama_petugas = ?"
			+" , 		tgl = ?"
			+" ,		pj_unit_kerja = ?"
			+" ,		pj_berkas_arsip = ?" 
			+" where	id = ?";
		
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt	  	(1, Integer.parseInt(metoda_id));
		db_pstmt.setString 	(2, nm_ptgs);
		db_pstmt.setDate 	(3, Date.valueOf (tgl));       
		db_pstmt.setString 	(4, pj_unit_kerja);
        db_pstmt.setString 	(5, pj_berkas_arsip);
		db_pstmt.setInt 	(6, Integer.parseInt (id));
		db_pstmt.executeUpdate ();
	}
		
	if (id!=null || !id.equals(""))
		{
			db_stmt = db_con.createStatement ();
			q	=" update m_berkas  set arsip_status_id = 0"
				+" where id in (select berkas_id as id from t_pemusnahan_rinci where pemusnahan_id = " + id + ")" ;
			db_stmt.executeUpdate (q);
			
			q	=" delete from t_pemusnahan_rinci"
				+" where pemusnahan_id = " + id;
			db_stmt.executeUpdate (q);
			
			q	=" delete from t_tim_pemusnahan"
				+" where pemusnahan_id = " + id;
			db_stmt.executeUpdate (q);
			
			
			if (!action.equalsIgnoreCase ("destroy"))
			{
				JSONArray	berkas = new JSONArray (request.getParameter ("berkas"));
				
				int len	= berkas.length ();
				if (len > 0)
				{
					q = "";
					for (int i = 0; i < len; i++)
					{
						JSONObject	obj			= berkas.getJSONObject (i);
						String		berkas_id	= obj.getString ("berkas_id");

						q +=" insert into t_pemusnahan_rinci (pemusnahan_id, berkas_id, keterangan, jml_lembar, jml_set, jml_berkas)"
						   +" values("+ id 
						   +" ,"+ berkas_id
						   +" ,'" + obj.getString ("keterangan") + "'"
						   +" ," + obj.getString ("jml_lembar")
						   +" ," + obj.getString ("jml_set")
						   +" ," + obj.getString ("jml_berkas") + ");";
						q +=" update m_berkas set arsip_status_id = 2 where id = "+ berkas_id +" or pid = "+ berkas_id;
					}
				}
				db_stmt.executeUpdate (q);
				
				JSONArray tims     = new JSONArray (request.getParameter ("tims"));
				len	= tims.length ();
				if (len > 0)
				{
					q 	= " insert into t_tim_pemusnahan (pemusnahan_id, nomor, nama, jabatan) values";
					for (int i = 0; i < len; i++)
					{
						if (i > 0){
							q += ",";
						}
						JSONObject obj = tims.getJSONObject (i);
						q +=" ("+ id 
						   +" ," + (i+1) 
						   +" ,'" + obj.getString ("nama") + "'"
						   +" ,'" + obj.getString ("jabatan") +"')";
					}
				}
				db_stmt.executeUpdate (q);
				
			} else 
			{
				q	=" delete from t_pemusnahan where id = ?";
				db_pstmt = db_con.prepareStatement (q);
				db_pstmt.setInt (1, Integer.parseInt (id));
				db_pstmt.executeUpdate ();
			}
			
		}
	out.print ("{success:true,info:'Data Penyimpanan berhasil disimpan'}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
