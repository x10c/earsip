Ext.define ('Earsip.controller.Grup', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref			: 'grup'
	,	selector	: 'grup'
	}]
,	init	: function ()
	{
		this.control ({
			'grup': {
				beforeedit: this.do_before_edit
			,	selectionchange : this.do_select
			}
		,	'grup button[action=add]': {
				click : this.do_add
			}
		,	'grup button[action=refresh]': {
				click : this.do_refresh
			}
		,	'grup button[action=del]': {
				click : this.do_delete
			}
		});
	}

,	do_before_edit : function (editor, o)
	{
		var id = o.record.get ('id');

		if (id != 0 && id < 4) {
			return false;
		}
	}

,	do_select : function (sm, records)
	{
		var bdel = this.getGrup ().down ('#del');

		if (records.length <= 0) {
			bdel.setDisabled (true);
		} else {
			if (records[0].get ('id') <= 3) {
				bdel.setDisabled (true);
			} else {
				bdel.setDisabled (false);
			}
		}
	}

,	do_add : function (button)
	{
		var grid	= button.up ('#grup');
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.Grup', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_refresh : function (button)
	{
		button.up ('#grup').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#grup');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
});
