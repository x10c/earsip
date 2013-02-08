<%@ page import="java.io.File" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.kilabit.ServletUtilities" %>
<%
	Connection			db_con	= null;
	PreparedStatement	db_ps	= null;
	Statement			db_stmt	= null;
	ResultSet			rs		= null;
	String				q		= "";
	JSONArray			_a		= null;
	JSONObject			_o		= null;
	JSONObject			_r		= new JSONObject ();
	int					_i		= 0;

	db_con = (Connection) session.getAttribute ("db.con");

	if (db_con == null || (db_con != null && db_con.isClosed ())) {
		response.sendRedirect (request.getContextPath());
		return;
	}

	Cookie[]	_cookies	= request.getCookies ();
	String		_user_id	= ServletUtilities.getCookieValue (_cookies, "earsip.user.id", null);
	String		_user_name	= ServletUtilities.getCookieValue (_cookies, "earsip.user.nama", null);
	String		_user_gid	= ServletUtilities.getCookieValue (_cookies, "earsip.user.grup_id", null);
	String		_user_nip	= ServletUtilities.getCookieValue (_cookies, "earsip.user.nip", null);
	String		_user_uk	= ServletUtilities.getCookieValue (_cookies, "earsip.user.unit_kerja_id", null);

	if (null == _user_id || null == _user_name || null == _user_gid
	||  null == _user_nip || null == _user_uk) {
		out.print ("{success:false,info:'Nama pengguna/group tidak diketahui.'}");
		response.sendRedirect (request.getContextPath());
		return;
	}
%>
