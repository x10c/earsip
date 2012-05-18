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
		,	'trans_peminjaman  button[action=refresh]': {
				click : this.do_refresh
			}
		,	'trans_peminjaman  button[action=edit]': {
				click : this.do_edit
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
		
		var form = this
	}

,	user_select : function (grid, records)
	{
		var peminjaman	= this.getTrans_peminjaman ();
		var b_edit		= peminjaman.down ('#edit');
		var b_del		= peminjaman.down ('#del');
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);

		if (records.length > 0) {
			if (peminjaman.win == undefined) {
				peminjaman.win = Ext.create ('Earsip.view.PeminjamanWin', {});
			}
			peminjaman.win.down ('form').loadRecord (records[0]);
		}
	}

,	do_add : function (button)
	{
		var panel = this.getTrans_peminjaman ();
		
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PeminjamanWin', {});
		}
		
		var grid_rinci = panel.win.down ('#peminjaman_rinci');
		var form = panel.win.down ('form').getForm ();
		form.reset ();
		grid_rinci.getStore ().load();
		panel.win.show ();
		panel.win.action = 'create';
		
	}
,	do_refresh : function (button)
	{
		this.getTrans_peminjaman ().getStore ().load ();
	}
	
,	do_edit : function (b)
	{
		var panel = this.getTrans_peminjaman ();
		var grid_rinci = panel.win.down('#peminjaman_rinci');
		var form	= panel.win.down ('form').getForm ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PeminjamanWin', {});
		}
		
		panel.win.show ();
		panel.win.action = 'update';

		Ext.data.StoreManager.lookup ('BerkasPinjam').load ({
			scope	: this
		,	callback: function (r, op, success)
			{
				if (success) {
					grid_rinci.params = {
						peminjaman_id  : form.getRecord ().get ('id')
					}
					grid_rinci.getStore ().load ({
						params	: grid_rinci.params
					});
				}
			}
		});
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
		var win		= grid.up ('#peminjaman_win');
		var form	= win.down ('form').getForm ();
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		var r = null;
		if (win.action == 'update'){
			r = Ext.create ('Earsip.model.PeminjamanRinci', {
				peminjaman_id	: form.getRecord ().get ('id')
			,	berkas_id		: ''
			});
		} else {
			r = Ext.create ('Earsip.model.PeminjamanRinci', {});
		}
		grid.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_submit	: function (button)
	{
		var grid	= this.getTrans_peminjaman ();
		var win		= button.up ('#peminjaman_win');
		var form	= win.down ('form').getForm ();
		var grid_rinci 	= win.down ('grid');
		var records = grid_rinci.getStore ().getRange ();

		if ((! form.isValid ())) {
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		
		if (records.length <= 0){
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi tabel rincian peminjaman');
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
					if (win.action == 'create')
					{
						var i = 0;
						var new_id = action.result.data;
						while (i < records.length)
						{	
							records[i].set ('peminjaman_id',new_id);
							i++;
						}
					}
					grid_rinci.getStore ().sync ();
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
