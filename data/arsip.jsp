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

	String unit_kerja_id	= request.getParameter ("unit_kerja_id");
	String kode_rak			= request.getParameter ("kode_rak");
	String kode_box			= request.getParameter ("kode_box");
	String kode_folder		= request.getParameter ("kode_folder");

	q	=" select	id"
		+" ,		pid"
		+" ,		tipe_file"
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
		+" ,		jra"
		+" ,		status"
		+" ,		status_hapus"
		+" ,		akses_berbagi_id"
		+" ,		kode_rak"
		+" ,		kode_box"
		+" ,		kode_folder"
		+" from		m_berkas"
		+" ,		m_arsip"
		+" where	m_berkas.id		= berkas_id"
		+" and		status			= 0"
		+" and		status_hapus	= 1"

	if (unit_kerja_id != null && unit_kerja_id.equalsIgnoreCase ("0") {
		q += "and unit_kerja_id = "+ unit_kerja_id;
	}
	if (kode_rak != null && kode_rak.equalsIgnoreCase ("0") {
		q += "and kode_rak = '"+ kode_rak +"'";
	}
	if (kode_box != null && kode_box.equalsIgnoreCase ("0") {
		q += "and kode_box = '"+ kode_box +"'";
	}
	if (kode_folder != null && kode_folder.equalsIgnoreCase ("0") {
		q += "and kode_folder = '"+ kode_folder +"'";
	}

	q += " order by tipe_file, nama";

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
				+ "\n, jra           : "+ rs.getString ("jra")
				+ "\n, status        : "+ rs.getString ("status")
				+ "\n, status_hapus  : "+ rs.getString ("status_hapus")
				+ "\n, akses_berbagi_id	: "+ rs.getString ("akses_berbagi_id")
				+ "\n, kode_rak			: "+ rs.getString ("kode_rak")
				+ "\n, kode_box			: "+ rs.getString ("kode_box")
				+ "\n, kode_folder		: "+ rs.getString ("kode_folder")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
