import java.io.File;
import java.io.FileInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletException;

public class Download extends HttpServlet
{
	public void doGet (HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException
	{
		ServletContext		context	= getServletConfig().getServletContext();
		HttpSession		session	= request.getSession ();
		String			rpath	= context.getRealPath ("/");
		String			repo	= (String) session.getAttribute ("sys.repository_root");
		String			user_id	= (String) session.getAttribute ("user.id");
		String			berkas	= request.getParameter ("berkas");
		String			nama	= request.getParameter ("nama");
		String			fpath	= rpath + repo +"/"+ user_id +"/"+ berkas;
		File			f	= new File (fpath);
		ServletOutputStream	ostream	= response.getOutputStream();
		String			mimetype= context.getMimeType (fpath);
		byte[]			obyte	= new byte[4096];
		int			length	= 0;

		response.setContentType ((mimetype != null) ? mimetype : "application/octet-stream");
		response.setContentLength ((int) f.length());
		response.setHeader("Content-Disposition","attachment;filename="+ nama);

		DataInputStream dis = new DataInputStream (new FileInputStream(f));

		while ((dis != null) && ((length = dis.read (obyte)) != -1)) {
			ostream.write (obyte, 0, length);
		}

		dis.close ();
		ostream.flush ();
		ostream.close ();
	}
}
