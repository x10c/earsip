Ext.require ([
	'Earsip.view.NotifPemindahanWin'
,	'Earsip.view.NotifPemindahanRinciWin'
]);

var idc = -1;
Ext.define ('Earsip.controller.NotifPemindahan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'notif_pemindahan'
	,	selector: 'notif_pemindahan'
	}]

,	init	: function ()
	{
		this.control ({
			'notif_pemindahan grid[itemId=pemindahan_grid]': {
				itemdblclick	: this.do_view_detail
			,	selectionchange : this.user_select
			}
		,	'notif_pemindahan #berkas_pindah_grid': {
				itemdblclick	: this.do_edit_rinci
			}
		,	'notif_pemindahan #pemindahan_grid button[action=refresh]': {
				click : this.do_refresh_pemindahan
			}
		,	'notif_pemindahan #berkas_pindah_grid button[action=refresh]': {
				click : this.do_refresh_pemindahanrinci
			}
		,	'notif_pemindahan_win button[action=submit]': {
				click : this.do_pemindahan_submit
			}
		,	'notif_pemindahanrinci_win button[action=submit]': {
				click : this.do_pemindahanrinci_submit
			}
		});

		var form = this
	}

,	do_view_detail : function (v, record, item,index, e)
	{
		var panel = this.getNotif_pemindahan ();
		var editor	= v.up ('#pemindahan_grid').getPlugin ('roweditor');

		editor.cancelEdit ();
		if (panel.win3 == undefined) {
			panel.win3 = Ext.create ('Earsip.view.NotifPemindahanWin', {});
		}

		var form = panel.win3.down ('form').getForm ();
		form.loadRecord (record);
		panel.win3.down ('#nama_petugas').setValue (Earsip.username);
		panel.win3.show ();
		panel.win3.action = 'update';
	}

,	do_edit_rinci : function (v, record, item,index, e)
	{
		var panel = this.getNotif_pemindahan ();
		var editor	= v.up ('#berkas_pindah_grid').getPlugin ('roweditor');

		editor.cancelEdit ();
		if (panel.win4 == undefined) {
			panel.win4 = Ext.create ('Earsip.view.NotifPemindahanRinciWin', {});
		}

		var form = panel.win4.down ('form').getForm ();
		form.loadRecord (record);
		panel.win4.show ();
		panel.win4.action = 'update';
	}

,	user_select : function (sm, records)
	{
		var panel = this.getNotif_pemindahan ()
		var grid = panel.down ('#pemindahan_grid');
		var grid_rinci = panel.down ('#berkas_pindah_grid');


		if (records.length > 0) {
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

,	do_refresh_pemindahan: function (button)
	{
		var panel = this.getNotif_pemindahan ();
		var grid_rinci = panel.down ('#berkas_pindah_grid');
		var grid = button.up ('#pemindahan_grid');

		grid.getStore ().load ();
		grid_rinci.getStore ().load ();

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
		var grid	= this.getNotif_pemindahan ().down ('#pemindahan_grid');
		var win		= button.up ('#notif_pemindahan_win');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		win.down('form').items.each (this.unlock);

		form.submit ({
			scope	: this
		,	params	: {
				action	: win.action
			}
		,	success	: function (form, action)
			{
				win.down('form').items.each (this.lock);
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					if (win.action=='update')
					{	
						win.hide ();
					}
					else
					{
						form.reset ();
					}
					grid.getStore ().load ();
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				win.down('form').items.each (this.lock);
				Ext.msg.error (action.result.info);
			}
		});
	}

,	do_pemindahanrinci_submit: function (button)
	{
		var grid	= this.getNotif_pemindahan ().down ('#berkas_pindah_grid');
		var win		= button.up ('#notif_pemindahanrinci_win');
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

					grid.params = {
						pemindahan_id : idc
					}
					grid.getStore ().load ({
						params	: grid.params
					});
					win.hide ();
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

,	unlock	: function (field)
	{
		if ((field.itemId == 'pj_unit_arsip' || field.itemId == 'status'
		|| field.xtype == 'button')) {
			return;
		}
		field.setDisabled (false);
	}

,	lock	: function (field)
	{
		if ((field.itemId == 'pj_unit_arsip' || field.itemId == 'status'
		|| field.xtype == 'button')) {
			return;
		}
		field.setDisabled (true);
	}
});
