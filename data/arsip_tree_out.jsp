<%--
	Copyright 2013 - kilabit.org

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="init.jsp"%>
<%!
public void get_list_arsip_folder (Connection db_con
										, JspWriter out
										, String pid
										, int unit_kerja_id
										, String kode_rak
										, String kode_box
										, String kode_folder
										, int depth)
throws java.io.IOException, java.sql.SQLException
{
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		id			= "";
	int			arsip_id	= 0;
	int			index		= 0;

	db_stmt = db_con.createStatement ();

	q	=" select	m_berkas.id"
		+" ,		nama"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		tipe_file		= 0"
		+" and		unit_kerja_id	= "+ unit_kerja_id
		+" and		kode_rak		='"+ kode_rak +"'"
		+" and		kode_box		='"+ kode_box +"'"
		+" and		kode_folder		='"+ kode_folder +"'"
		+" and		arsip_status_id	in (0,1)";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		arsip_id	= rs.getInt ("id");

		out.print ("{"
				+"	\"id\": "+ arsip_id
				+",	\"pid\": "+ pid
				+",	\"text\":\""+ rs.getString ("nama") +"\""
				+",	\"unit_kerja_id\": "+ unit_kerja_id
				+",	\"kode_rak\":\""+ kode_rak +"\""
				+",	\"kode_box\":\""+ kode_box +"\""
				+",	\"kode_folder\":\""+ kode_folder +"\""
				+",	\"type\":\"arsip_folder\""
				+",	\"depth\": "+ depth
				+",	\"index\": "+ index++
				+",	\"leaf\": true"
				+"}");
	}
	rs.close ();
	db_stmt.close ();
}

public void get_list_folder (Connection db_con
							, JspWriter out
							, String pid
							, int unit_kerja_id
							, String kode_rak
							, String kode_box
							, int depth)
throws java.io.IOException, java.sql.SQLException
{
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		id			= "";
	String		kode_folder	= "";
	int			index		= 0;

	db_stmt = db_con.createStatement ();

	q	=" select	distinct"
		+" 			kode_folder"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		unit_kerja_id	= "+ unit_kerja_id
		+" and		kode_rak		='"+ kode_rak +"'"
		+" and		kode_box		='"+ kode_box +"'";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		kode_folder	= rs.getString ("kode_folder");
		id			= unit_kerja_id +"."+ kode_rak +"."+ kode_box +"."+ kode_folder;

		out.print ("{"
				+"	\"id\":"+ id
				+",	\"pid\":"+ pid
				+",	\"text\":\"FOLDER - "+ kode_folder +"\""
				+",	\"unit_kerja_id\":"+ unit_kerja_id
				+",	\"kode_rak\":\""+ kode_rak +"\""
				+",	\"kode_box\":\""+ kode_box +"\""
				+",	\"kode_folder\":\""+ kode_folder +"\""
				+",	\"type\":\"folder\""
				+",	\"depth\":"+ depth
				+",	\"index\":"+ index++
				+",	\"children\":[");

		get_list_arsip_folder (db_con, out, id, unit_kerja_id, kode_rak, kode_box, kode_folder, depth + 1);

		out.print ("]}");
	}
	rs.close ();
	db_stmt.close ();
}

public void get_list_box (Connection db_con
						, JspWriter out
						, String pid
						, int unit_kerja_id
						, String kode_rak
						, int depth)
throws java.io.IOException, java.sql.SQLException
{
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		id			= "";
	String		kode_box	= "";
	int			index		= 0;

	db_stmt = db_con.createStatement ();

	q	=" select	distinct"
		+" 			kode_box"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		unit_kerja_id	= "+ unit_kerja_id
		+" and		kode_rak		='"+ kode_rak +"'";

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		kode_box	= rs.getString ("kode_box");
		id			= unit_kerja_id +"."+ kode_rak +"."+ kode_box +".0";

		out.print ("{"
				+"	\"id\":"+ id
				+",	\"pid\":"+ pid
				+",	\"text\":\"BOX - "+ kode_box +"\""
				+",	\"unit_kerja_id\":"+ unit_kerja_id
				+",	\"kode_rak\":\""+ kode_rak +"\""
				+",	\"kode_box\":\""+ kode_box +"\""
				+",	\"kode_folder\":\"0\""
				+",	\"type\":\"box\""
				+",	\"depth\":"+ depth
				+",	\"index\":"+ index++
				+",	\"children\":[");

		get_list_folder (db_con, out, id, unit_kerja_id, kode_rak, kode_box, depth + 1);

		out.print ("]}");
	}
	rs.close ();
	db_stmt.close ();
}

public void get_list_rak (Connection db_con
						, JspWriter out
						, String pid
						, int unit_kerja_id
						, int depth)
throws java.io.IOException, java.sql.SQLException
{
	Statement	db_stmt		= null;
	ResultSet	rs			= null;
	String		q			= "";
	String		kode_rak	= "";
	String		id			= "";
	int			index		= 0;

	db_stmt = db_con.createStatement ();

	q	=" select	distinct"
		+" 			kode_rak"
		+" from		m_arsip"
		+" ,		m_berkas"
		+" where	berkas_id		= m_berkas.id"
		+" and		unit_kerja_id	= "+ unit_kerja_id;

	rs = db_stmt.executeQuery (q);

	while (rs.next ()) {
		kode_rak	= rs.getString ("kode_rak");
		id			= unit_kerja_id +"."+ kode_rak +".0.0";

		out.print ("{"
				+"	\"id\":"+ id
				+",	\"pid\":"+ pid
				+",	\"text\":\"RAK - "+ kode_rak +"\""
				+",	\"unit_kerja_id\":"+ unit_kerja_id
				+",	\"kode_rak\":\""+ kode_rak +"\""
				+",	\"kode_box\":\"0\""
				+",	\"kode_folder\":\"0\""
				+",	\"type\":\"rak\""
				+",	\"depth\":"+ depth
				+",	\"index\":"+ index++
				+",	\"children\":[");

		get_list_box (db_con, out, id, unit_kerja_id, kode_rak, depth + 1);

		out.print ("]}");
	}
	rs.close ();
	db_stmt.close ();
}
%>

<%-- Main --%>
<%
try {
	int			grup_id			= Integer.parseInt (_user_gid);
	String		id				= "";
	String		nama			= "";
	int			uk_id			= 0;
	int			depth			= 1;
	int			index			= 0;

	db_stmt	= db_con.createStatement();

	q	=" select	id"
		+" ,		nama"
		+" from		m_unit_kerja";

	/* if user is  not in grup arsip, they can see all files from all unit-kerja */
	if (grup_id != 3) {
		q +=" where	id = "+ _user_uk;
	}

	rs = db_stmt.executeQuery (q);

	out.print ("{\"success\":true"
			+", \"children\":[{"
				+"	\"id\":0"
				+",	\"pid\":0"
				+",	\"text\":\"Folder arsip\""
				+",	\"unit_kerja_id\":0"
				+",	\"kode_rak\":\"0\""
				+",	\"kode_box\":\"0\""
				+",	\"kode_folder\":\"0\""
				+",	\"type\":\"root\""
				+",	\"depth\":"+ depth
				+",	\"index\":0"
				+",	\"children\":[");

	while (rs.next ()) {
		uk_id	= rs.getInt ("id");
		nama	= rs.getString ("nama");
		id		= uk_id +".0.0.0";

		out.print ("{"
				+"	\"id\":"+ id
				+", \"pid\":0"
				+", \"text\":\""+ nama +"\""
				+", \"unit_kerja_id\":"+ uk_id
				+", \"kode_rak\":0"
				+", \"kode_box\":0"
				+", \"kode_folder\":0"
				+", \"type\":\"unit_kerja\""
				+", \"index\":"+ index++
				+", \"children\":[");

		get_list_rak (db_con, out, id, uk_id, depth + 1);

		out.print ("]}");
	}

	rs.close ();
	db_stmt.close ();

	out.print ("]}]}");

} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
	out.print (_r);
}
%>
