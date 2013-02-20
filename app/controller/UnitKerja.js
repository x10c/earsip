Ext.define ('Earsip.controller.UnitKerja', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mas_unit_kerja'
	,	selector: 'mas_unit_kerja'
	}]
,	init	: function ()
	{
		this.control ({
			'mas_unit_kerja button[itemId=add]' : {
				click : this.do_add
			}
		,	'mas_unit_kerja button[itemId=del]' : {
				click : this.do_delete
			}
		});
	}

,	do_add : function (b)
	{
		var grid	= b.up ('#mas_unit_kerja');
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		editor.action = 'add';
		var r = Ext.create ('Earsip.model.UnitKerja', {
				id				: 0
			,	kode			: ''
			,	nama			: ''
			,	nama_pimpinan	: ''
			,	keterangan		: ''
			});

		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_delete : function (b)
	{
		var grid	= b.up ('#mas_unit_kerja');
		var data	= grid.getSelectionModel ().getSelection ();
		var store	= grid.getStore ();

		if (data.length <= 0) {
			return;
		}

		store.remove (data);
		store.sync ();
	}
});
