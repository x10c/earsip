Ext.define ('Earsip.controller.MetodaPemusnahan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'ref_metoda_pemusnahan'
	,	selector: 'ref_metoda_pemusnahan'
	}]
,	init	: function ()
	{
		this.control ({
			'ref_metoda_pemusnahan': {
				selectionchange : this.do_select
			}
		,	'ref_metoda_pemusnahan button[action=add]': {
				click : this.do_add
			}
		,	'ref_metoda_pemusnahan button[action=refresh]': {
				click : this.do_refresh
			}
		,	'ref_metoda_pemusnahan button[action=del]': {
				click : this.do_delete
			}
		});
	}


,	do_select : function (sm, records)
	{
		var bdel = this.getRef_metoda_pemusnahan().down('#del');
		bdel.setDisabled (!records.length);
	}

,	do_add : function (button)
	{
		var grid	= button.up ('#ref_metoda_pemusnahan');
		var editor	= grid.getPlugin ('roweditor');

		editor.action = 'add';
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
		button.up ('#ref_metoda_pemusnahan').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#ref_metoda_pemusnahan');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
});
