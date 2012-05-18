Ext.require ('Earsip.view.PeminjamanWin');
Ext.define ('Earsip.controller.Peminjaman', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'trans_peminjaman'
	,	selector: 'trans_peminjaman'
	}]

,	init	: function ()
	{
		this.control ({
			'trans_peminjaman': {
				selectionchange : this.user_select
			}
		,	'trans_peminjaman  button[action=add]': {
				click : this.do_add
			}
		,	'peminjaman_win  textfield': {
				change: this.do_activate_grid
			}
		,	'peminjaman_win grid button[action=add]': {
				click : this.do_add_berkas
			}
		,	'peminjaman_win button[action=submit]': {
				click : this.do_submit
			}
		});
	}

,	user_select : function (grid, records)
	{
		if (records.length > 0) {
			var rinci = this.getPeminjaman_rinci ();

			rinci.params = {
				id : records[0].get('id')
			}
			rinci.getStore ().load ({
				params	: rinci.params
			});
		}
	}

,	do_add : function (button)
	{
		var panel = this.getTrans_peminjaman ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.Peminjaman', {});
		}
		panel.win.down ('form').getForm ().reset ();
		panel.win.show ();
		panel.win.action = 'create';
		
	}
	
,	do_activate_grid : function (textfield)
	{	
		var win	 = textfield.up ('#peminjaman_win');
		var form = win.down ('form').getForm ();
		var grid = win.down ('#peminjaman_rinci');
		grid.setDisabled (!form.isValid ()); 
	}

, 	do_add_berkas	: function (button)
	{
		var grid	= button.up ('#peminjaman_rinci');
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.PeminjamanRinci', {});
		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_submit	: function (button)
	{
		var grid	= this.getTrans_peminjaman ();
		var win		= button.up ('#peminjaman_win');
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
