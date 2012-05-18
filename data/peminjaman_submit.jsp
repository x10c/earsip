<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.lang.StringBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONObject" %>
<%
Connection			db_con	= null;
PreparedStatement	db_stmt	= null;
String				db_url	= "";
String				q		= "";
String				data	= "";

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
			+" values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt	  (1, Integer.parseInt(unit_kerja_peminjam_id));
		db_stmt.setString (2, nm_ptgs);
		db_stmt.setString (3, nm_pim_ptgs);
		db_stmt.setString (4, nm_peminjam);      		
        db_stmt.setString (5, nm_pim_peminjam);
		db_stmt.setDate   (6, Date.valueOf(tgl_pinjam));  		
		db_stmt.setDate   (7, Date.valueOf(tgl_batas));       		
		db_stmt.setDate   (8, Date.valueOf(tgl_kembali));        		
		db_stmt.setString (9, keterangan);
		
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
		
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt(1, Integer.parseInt(unit_kerja_peminjam_id));
		db_stmt.setString(2, nm_ptgs);
		db_stmt.setString(3, nm_pim_ptgs);
		db_stmt.setString(4, nm_peminjam);
		db_stmt.setString(5, nm_pim_peminjam);
		db_stmt.setDate(6, Date.valueOf(tgl_pinjam));
		db_stmt.setDate(7, Date.valueOf(tgl_batas));
		db_stmt.setDate(8, Date.valueOf(tgl_kembali));
		db_stmt.setString(9, keterangan);
		db_stmt.setInt(10, Integer.parseInt(id));
		
	}else if (action.equalsIgnoreCase ("destroy")) {
		q	=" delete from t_peminjaman where id = ?";
		db_stmt = db_con.prepareStatement (q);
		db_stmt.setInt (1, Integer.parseInt (id));
	}

	db_stmt.executeUpdate ();
	out.print ("{success:true}");
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''") +"'}");
}
%>
