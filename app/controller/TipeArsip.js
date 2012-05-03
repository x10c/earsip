Ext.define ('Earsip.controller.TipeArsip', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'tipe_arsip_grid'
	,	selector: 'tipe_arsip_grid'
	}]
,	init	: function ()
	{
		this.control ({
			'tipe_arsip_grid': {
				selectionchange : this.do_select
			}
		,	'tipe_arsip_grid button[action=add]': {
				click : this.do_add
			}
		,	'tipe_arsip_grid button[action=refresh]': {
				click : this.do_refresh
			}
		,	'tipe_arsip_grid button[action=del]': {
				click : this.do_delete
			}
		});
	}


,	do_select : function (sm, records)
	{
		var bdel = this.getTipe_arsip_grid().down('#del');
		
		if (records.length <= 0) {
			bdel.setDisabled (true);
		} else if (records.count <= 1)	{
			bdel.setDisabled (true);
		} else bdel.setDisabled (false);
	}

,	do_add : function (button)
	{
		var grid	= button.up ('#tipe_arsip_grid');
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
		button.up ('#tipe_arsip_grid').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#tipe_arsip_grid');
		var data = grid.getSelectionModel ().getSelection ();
		console.log(data.length);
		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
});
