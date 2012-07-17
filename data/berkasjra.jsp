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

	String user_id = (String) session.getAttribute ("user.id");
	String grup_id = (String) session.getAttribute ("user.grup_id");
	String jra_query_text = "";
	String status	= "";
	
	if (grup_id.equals ("3")) {
		jra_query_text = "jra_inaktif";
		status = "0";
	}
	else {
		jra_query_text = "jra_aktif";
		status = "1";
	}
	
	q	=" select	id"
		+" ,		pid"
		+" ,		tipe_file"
		+" ,		mime"
		+" ,		sha"
		+" ,		pegawai_id"
		+" ,		unit_kerja_id"
		+" ,		berkas_klas_id"
		+" ,		berkas_tipe_id"
		+" ,		nama"
		+" ,		tgl_unggah"
		+" ,		coalesce (tgl_dibuat, tgl_unggah) as tgl_dibuat"
		+" ,		nomor"
		+" ,		pembuat"
		+" ,		judul"
		+" ,		masalah"
		+" ,		jra_aktif"
		+" ,		jra_inaktif"
		+" ,		status"
		+" ,		status_hapus"
		+" ,		akses_berbagi_id"
		+" ,		age (tgl_dibuat) as usia"
		+" ,		get_berkas_path (pid) as lokasi"
		+" ,		dateadd ('year'," + jra_query_text + ",tgl_dibuat) as tgl_jra"
		+" ,		n_output_images"
		+" from		m_berkas"
		+" where	status			= "+ status
		+" and		status_hapus	= 1"
		+" and		arsip_status_id in (0,1)"
		+" and		datediff('month', current_date, dateadd ('year'," + jra_query_text + ",tgl_dibuat)) <= 3"; // 3 months difference between berkas current age and berkas tgl_jra
		if (!grup_id.equals ("3")) 
			q +=" and pegawai_id = " + user_id;
		q +=" order by tipe_file, nama";
	
	
	db_stmt = db_con.createStatement ();
	rs		= db_stmt.executeQuery (q);

	while (rs.next ()) {
		if (i > 0) {
			data += ",";
		} else {
			i++;
		}
		data	+="\n{ id            : "+ rs.getString ("id")
				+ "\n, pid           : "+ rs.getString ("pid")
				+ "\n, tipe_file     : "+ rs.getString ("tipe_file")
				+ "\n, mime          :'"+ rs.getString ("mime") +"'"
				+ "\n, sha           :'"+ rs.getString ("sha") +"'"
				+ "\n, pegawai_id    : "+ rs.getString ("pegawai_id")
				+ "\n, unit_kerja_id : "+ rs.getString ("unit_kerja_id")
				+ "\n, berkas_klas_id: "+ rs.getString ("berkas_klas_id")
				+ "\n, berkas_tipe_id: "+ rs.getString ("berkas_tipe_id")
				+ "\n, nama          :'"+ rs.getString ("nama") +"'"
				+ "\n, tgl_unggah    :'"+ rs.getString ("tgl_unggah") +"'"
				+ "\n, tgl_dibuat    :'"+ rs.getString ("tgl_dibuat") +"'"
				+ "\n, nomor         :'"+ rs.getString ("nomor") +"'"
				+ "\n, pembuat       :'"+ rs.getString ("pembuat") +"'"
				+ "\n, judul         :'"+ rs.getString ("judul") +"'"
				+ "\n, masalah       :'"+ rs.getString ("masalah") +"'"
				+ "\n, jra_aktif     : "+ rs.getString ("jra_aktif")
				+ "\n, jra_inaktif   : "+ rs.getString ("jra_inaktif")
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n, status_hapus  : "+ rs.getString ("status_hapus")
				+" \n, akses_berbagi_id : "+ rs.getString ("akses_berbagi_id")
				+" \n, usia             : '"+ rs.getString ("usia") +"'"
				+" \n, lokasi           : '"+ rs.getString ("lokasi") +"'"
				+" \n, tgl_jra          : '"+ rs.getString ("tgl_jra") +"'"
				+" \n, n_output_images  :  "+ rs.getString ("n_output_images")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
