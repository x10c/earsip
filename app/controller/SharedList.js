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
		,	'sharedlist button[itemId=dirup]': {
				click : this.do_dirup
			}
		});
	}

,	row_dbl_clicked : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}

		Earsip.share.id = r.get ('id');
		Earsip.share.pid = r.get ('pid');

		this.getSharedlist ().do_load_list (Earsip.share.id);
	}

,	do_refresh : function (b)
	{
		this.getSharedlist ().getStore ().load ();
	}

,	do_dirup : function (b)
	{
		if (Earsip.share.pid != 0) {
			this.getSharedlist ().do_load_up_list (Earsip.share.pid);
		}
	}
});
