<%--
	Copyright 2013 X10C.Labs

	Author(s):
	- mhd.sulhan (ms@kilabit.org)
--%>
<%@ include file="../init.jsp"%>
<%

try {
	int		id		= ServletUtilities.getIntParameter (request, "id", 0);
	int		urutan	= ServletUtilities.getIntParameter (request, "urutan", 0);
	int		v		= ServletUtilities.getIntParameter (request, "value", 0);
	int		next_id		= 0;
	int		next_urutan	= 0;

	if (v == 1) {
		q	="	select	id"
			+"	,		urutan"
			+"	from	r_jabatan"
			+"	where	urutan = ? + ?";
	} else {
		q	="	select	id"
			+"	,		urutan"
			+"	from	r_jabatan"
			+"	where	urutan = ? - ?";
	}

	db_ps = db_con.prepareStatement (q);

	_i = 1;
	do {
		db_ps.setInt (1, urutan);
		db_ps.setInt (2, _i);

		rs = db_ps.executeQuery ();
		_i++;
	} while (! rs.next () && _i <= 10);

	if (_i > 10) {
		_r.put ("success", true);
		_r.put ("info", "Data mungkin telah berada di paling atas atau paling bawah.");
		out.print (_r);
		return;
	}

	next_id		= rs.getInt ("id");
	next_urutan	= rs.getInt ("urutan");

	db_ps.close ();
	rs.close ();

	q	="	update	r_jabatan"
		+"	set		urutan	= ?"
		+"	where	id		= ?";

	db_ps	= db_con.prepareStatement (q);
	_i		= 1;
	db_ps.setInt (_i++, urutan);
	db_ps.setInt (_i++, next_id);
	db_ps.executeUpdate ();
	db_ps.close ();

	q	="	update	r_jabatan"
		+"	set		urutan	= ?"
		+"	where	id		= ?";

	db_ps	= db_con.prepareStatement (q);
	_i		= 1;
	db_ps.setInt (_i++, next_urutan);
	db_ps.setInt (_i++, id);
	db_ps.executeUpdate ();
	db_ps.close ();

	_r.put ("success", true);
	_r.put ("info", "Data telah diurutkan.");
} catch (Exception e) {
	_r.put ("success", false);
	_r.put ("info", e);
}
out.print (_r);
%>
