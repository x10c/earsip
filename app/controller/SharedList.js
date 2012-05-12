Ext.define ('Earsip.controller.SharedList', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'sharedlist'
	,	selector: 'sharedlist'
	}]
,	init	: function ()
	{
		this.control ({
			'sharedlist' : {
				itemdblclick : this.row_dbl_clicked
			}
		,	'sharedlist button[itemId=refresh]': {
				click : this.do_refresh
			}
		});
	}

,	row_dbl_clicked : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}
		this.getSharedlist ().do_load_list (r.get ('id'));
	}

,	do_refresh : function (b)
	{
		this.getSharedlist ().getStore ().load ();
	}
});
