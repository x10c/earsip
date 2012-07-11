<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
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

	int			grup_id			= Integer.parseInt ((String) session.getAttribute ("user.grup_id"));
	String		id				= request.getParameter ("id");
	String		pid				= request.getParameter ("pid");
	String		unit_kerja_id	= request.getParameter ("unit_kerja_id");
	String		kode_rak		= request.getParameter ("kode_rak");
	String		kode_box		= request.getParameter ("kode_box");
	String		kode_folder		= request.getParameter ("kode_folder");
	String		type			= request.getParameter ("type");
	JSONArray	arr_data		= new JSONArray ();
	JSONObject	node			= null;

	db_stmt = db_con.createStatement ();

	if (type.equalsIgnoreCase ("root")) {
		q	=" select	id"
			+" ,		nama"
			+" from		m_unit_kerja";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			unit_kerja_id = rs.getString ("id");

			node = new JSONObject ();
			node.put ("id", unit_kerja_id);
			node.put ("pid", 0);
			node.put ("tipe_file", 0);
			node.put ("nama", rs.getString ("nama"));
			node.put ("unit_kerja_id", unit_kerja_id);
			node.put ("kode_rak", 0);
			node.put ("kode_box", 0);
			node.put ("kode_folder", 0);
			node.put ("type", "unit_kerja");

			arr_data.put (node);
		}

		rs.close ();
		out.print ("{success:true,data:"+ arr_data +"}");

	} else if (type.equalsIgnoreCase ("unit_kerja")) {
		q	=" select	distinct"
			+" 			kode_rak"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id;

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			kode_rak = rs.getString ("kode_rak");

			node = new JSONObject ();
			node.put ("id", kode_rak);
			node.put ("pid", unit_kerja_id);
			node.put ("tipe_file", 0);
			node.put ("nama", kode_rak);
			node.put ("unit_kerja_id", unit_kerja_id);
			node.put ("kode_rak", kode_rak);
			node.put ("kode_box", 0);
			node.put ("kode_folder", 0);
			node.put ("type", "rak");

			arr_data.put (node);
		}

		rs.close ();
		out.print ("{success:true,data:"+ arr_data +"}");

	} else if (type.equalsIgnoreCase ("rak")) {
		q	=" select	distinct"
			+" 			kode_box"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			kode_box	= rs.getString ("kode_box");
			node		= new JSONObject ();

			node.put ("id", kode_box);
			node.put ("pid", kode_rak);
			node.put ("tipe_file", 0);
			node.put ("nama", kode_box);
			node.put ("unit_kerja_id", unit_kerja_id);
			node.put ("kode_rak", kode_rak);
			node.put ("kode_box", kode_box);
			node.put ("kode_folder", 0);
			node.put ("type", "box");

			arr_data.put (node);
		}

		rs.close();
		out.print ("{success:true,data:"+ arr_data +"}");

	} else if (type.equalsIgnoreCase ("box")) {
		q	=" select	distinct"
			+" 			kode_folder"
			+" from		m_arsip"
			+" ,		m_berkas"
			+" where	berkas_id		= m_berkas.id"
			+" and		unit_kerja_id	= "+ unit_kerja_id
			+" and		kode_rak		= '"+ kode_rak +"'"
			+" and		kode_box		= '"+ kode_box +"'";

		rs = db_stmt.executeQuery (q);

		while (rs.next ()) {
			node		= new JSONObject ();
			kode_folder	= rs.getString ("kode_folder");

			node.put ("id", kode_folder);
			node.put ("pid", kode_box);
			node.put ("tipe_file", 0);
			node.put ("nama", kode_folder);
			node.put ("unit_kerja_id", unit_kerja_id);
			node.put ("kode_rak", kode_rak);
			node.put ("kode_box", kode_box);
			node.put ("kode_folder", kode_folder);
			node.put ("type", "folder");

			arr_data.put (node);
		}

		rs.close();
		out.print ("{success:true,data:"+ arr_data +"}");

	} else if (type.equalsIgnoreCase ("folder")) {
		q	=" select	m_berkas.id"
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
			+" ,		jra_aktif"
			+" ,		jra_inaktif"
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
			+" and		arsip_status_id in (0,1)";

		if (unit_kerja_id != null && !unit_kerja_id.equalsIgnoreCase ("0")) {
			q +=" and unit_kerja_id = "+ unit_kerja_id;
		}
		if (kode_rak != null && !kode_rak.equalsIgnoreCase ("0")) {
			q +=" and kode_rak = '"+ kode_rak +"'";
		}
		if (kode_box != null && !kode_box.equalsIgnoreCase ("0")) {
			q +=" and kode_box = '"+ kode_box +"'";
		}
		if (kode_folder != null && !kode_folder.equalsIgnoreCase ("0")) {
			q +=" and kode_folder = '"+ kode_folder +"'";
		}

		q += " order by tipe_file, nama";

		rs = db_stmt.executeQuery (q);

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
					+ "\n, jra_aktif     : "+ rs.getString ("jra_aktif")
					+ "\n, jra_inaktif   : "+ rs.getString ("jra_inaktif")
					+ "\n, status        : "+ rs.getString ("status")
					+ "\n, status_hapus  : "+ rs.getString ("status_hapus")
					+ "\n, akses_berbagi_id	: "+ rs.getString ("akses_berbagi_id")
					+ "\n, kode_rak			: '"+ rs.getString ("kode_rak") +"'"
					+ "\n, kode_box			: '"+ rs.getString ("kode_box") +"'"
					+ "\n, kode_folder		: '"+ rs.getString ("kode_folder") +"'"
					+ "\n}";
		}
		out.print ("{success:true,data:["+ data +"]}");
		rs.close ();

	} else if (type.equalsIgnoreCase ("arsip_folder")) {
		q	=" select	m_berkas.id"
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
			+" ,		jra_aktif"
			+" ,		jra_inaktif"
			+" ,		status"
			+" ,		status_hapus"
			+" ,		akses_berbagi_id"
			+" ,		n_output_images"
			+" from		m_berkas"
			+" where	pid				= "+ id
			+" and		status_hapus	= 1";

		q += " order by tipe_file, nama";

		rs = db_stmt.executeQuery (q);

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
					+ "\n, jra_aktif     : "+ rs.getString ("jra_aktif")
					+ "\n, jra_inaktif   : "+ rs.getString ("jra_inaktif")
					+ "\n, status        : "+ rs.getString ("status")
					+ "\n, status_hapus  : "+ rs.getString ("status_hapus")
					+ "\n, akses_berbagi_id	: "+ rs.getString ("akses_berbagi_id")
					+ "\n, n_output_images	: "+ rs.getString ("n_output_images")
					+ "\n, kode_rak			: '"+ kode_rak +"'"
					+ "\n, kode_box			: '"+ kode_box +"'"
					+ "\n, kode_folder		: '"+ kode_folder +"'"
					+ "\n}";
		}
		out.print ("{success:true,data:["+ data +"]}");
		rs.close ();
	}
}
catch (Exception e) {
	out.print ("{success:false,info:'"+ e.toString().replace("'","''").replace ("\"", "\\\"") +"'}");
}
%>
