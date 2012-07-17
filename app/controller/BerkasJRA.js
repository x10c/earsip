Ext.define ('Earsip.controller.BerkasJRA', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'berkas_jra'
	,	selector: 'berkas_jra'
	},{
		ref		: 'berkas_jra_list'
	,	selector: 'berkas_jra_list'
	}]
,	init	: function ()
	{
		this.control ({
			'berkas_jra_list': {
				itemdblclick : this.list_itemdblclick
			,	selectionchange : this.list_selectionchange
			}
		})
	}

,	list_itemdblclick : function (v, r, idx)
	{
		if (r.get ("tipe_file") != 0) {
			Earsip.win_viewer.down ('#download').hide ();
			Earsip.win_viewer.do_open (r);
		}
	}

,	list_selectionchange : function (model, records)
	{
		var list = this.getBerkas_jra_list ();

		if (records.length > 0) {
			this.getBerkas_jra ().down ('#berkas_jra_form').loadRecord (records[0]);
		}
	}
});
