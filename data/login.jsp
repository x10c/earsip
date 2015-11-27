<%@ page import="java.io.File" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%
Connection			db_con				= null;
PreparedStatement	db_pstmt			= null;
Statement			db_stmt				= null;
ResultSet			rs					= null;
Cookie				c_sid				= null;
Cookie				c_user_id			= null;
Cookie				c_user_uk_id		= null;
Cookie				c_user_grup_id		= null;
Cookie				c_user_nip			= null;
Cookie				c_user_name			= null;
String				q					= "";
String				sid					= "";
String				user_id				= "";
String				user_uk_id			= "";
String				user_grup_id		= "";
String				user_name			= "";
String				user_nip			= "";
String				user_psw			= "";
String				dir_name			= "";
String				psw_is_expired		= "";
String				c_path				= request.getContextPath ();
int					c_max_age			= 60 * 60 * 24 * 30; // 30 days
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		Properties props = new Properties ();

		ServletContext	context		= session.getServletContext ();
		InputStream		is			= context.getResourceAsStream ("/WEB-INF"+ File.separator +"web.conf");

		props.load (is);

		String		db_url		= props.getProperty ("db");
		String		db_class	= props.getProperty ("db.class");

		Class.forName (db_class);
		db_con			= DriverManager.getConnection (db_url, props);
		session.setAttribute ("db.class", (Object) db_class);
		session.setAttribute ("db.url", (Object) db_url);
		session.setAttribute ("db.con", (Object) db_con);
	}

	user_nip	= request.getParameter ("user_nip");
	user_psw	= request.getParameter ("user_psw");

	q	=" select	PEG.id"
		+" ,		PEG.unit_kerja_id"
		+" ,		PEG.grup_id"
		+" ,		PEG.nama"
		+" ,		PEG.psw_expire > current_date as psw_is_expired"
		+" from		m_pegawai		PEG"
		+" ,		m_unit_kerja	UK"
		+" ,		m_grup			GRUP"
		+" where	PEG.nip				= ?"
		+" and		PEG.psw				= md5(?)"
		+" and		PEG.status			= 1"
		+" and		PEG.unit_kerja_id	= UK.id"
		+" and		PEG.grup_id			= GRUP.id";

	db_pstmt = db_con.prepareStatement (q);
	db_pstmt.setString (1, user_nip);
	db_pstmt.setString (2, user_psw);

	rs = db_pstmt.executeQuery ();

	if (! rs.next ()) {
		out.print (	"{success:false,info:'NIP atau Password anda salah/tidak ada!'}");
		return;
	}

	user_id			= rs.getString ("id");
	user_uk_id		= rs.getString ("unit_kerja_id");
	user_grup_id	= rs.getString ("grup_id");
	user_name		= rs.getString ("nama");
	psw_is_expired	= rs.getString ("psw_is_expired");

	session.setAttribute ("user.id", user_id);
	session.setAttribute ("user.nip", user_nip);
	session.setAttribute ("user.unit_kerja_id", user_uk_id);
	session.setAttribute ("user.grup_id", user_grup_id);
	session.setAttribute ("user.nama", user_name);

	c_sid				= new Cookie ("earsip.sid", session.getId ());
	c_user_id			= new Cookie ("earsip.user.id", user_id);
	c_user_nip			= new Cookie ("earsip.user.nip", user_nip);
	c_user_uk_id		= new Cookie ("earsip.user.unit_kerja_id", user_uk_id);
	c_user_grup_id		= new Cookie ("earsip.user.grup_id", user_grup_id);
	c_user_name			= new Cookie ("earsip.user.nama", user_name);

	c_sid.setMaxAge (c_max_age);
	c_sid.setPath (c_path);
	c_user_id.setMaxAge (c_max_age);
	c_user_id.setPath (c_path);
	c_user_nip.setMaxAge (c_max_age);
	c_user_nip.setPath (c_path);
	c_user_uk_id.setMaxAge (c_max_age);
	c_user_uk_id.setPath (c_path);
	c_user_grup_id.setMaxAge (c_max_age);
	c_user_grup_id.setPath (c_path);
	c_user_name.setMaxAge (c_max_age);
	c_user_name.setPath (c_path);

	response.addCookie (c_sid);
	response.addCookie (c_user_id);
	response.addCookie (c_user_nip);
	response.addCookie (c_user_uk_id);
	response.addCookie (c_user_grup_id);
	response.addCookie (c_user_name);

	// create root folder if not exist
	q =" select id from m_berkas where pid = 0 and pegawai_id = ? ";

	db_pstmt = db_con.prepareStatement (q);
	db_pstmt.setInt (1, Integer.parseInt(user_id));

	rs = db_pstmt.executeQuery ();

	if (! rs.next ()) {
		q	=" insert into m_berkas (pid, pegawai_id, nama)"
			+" values (0, ?, ?)";

		db_pstmt = db_con.prepareStatement (q);
		db_pstmt.setInt (1, Integer.parseInt (user_id));
		db_pstmt.setString (2, user_name);

		db_pstmt.executeUpdate ();
	}

	if (psw_is_expired.equalsIgnoreCase ("f")) {
		out.print ("{success:true"
				+", psw_is_expired:1"
				+", user_name:'"+ user_name +"'"
				+", is_pusatarsip:"+ (user_grup_id.equals ("3") ? 1 : 0) +"}");
	} else {
		out.print ("{success:true"
				+", psw_is_expired:0"
				+", user_name:'"+ user_name +"'"
				+", is_pusatarsip:"+ (user_grup_id.equals ("3") ? 1 : 0) +"}");
	}
	rs.close ();
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''").replace("\"", "\\\"") +"'}");
}
%>
