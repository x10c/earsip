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
PreparedStatement	db_pstmt	= null;
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

String		id						= "";
String		unit_kerja_peminjam_id	= "";
String	 	nm_ptgs            		= "";
String	 	nm_pim_ptgs        		= "";
String	 	nm_peminjam        		= "";
String	 	nm_pim_peminjam    		= "";
String		tgl_pinjam         		= "";
String		tgl_batas          		= "";
String		tgl_kembali        		= "";
String		keterangan	       		= "";


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
		unit_kerja_peminjam_id		= o.getString ("unit_kerja_peminjam_id");
		nm_ptgs            			= o.getString ("nama_petugas");
		nm_pim_ptgs        			= o.getString ("nama_pimpinan_petugas");
		nm_peminjam        			= o.getString ("nama_peminjam");     		
        nm_pim_peminjam    		    = o.getString ("nama_pimpinan_peminjam");
		tgl_pinjam         		    = o.getString ("tgl_pinjam");
		tgl_batas          		    = o.getString ("tgl_batas_kembali");    		
		tgl_kembali        		    = o.getString ("tgl_kembali");
		keterangan	       		    = o.getString ("keterangan");   		
		
	} else {
		unit_kerja_peminjam_id		= request.getParameter ("unit_kerja_peminjam_id");
		nm_ptgs            			= request.getParameter ("nama_petugas");
		nm_pim_ptgs        			= request.getParameter ("nama_pimpinan_petugas");
		nm_peminjam        			= request.getParameter ("nama_peminjam");     	
        nm_pim_peminjam    		    = request.getParameter ("nama_pimpinan_peminjam");
		tgl_pinjam         		    = request.getParameter ("tgl_pinjam");
		tgl_batas          		    = request.getParameter ("tgl_batas_kembali");    
		tgl_kembali        		    = request.getParameter ("tgl_kembali");
		keterangan	       		    = request.getParameter ("keterangan");   		
	}
	
	if (action.equalsIgnoreCase ("create")) {
		q	=" insert into t_peminjaman ("
			+"   unit_kerja_peminjam_id"
			+" , nama_petugas"
			+" , nama_pimpinan_petugas"
			+" , nama_peminjam"       		
			+" , nama_pimpinan_peminjam"
			+" , tgl_pinjam"   		
			+" , tgl_batas_kembali"        		
			+" , tgl_kembali"        		
			+" , keterangan)"      	
			+" values (?, ?, ?, ?, ?, ?, ?, ?, ?) returning id";
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt	  (1, Integer.parseInt(unit_kerja_peminjam_id));
		db_pstmt.setString (2, nm_ptgs);
		db_pstmt.setString (3, nm_pim_ptgs);
		db_pstmt.setString (4, nm_peminjam);      		
        db_pstmt.setString (5, nm_pim_peminjam);
		db_pstmt.setDate   (6, Date.valueOf(tgl_pinjam));  		
		db_pstmt.setDate   (7, Date.valueOf(tgl_batas));       		
		db_pstmt.setNull   (8, Types.DATE);        		
		db_pstmt.setString (9, keterangan);
		rs = db_pstmt.executeQuery ();
		if (rs.next ())
		{
			id = rs.getString ("id");
		}
		rs.close ();
	} else if (action.equalsIgnoreCase ("update")) {
		q	=" update	t_peminjaman"
			+" set		unit_kerja_peminjam_id = ?"	
			+" , 		nama_petugas = ?"		
			+" , 		nama_pimpinan_petugas = ?"
			+" ,		nama_peminjam = ?"       		
			+" ,		nama_pimpinan_peminjam = ?"
		    +" ,        tgl_pinjam = ?"   		
		    +" ,        tgl_batas_kembali = ?"        		
		    +" ,        tgl_kembali = ?"
		    +" ,        keterangan = ?"  
			+" where	id = ?";
		
		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt(1, Integer.parseInt(unit_kerja_peminjam_id));
		db_pstmt.setString(2, nm_ptgs);
		db_pstmt.setString(3, nm_pim_ptgs);
		db_pstmt.setString(4, nm_peminjam);
		db_pstmt.setString(5, nm_pim_peminjam);
		db_pstmt.setDate(6, Date.valueOf(tgl_pinjam));
		db_pstmt.setDate(7, Date.valueOf(tgl_batas));
		db_pstmt.setNull(8, Types.DATE);
		db_pstmt.setString(9, keterangan);
		db_pstmt.setInt(10, Integer.parseInt(id));
		db_pstmt.executeUpdate ();
		
	}
		
	

	
	if (id!=null || !id.equals(""))
		{
			db_stmt = db_con.createStatement ();
			q	=" update m_berkas  set arsip_status_id = 0"
				+" where id in (select berkas_id as id from peminjaman_rinci where peminjaman_id = " + id + ")" ;
			db_stmt.executeUpdate (q);
			
			q	=" delete from peminjaman_rinci"
				+" where peminjaman_id = " + id;
			db_stmt.executeUpdate (q);
			
			
			if (!action.equalsIgnoreCase ("destroy"))
			{
				JSONArray	berkas = new JSONArray (request.getParameter ("berkas_id"));
				int len	= berkas.length ();
				if (len > 0)
				{
					q = "";
					for (int i = 0; i < len; i++)
					{
						q +=" insert into peminjaman_rinci (peminjaman_id, berkas_id) values("+ id +","+ berkas.getString (i) +");";
						q +=" update m_berkas set arsip_status_id = 1 where id = "+ berkas.getString (i) +" or pid = "+ berkas.getString (i) + ";";
					}
				}
				db_stmt.executeUpdate (q);
			} else 
			{
				q	=" delete from t_peminjaman where id = ?";
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
