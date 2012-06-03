Ext.require ('Earsip.view.RefIndeksRelatif');

Ext.define ('Earsip.controller.IndeksRelatif', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'ref_indeks_relatif'
	,	selector: 'ref_indeks_relatif'
	}]
,	init	: function ()
	{
		this.control ({
			'ref_indeks_relatif': {
				selectionchange : this.do_select
			}
		,	'ref_indeks_relatif button[action=add]': {
				click : this.do_add
			}
		,	'ref_indeks_relatif button[action=edit]': {
				click : this.do_edit
			}
		,	'ref_indeks_relatif button[action=refresh]': {
				click : this.do_refresh
			}
		,	'ref_indeks_relatif button[action=del]': {
				click : this.do_delete
			}
		,	'indeks_relatif_win button[action=submit]': {
				click : this.do_submit
			}
		,	'indeks_relatif_win' : {
				beforeclose : this.do_check
		}
		});
		
		var form = this
	}
	
,	do_check : function (panel)
	{
		var grid	= this.getRef_indeks_relatif ();
		grid.getSelectionModel (). deselectAll ();
	}
	
,	do_select : function (sm, records)
	{
		var ir	= this.getRef_indeks_relatif ();
		var b_edit		= ir.down ('#edit');
		var b_del		= ir.down ('#del');
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);

		if (records.length > 0) {
			if (ir.win == undefined) {
				ir.win = Ext.create ('Earsip.view.RefIndeksRelatifWin', {});
			}
			ir.win.down ('form').loadRecord (records[0]);
		}
		
	}

,	do_add : function (button)
	{
		var panel = this.getRef_indeks_relatif ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.RefIndeksRelatifWin', {});
		}
		panel.win.down ('form').getForm ().reset ();
		panel.win.show ();
		panel.win.action = 'create';
		
	}
,	do_edit : function (b)
	{
		var panel = this.getRef_indeks_relatif ();

		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.RefIndeksRelatifWin', {});
		}
		panel.win.show ();
		panel.win.action = 'update';
	}
,	do_refresh : function (button)
	{
		var grid = button.up ('#ref_indeks_relatif');
		grid.getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#ref_indeks_relatif');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
,	do_submit : function (b)
	{
		var grid	= this.getRef_indeks_relatif ();
		var win		= b.up ('#indeks_relatif_win');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		form.submit ({
			scope	: this
		,	params	: {
				action	: win.action
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					if (win.action == 'update'){
						win.hide ();
					} else {
						form.reset ();
					}
					grid.getStore ().load ();
					
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error (action.result.info);
			}
		});
	}
});
