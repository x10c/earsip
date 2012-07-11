Ext.define ('Earsip.controller.Jabatan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref			: 'ref_jabatan'
	,	selector	: 'ref_jabatan'
	}]
,	init	: function ()
	{
		this.control ({
			'ref_jabatan': {
				selectionchange : this.do_select
			}
		,	'ref_jabatan button[action=add]': {
				click : this.do_add
			}
		,	'ref_jabatan button[action=refresh]': {
				click : this.do_refresh
			}
		,	'ref_jabatan button[action=del]': {
				click : this.do_delete
			}
		});
	}


,	do_select : function (sm, records)
	{
		var bdel = this.getRef_jabatan ().down ('#del');
		bdel.setDisabled (! records.length);
	}

,	do_add : function (button)
	{
		var grid	= button.up ('#ref_jabatan');
		var editor	= grid.getPlugin ('roweditor');

		editor.action = 'add';
		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.Jabatan', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_refresh : function (button)
	{
		button.up ('#ref_jabatan').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#ref_jabatan');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
});
