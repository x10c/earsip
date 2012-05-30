Ext.define ('Earsip.controller.BerkasJRA', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'lap_berkas_jra'
	,	selector: 'lap_berkas_jra'
	},{
		ref		: 'berkas_jra_list'
	,	selector: 'berkas_jra_list'
	}]
,	init	: function ()
	{
		this.control ({
			'berkas_jra_list': {
				selectionchange : this.list_selectionchange
			}
		})
	}

,	list_selectionchange : function (model, records)
	{
		var list = this.getBerkas_jra_list ();

		if (records.length > 0) {
			this.getLap_berkas_jra ().down ('#berkas_jra_form').loadRecord (records[0]);
		}
	}
});
