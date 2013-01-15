Ext.require ('Earsip.view.PegawaiWin');

Ext.define ('Earsip.controller.Pegawai', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mas_pegawai'
	,	selector: 'mas_pegawai'
	}]
,	init	: function ()
	{
		this.control ({
			'mas_pegawai': {
				selectionchange : this.do_select
			}
		,	'mas_pegawai button[action=add]': {
				click : this.do_add
			}
		,	'mas_pegawai button[action=edit]': {
				click : this.do_edit
			}
		,	'mas_pegawai button[action=refresh]': {
				click : this.do_refresh
			}
		,	'mas_pegawai button[action=del]': {
				click : this.do_del
			}
		,	'pegawai_win button[action=submit]': {
				click : this.do_submit
			}
		});
	}

,	do_select : function (model, records)
	{
		var peg		= this.getMas_pegawai ();
		var b_edit	= peg.down ('#edit');
		var b_del	= peg.down ('#del');
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);

		if (records.length > 0) {
			if (peg.win == undefined) {
				peg.win = Ext.create ('Earsip.view.PegawaiWin', {});
			}
			peg.win.down ('form').loadRecord (records[0]);
		}
	}

,	do_add : function (b)
	{
		var panel = this.getMas_pegawai ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PegawaiWin', {});
		}
		panel.win.down ('#password').allowBlank = false;
		panel.win.show ();
		panel.win.action = 'create';
	}

,	do_edit : function (b)
	{
		var panel = this.getMas_pegawai ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PegawaiWin', {});
		}
		panel.win.down ('#password').allowBlank = true;
		panel.win.show ();
		panel.win.action = 'update';
	}

,	do_refresh : function (b)
	{
		this.getMas_pegawai ().getStore ().load ();
	}

,	do_del : function (b)
	{
		var grid = b.up ('#mas_pegawai');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		grid.win.down ('#password').allowBlank = true;
		grid.win.action = 'destroy';

		this.do_submit (b);
	}

,	do_submit : function (b)
	{
		var grid	= this.getMas_pegawai ();
		var form	= grid.win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		form.submit ({
			scope	: this
		,	params	: {
				action	: grid.win.action
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					grid.getStore ().load ();
					grid.win.hide ();
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
