package org.kilabit;
import java.io.BufferedReader;
import java.lang.StringBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Cookie;

public class ServletUtilities {
	public static int getIntParameter (HttpServletRequest request
					, String paramName
					, int defaultValue) {
		String paramString = request.getParameter (paramName);
		int paramValue;
		try {
			paramValue = Integer.parseInt (paramString);
		} catch(NumberFormatException nfe) { // Handles null and bad format
			paramValue = defaultValue;
		}
		return (paramValue);
	}

	public static String getCookieValue (Cookie[] cookies
						, String cookieName
						, String defaultValue) {
		if (null == cookies) {
			return defaultValue;
		}
		for (int i=0; i<cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookieName.equals(cookie.getName())) {
				return(cookie.getValue());
			}
		}
		return(defaultValue);
	}

	public static String getRequestBody (HttpServletRequest request) throws Exception
	{
		StringBuilder	req_body	= new StringBuilder();
		BufferedReader	req_reader	= request.getReader ();
		String		ret		= "";

		String req_line	= req_reader.readLine ();
		while (req_line != null) {
			req_body.append (req_line + "\n");
			req_line = req_reader.readLine();
		}
		req_reader.reset ();

		ret = req_body.toString ().trim ();

		return ret.length () <= 0 ? "{}" : ret;
	}

	public static final int SECONDS_PER_MONTH = 60*60*24*30;
}
