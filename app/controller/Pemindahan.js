Ext.require ([
	'Earsip.view.PemindahanWin'
,	'Earsip.view.PemindahanRinciWin'
]);

var idc = -1;

Ext.define ('Earsip.controller.Pemindahan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'trans_pemindahan'
	,	selector: 'trans_pemindahan'
	}]

,	init	: function ()
	{
		this.control ({
			'trans_pemindahan #pemindahan_grid': {
				selectionchange : this.user_select
			}
		,	'trans_pemindahan #berkas_pindah_grid': {
				selectionchange : this.user_select_rinci
			}
		,	'trans_pemindahan #pemindahan_grid button[action=add]': {
				click : this.do_add_pemindahan
			}
		,	'trans_pemindahan #pemindahan_grid button[action=edit]': {
				click : this.do_edit_pemindahan
			}
		,	'trans_pemindahan #pemindahan_grid button[action=refresh]': {
				click : this.do_refresh_pemindahan
			}
		,	'notif_pemindahan #berkas_pindah_grid button[action=refresh]': {
				click : this.do_refresh_pemindahanrinci
			}
		,	'trans_pemindahan #pemindahan_grid button[action=del]': {
				click : this.do_delete_pemindahan
			}
		,	'pemindahan_win button[action=submit]': {
				click : this.do_pemindahan_submit
			}
		,	'trans_pemindahan #berkas_pindah_grid button[action=add]': {
				click : this.do_add_berkas_pindah
			}
		,	'trans_pemindahan #berkas_pindah_grid button[action=del]': {
				click : this.do_delete_berkas_pindah
			}
		,	'pemindahanrinci_win button[action=submit]': {
				click : this.do_pemindahanrinci_submit
			}
		});

		var form = this
	}

,	user_select : function (sm, records)
	{
		var panel = this.getTrans_pemindahan ()
		var grid = panel.down ('#pemindahan_grid');
		var grid_rinci = panel.down ('#berkas_pindah_grid');
		var b_edit		= grid.down ('#edit');
		var b_del		= grid.down ('#del');
		var b_add_rinci	= grid_rinci.down ('#add');

		if (records.length > 0) {
			b_edit.setDisabled ( records[0].get ('status'));
			b_del.setDisabled ( records[0].get ('status'));
			b_add_rinci.setDisabled ( records[0].get ('status'));

			idc = records[0].get ('id');

			if (panel.win == undefined) {
				panel.win = Ext.create ('Earsip.view.PemindahanWin', {});
			}
			panel.win.down ('form').loadRecord (records[0]);
			grid_rinci.params = {
				pemindahan_id : records[0].get ('id')
			}
			grid_rinci.getStore ().load ({
				params	: grid_rinci.params
			});
		}
	}

,	user_select_rinci : function (sm, records)
	{
		var panel = this.getTrans_pemindahan ()
		var grid_pindah = panel.down ('#pemindahan_grid');
		var grid = panel.down ('#berkas_pindah_grid');
		var b_del = grid.down ('#del');
		var record = grid_pindah.getSelectionModel (). getSelection();
		var status = record[0]!=null?record[0].get('status'):0;
		b_del.setDisabled (!(records.length && !status));
	}

,	do_add_pemindahan: function (button)
	{
		var panel = this.getTrans_pemindahan ();

		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemindahanWin', {});
		}

		var form = panel.win.down ('form').getForm ();
		form. reset ();
		panel.win.show ();
		panel.win.action = 'create';

	}

,	do_refresh_pemindahan: function (button)
	{
		var panel = this.getTrans_pemindahan ();
		var grid_rinci = panel.down ('#berkas_pindah_grid');
		var grid = button.up ('#pemindahan_grid');

		grid.getStore ().load ();
		grid_rinci.getStore ().load ();

	}

,	do_edit_pemindahan: function (button)
	{
		var panel = this.getTrans_pemindahan ();

		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemindahanWin', {});
		}

		panel.win.show ();
		panel.win.action = 'update';
	}

,	do_delete_pemindahan : function (button)
	{
		var grid = button.up ('#pemindahan_grid');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}

,	do_add_berkas_pindah: function (button)
	{
		var panel = this.getTrans_pemindahan ();

		if (panel.win2 == undefined) {
			panel.win2 = Ext.create ('Earsip.view.PemindahanRinciWin', {});
		}

		var form = panel.win2.down ('form').getForm ();
		form.reset ();
		panel.win2.down ('#pemindahan_id').setValue (idc);
		panel.win2.show ();
		panel.win2.action = 'create';
	}

,	do_delete_berkas_pindah : function (button)
	{
		var grid = button.up ('#berkas_pindah_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}

,	do_refresh_pemindahanrinci : function (button)
	{
		if (idc < 1) return;
		var grid = button.up ('#berkas_pindah_grid');
		grid.params = {
			pemindahan_id : idc
		}
		grid.getStore ().load ({
			params	: grid.params
		});
	}

,	do_pemindahan_submit: function (button)
	{
		var grid	= this.getTrans_pemindahan ().down ('#pemindahan_grid');
		var win		= button.up ('#pemindahan_win');
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
					if (win.action=='update') {	
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

,	do_pemindahanrinci_submit: function (button)
	{
		var grid	= this.getTrans_pemindahan ().down ('#berkas_pindah_grid');
		var win		= button.up ('#pemindahanrinci_win');
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
					if (win.action=='update') {
						win.hide ();
					} else {
						form.reset ();
						win.down ('#pemindahan_id').setValue (idc);
					}
					grid.params = {
						pemindahan_id : idc
					}
					grid.getStore ().load ({
						params	: grid.params
					});
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
