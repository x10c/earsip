Ext.define ('Earsip.controller.MetodaPemusnahan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'metoda_pemusnahan_grid'
	,	selector: 'metoda_pemusnahan_grid'
	}]
,	init	: function ()
	{
		this.control ({
			'metoda_pemusnahan_grid': {
				selectionchange : this.do_select
			}
		,	'metoda_pemusnahan_grid button[action=add]': {
				click : this.do_add
			}
		,	'metoda_pemusnahan_grid button[action=refresh]': {
				click : this.do_refresh
			}
		,	'metoda_pemusnahan_grid button[action=del]': {
				click : this.do_delete
			}
		});
	}


,	do_select : function (sm, records)
	{
		var bdel = this.getMetoda_pemusnahan_grid().down('#del');
		
		if (records.length <= 0) {
			bdel.setDisabled (true);
		} else if (records.count <= 1)	{
			bdel.setDisabled (true);
		} else bdel.setDisabled (false);
	}

,	do_add : function (button)
	{
		var grid	= button.up ('#metoda_pemusnahan_grid');
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.MetodaPemusnahan', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_refresh : function (button)
	{
		button.up ('#metoda_pemusnahan_grid').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#metoda_pemusnahan_grid');
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
