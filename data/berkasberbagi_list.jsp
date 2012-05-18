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

	String	user_id		= (String) session.getAttribute ("user.id");
	String	id			= request.getParameter ("id");
	String	pid			= request.getParameter ("pid");
	String	peg_id		= request.getParameter ("peg_id");

	if (id.equalsIgnoreCase ("0")) {
		out.print ("{success:true,data:["+ data +"]}");
		return;
	}

	q	=" select	distinct"
		+" 			BERKAS.id"
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
		+" from		m_berkas			BERKAS"
		+" ,		m_berkas_berbagi	BAGI";

	if (pid.equalsIgnoreCase ("0")) {
		q	+=" where pegawai_id = "+ peg_id
			+ " and ((akses_berbagi_id = 3 or akses_berbagi_id = 4)"
			+ " or  ((akses_berbagi_id = 1 or akses_berbagi_id = 2)"
			+ "			and	berkas_id		= BERKAS.id"
			+ "			and	bagi_ke_peg_id	= "+ user_id
			+ " ))";
	} else if (id.equalsIgnoreCase ("0")) {
		q	+=" where id = "+ pid;
	} else {
		q	+=" where pid = "+ id;
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
				+" \n, akses_berbagi_id : "+ rs.getString ("akses_berbagi_id")
				+ "\n}";
	}
	out.print ("{success:true,data:["+ data +"]}");
	rs.close ();
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
