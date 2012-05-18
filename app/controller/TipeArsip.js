Ext.define ('Earsip.controller.TipeArsip', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'ref_tipe_arsip'
	,	selector: 'ref_tipe_arsip'
	}]
,	init	: function ()
	{
		this.control ({
			'ref_tipe_arsip': {
				selectionchange : this.do_select
			}
		,	'ref_tipe_arsip button[action=add]': {
				click : this.do_add
			}
		,	'ref_tipe_arsip button[action=refresh]': {
				click : this.do_refresh
			}
		,	'ref_tipe_arsip button[action=del]': {
				click : this.do_delete
			}
		});
	}


,	do_select : function (sm, records)
	{
		var bdel = this.getRef_tipe_arsip().down('#del');
		bdel.setDisabled (! records.length);
	}

,	do_add : function (button)
	{
		var grid	= button.up ('#ref_tipe_arsip');
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.TipeArsip', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_refresh : function (button)
	{
		button.up ('#ref_tipe_arsip').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#ref_tipe_arsip');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
});
