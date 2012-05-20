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
		,	'trans_pemindahan #pemindahan_grid button[action=add]': {
				click : this.do_add_pemindahan
			}
		,	'trans_pemindahan #pemindahan_grid button[action=edit]': {
				click : this.do_edit_pemindahan
			}
		,	'pemindahan_win button[action=submit]': {
				click : this.do_pemindahan_submit
			}
		,	'trans_pemindahan #berkas_pindah_grid button[action=add]': {
				click : this.do_add_berkas_pindah
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
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);
		b_add_rinci.setDisabled (! records.length);

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

,	do_edit_pemindahan: function (button)
	{
		var panel = this.getTrans_pemindahan ();
		
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemindahanWin', {});
		}
		
		panel.win.show ();
		panel.win.action = 'update';
		
	}

,	do_add_berkas_pindah: function (button)
	{
		var panel = this.getTrans_pemindahan ();

		if (panel.win2 == undefined) {
			panel.win2 = Ext.create ('Earsip.view.PemindahanRinciWin', {});
		}
		
		panel.win2.down ('#pemindahan_id').setValue (idc);
		panel.win2.show ();
		panel.win2.action = 'create';
		
	}

,	do_pemindahan_submit: function (button)
	{	
		var grid	= this.getTrans_pemindahan ().down ('#pemindahan_grid');
		var win		= button.up ('#pemindahan_win');
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
					Ext.Msg.alert ('Kesalahan', action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.Msg.alert ('Kesalahan', action.result.info);
			}
		});
	}

,	do_pemindahanrinci_submit: function (button)
	{	
		var grid	= this.getTrans_pemindahan ().down ('#berkas_pindah_grid');
		var win		= button.up ('#pemindahanrinci_win');
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
					grid.params = {
						pemindahan_id : idc
					}
					grid.getStore ().load ({
						params	: grid.params
					});
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
