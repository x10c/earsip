import java.io.File;
import java.io.FileInputStream;
import java.io.DataInputStream;
import java.io.IOException;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletException;

import org.kilabit.ServletUtilities;

public class Download extends HttpServlet
{
	public void doGet (HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException
	{
		Cookie[]	_cookies	= request.getCookies ();
		String		_user_id	= ServletUtilities.getCookieValue (_cookies, "earsip.user.id", null);
		String		_user_name	= ServletUtilities.getCookieValue (_cookies, "earsip.user.nama", null);
		String		_user_gid	= ServletUtilities.getCookieValue (_cookies, "earsip.user.grup_id", null);
		String		_user_nip	= ServletUtilities.getCookieValue (_cookies, "earsip.user.nip", null);
		String		_user_uk	= ServletUtilities.getCookieValue (_cookies, "earsip.user.unit_kerja_id", null);

		ServletContext		context	= getServletConfig().getServletContext();
		HttpSession		session	= request.getSession ();
		String			rpath	= context.getRealPath ("/");
		String			repo	= (String) session.getAttribute ("sys.repository_root");
		String			berkas	= request.getParameter ("berkas");
		String			nama	= request.getParameter ("nama");
		String			fpath	= rpath + repo +"/"+ _user_id +"/"+ berkas;
		File			f	= new File (fpath);
		ServletOutputStream	ostream	= response.getOutputStream();
		String			mimetype= context.getMimeType (fpath);
		byte[]			obyte	= new byte[4096];
		int			length	= 0;

		Connection		db_con	= null;
		Statement		db_stmt	= null;
		ResultSet		rs	= null;
		String			q	= "";

		if (mimetype == null) {
			try {
				db_con = (Connection) session.getAttribute ("db.con");

				if (db_con == null || (db_con != null && db_con.isClosed ())) {
					response.sendRedirect (request.getContextPath());
					return;
				}

				q	=" select mime from m_berkas where sha = '"+ berkas +"'";
				db_stmt	= db_con.createStatement ();
				rs	= db_stmt.executeQuery (q);

				if (! rs.next ()) {
					mimetype = "application/octet-stream";
				} else {
					mimetype = rs.getString ("mime");
				}
				rs.close ();
				db_stmt.close ();
			} catch (Exception e) {
				mimetype = "application/octet-stream";
			}
		}

		response.setContentType (mimetype);
		response.setContentLength ((int) f.length());
		response.setHeader("Content-Disposition","attachment;filename=\""+ nama +"\"");

		DataInputStream dis = new DataInputStream (new FileInputStream(f));

		while ((dis != null) && ((length = dis.read (obyte)) != -1)) {
			ostream.write (obyte, 0, length);
		}

		dis.close ();
		ostream.flush ();
		ostream.close ();
	}
}
