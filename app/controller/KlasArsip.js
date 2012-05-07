Ext.require ('Earsip.view.KlasArsipWin');

Ext.define ('Earsip.controller.KlasArsip', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'ref_klasifikasi_arsip'
	,	selector: 'ref_klasifikasi_arsip'
	}]
,	init	: function ()
	{
		this.control ({
			'ref_klasifikasi_arsip': {
				selectionchange : this.do_select
			}
		,	'ref_klasifikasi_arsip button[action=add]': {
				click : this.do_add
			}
		,	'ref_klasifikasi_arsip button[action=edit]': {
				click : this.do_edit
			}
		,	'ref_klasifikasi_arsip button[action=refresh]': {
				click : this.do_refresh
			}
		,	'ref_klasifikasi_arsip button[action=del]': {
				click : this.do_delete
			}
		,	'klas_arsip_win button[action=submit]': {
				click : this.do_submit
			}
		,	'klas_arsip_win' : {
				beforeclose : this.do_check
		}
		});
		
		var form = this
	}
	
,	do_check : function (panel)
	{
		var grid	= this.getRef_klasifikasi_arsip ();
		grid.getSelectionModel (). deselectAll ();
	}
	
,	do_select : function (sm, records)
	{
		var klas_arsip	= this.getRef_klasifikasi_arsip ();
		var b_edit		= klas_arsip.down ('#edit');
		var b_del		= klas_arsip.down ('#del');
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);

		if (records.length > 0) {
			if (klas_arsip.win == undefined) {
				klas_arsip.win = Ext.create ('Earsip.view.KlasArsipWin', {});
			}
			klas_arsip.win.down ('form').loadRecord (records[0]);
		}
		
	}

,	do_add : function (button)
	{
		var panel = this.getRef_klasifikasi_arsip ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.KlasArsipWin', {});
		}
		panel.win.down ('form').getForm ().reset ();
		panel.win.show ();
		panel.win.action = 'create';
		
	}
,	do_edit : function (b)
	{
		var panel = this.getRef_klasifikasi_arsip ();

		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.KlasArsipWin', {});
		}
		panel.win.show ();
		panel.win.action = 'update';
	}
,	do_refresh : function (button)
	{
		button.up ('#ref_klasifikasi_arsip').getStore ().load ();
	}

,	do_delete : function (button)
	{
		var grid = button.up ('#ref_klasifikasi_arsip');
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
		var grid	= this.getRef_klasifikasi_arsip ();
		var win		= b.up ('#klas_arsip_win');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi semua kolom yang kosong terlebih dahulu');
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
					Ext.Msg.alert ('Informasi', action.result.info);
					if (win.action == 'update'){
						win.hide ();
					} else {
						form.reset ();
					}
					grid.getStore ().load ();
					
				} else {
					Ext.Msg.alert ('Kesalahan', action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.Msg.alert ('Kesalahan', action.result.info);
			}
		});
	}
});
