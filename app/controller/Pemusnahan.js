Ext.require ('Earsip.view.PemusnahanWin');

Ext.define ('Earsip.controller.Pemusnahan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'trans_pemusnahan'
	,	selector: 'trans_pemusnahan'
	}]

,	init	: function ()
	{
		this.control ({
			'trans_pemusnahan': {
				selectionchange : this.user_select
			}
		,	'trans_pemusnahan button[action=add]': {
				click : this.do_add_pemusnahan
			}
		,	'pemusnahan_win button[action=submit]': {
				click : this.do_pemusnahanrinci_submit
			}
		});

		var form = this
	}

,	user_select : function (sm, records)
	{
		var panel = this.getTrans_pemusnahan ()
		var grid = panel.down ('#pemusnahan_grid');
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
				panel.win = Ext.create ('Earsip.view.PemusnahanWin', {});
			}
			panel.win.down ('form').loadRecord (records[0]);
			grid_rinci.params = {
				pemusnahan_id : records[0].get ('id')
			}
			grid_rinci.getStore ().load ({
				params	: grid_rinci.params
			});
		}
	}

,	do_add_pemusnahan: function (button)
	{
		var panel = this.getTrans_pemusnahan ();

		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemusnahanWin', {});
		}

		var form = panel.win.down ('form').getForm ();
		form. reset ();
		panel.win.show ();
		panel.win.action = 'create';
	}

,	do_edit_pemusnahan: function (button)
	{
		var panel = this.getTrans_pemusnahan ();

		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemusnahanWin', {});
		}

		panel.win.show ();
		panel.win.action = 'update';
	}

,	do_add_berkas_pindah: function (button)
	{
		var panel = this.getTrans_pemusnahan ();

		if (panel.win2 == undefined) {
			panel.win2 = Ext.create ('Earsip.view.PemusnahanRinciWin', {});
		}

		panel.win2.down ('#pemusnahan_id').setValue (idc);
		panel.win2.show ();
		panel.win2.action = 'create';
	}

,	do_pemusnahan_submit: function (button)
	{
		var grid	= this.getTrans_pemusnahan ().down ('#pemusnahan_grid');
		var win		= button.up ('#pemusnahan_win');
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

,	do_pemusnahanrinci_submit: function (button)
	{
		var grid	= this.getTrans_pemusnahan ().down ('#berkas_pindah_grid');
		var win		= button.up ('#pemusnahanrinci_win');
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
						pemusnahan_id : idc
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
