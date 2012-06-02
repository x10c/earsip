Ext.require ('Earsip.store.PeminjamanRinci');

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
			,	beforeedit		: this.do_select
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
		,	'trans_peminjaman  button[action=del]': {
				click : this.do_delete_peminjaman
			}
		,	'peminjaman_win  textfield': {
				change: this.do_activate_grid
			}
		,	'peminjaman_win #peminjaman_rinci': {
				itemdblclick: this.do_deactivate_editor
			}
		,	'peminjaman_win grid button[action=add]': {
				click : this.do_add_berkas
			}
		,	'peminjaman_win button[action=submit]': {
				click : this.do_submit
			}
		,	'peminjaman_win grid button[action=del]': {
				click : this.do_delete_berkas
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
			if (peminjaman.win == undefined){
				peminjaman.win		= Ext.create ('Earsip.view.PeminjamanWin', {});
				
			}
			peminjaman.win.load (records[0]);
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
		panel.getSelectionModel (). deselectAll ();
		form.reset ();
		panel.win.down ('#nama_petugas').setValue (Earsip.username);
		grid_rinci.getStore ().load();
		panel.win.show ();
		panel.win.action = 'create';
		
	}
,	do_refresh : function (button)
	{
		this.getTrans_peminjaman ().getStore ().load ();
	}
,	do_select	: function (editor, o)
	{
		return false;
	}
,	do_edit : function (b)
	{
		var panel = this.getTrans_peminjaman ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PeminjamanWin', {});
		}
		panel.win.show ();
		panel.win.action = 'update';
		
		
		
	}
	
, 	do_delete_peminjaman	: function (button)
	{	
		var grid = button.up ('#trans_peminjaman');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}
	
,	do_activate_grid : function (textfield)
	{	
		var win	 = textfield.up ('#peminjaman_win');
		var form = win.down ('form').getForm ();
		var grid = win.down ('#peminjaman_rinci');
		grid.setDisabled (!form.isValid ()); 
	}

,	do_deactivate_editor : function (v, record, item,index, e)
	{
		var editor	= v.up ('#peminjaman_rinci').getPlugin ('roweditor');
		editor.cancelEdit ();
	}
	
, 	do_add_berkas	: function (button)
	{	
		
		var grid	= button.up ('#peminjaman_rinci');
		var editor	= grid.getPlugin ('roweditor');
		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.PeminjamanRinci', {});
		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
		Ext.data.StoreManager.lookup ('BerkasPinjam').filter ('arsip_status_id',0);
		
	}
	
, 	do_delete_berkas	: function (button)
	{	
		var grid = button.up ('#peminjaman_rinci');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

,	do_submit	: function (button)
	{
		var grid	= this.getTrans_peminjaman ();
		var win		= button.up ('#peminjaman_win');
		var form	= win.down ('form').getForm ();
		var grid_rinci 	= win.down ('grid');
		var records = grid_rinci.getStore ().getRange ();
		var berkas = [];

		if ((! form.isValid ())) {
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		
		if (records.length <= 0){
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi tabel rincian peminjaman');
			return;
		}
		
		for (var i = 0; i < records.length; i++) {
				var berkas_id = records[i].get ('berkas_id')
				if (berkas_id != null && berkas_id != '')
				{
					berkas.push (berkas_id);
				}
			}
		berkas.sort ();
		
		if (berkas.length <= 0){
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi tabel rincian peminjaman');
			return;
		}
		
		form.submit ({
			scope	: this
		,	params	: {
				action		: win.action
			,	nama_petugas: Earsip.username
			,	berkas_id	: '['+ berkas +']'
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.Msg.alert ('Informasi', action.result.info);
					win.close ();
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
