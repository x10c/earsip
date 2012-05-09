<%@ page import="java.io.File" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
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
String				db_url				= "";
String				q					= "";
String				sid					= "";
String				repo_root			= "";
String				user_id				= "";
String				user_uk_id			= "";
String				user_grup_id		= "";
String				user_name			= "";
String				user_nip			= "";
String				user_psw			= "";
String				user_dir			= "";
String				dir_name			= "";
String				c_path				= request.getContextPath ();
int					c_max_age			= 60 * 60 * 24 * 30;
try {
	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || db_con.isClosed ()) {
		db_url = (String) session.getAttribute ("db.url");
		if (db_url == null) {
			response.sendRedirect(request.getContextPath());
			return;
		}

		Class.forName ((String) session.getAttribute ("db.class"));

		db_con = DriverManager.getConnection(db_url);

		session.setAttribute("db.con", (Object) db_con);
	}

	user_nip	= request.getParameter ("user_nip");
	user_psw	= request.getParameter ("user_psw");

	q	=" select	PEG.id"
		+" ,		PEG.unit_kerja_id"
		+" ,		PEG.grup_id"
		+" ,		PEG.nama"
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

	/* create user repository if it doesn't exist yet */
	repo_root = (String) session.getAttribute ("sys.repository_root");

	if (repo_root != null) {
		dir_name	= user_name +" ("+ user_nip +")";
		user_dir	= config.getServletContext().getRealPath("/") + repo_root
					+"/"+ dir_name;
		File d		= new File (user_dir);

		d.mkdir ();

		q	=" select	id"
			+" from		m_berkas"
			+" where	nama		='"+ dir_name +"'"
			+" and		pid			= 0"
			+" and		tipe_file	= 0";

		db_stmt = db_con.createStatement ();

		rs = db_stmt.executeQuery (q);

		if (! rs.next ()) {
			q	=" insert into m_berkas (pid, pegawai_id, nama)"
				+" values (0, "+ user_id +",'"+ dir_name +"')";

			db_stmt.executeUpdate (q);
		}
	}

	out.print ("{success:true, user_dir:'"+ user_dir +"', user_name:'"+ user_name +"'}");
	rs.close ();
}
catch (Exception e) {
	out.print("{success:false,info:'"+ e.toString().replace("'","''").replace("\"", "\\\"") +"'}");
}
%>
