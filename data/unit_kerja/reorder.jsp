<%--
	Copyright 2013 X10C.Labs

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../init.jsp"%>
<%

try {
	int		id		= ServletUtilities.getIntParameter (request, "id", 0);
	int		v		= ServletUtilities.getIntParameter (request, "value", 0);
	int		next_id	= 0;
	int		urutan	= 0;

	if (v == 1) {
		q	="	select	id"
			+"	,		urutan"
			+"	from	m_unit_kerja"
			+"	where	urutan = ("
			+"		select	urutan + ?"
			+"		from	m_unit_kerja"
			+"		where	id	= ?"
			+"	)";
	} else {
		q	="	select	id"
			+"	,		urutan"
			+"	from	m_unit_kerja"
			+"	where	urutan = ("
			+"		select	urutan - ?"
			+"		from	m_unit_kerja"
			+"		where	id	= ?"
			+"	)";
	}

	db_ps = db_con.prepareStatement (q);

	_i = 1;
	do {
		db_ps.setInt (1, _i);
		db_ps.setInt (2, id);

		rs = db_ps.executeQuery ();
		_i++;
	} while (! rs.next () && _i <= 10);

	next_id	= rs.getInt ("id");
	urutan	= rs.getInt ("urutan");

	db_ps.close ();
	rs.close ();

	q	="	update	m_unit_kerja"
		+"	set		urutan	= ("
		+"		select	urutan"
		+"		from	m_unit_kerja"
		+"		where	id	= ?"
		+"	)"
		+"	where	id		= ?";

	db_ps	= db_con.prepareStatement (q);
	_i		= 1;
	db_ps.setInt (_i++, id);
	db_ps.setInt (_i++, next_id);
	db_ps.executeUpdate ();
	db_ps.close ();

	q	="	update	m_unit_kerja"
		+"	set		urutan	= ?"
		+"	where	id		= ?";

	db_ps	= db_con.prepareStatement (q);
	_i		= 1;
	db_ps.setInt (_i++, urutan);
	db_ps.setInt (_i++, id);
	db_ps.executeUpdate ();
	db_ps.close ();

	_r.put ("success", true);
	_r.put ("info", "Data telah diurutkan");
} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
}

out.print (_r);
%>
