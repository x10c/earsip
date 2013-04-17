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
			'trans_peminjaman #peminjaman_grid': {
				selectionchange : this.user_select
			,	beforeedit		: this.do_select
			}
		,	'trans_peminjaman #berkas_pinjam_grid': {
				beforeedit		: this.do_select
			}
		,	'trans_peminjaman #peminjaman_grid button[action=add]': {
				click : this.do_add
			}
		,	'trans_peminjaman #peminjaman_grid button[action=refresh]': {
				click : this.do_refresh
			}
		,	'trans_peminjaman #peminjaman_grid button[action=edit]': {
				click : this.do_edit
			}
		,	'trans_peminjaman #peminjaman_grid button[action=del]': {
				click : this.do_delete_peminjaman
			}
		,	'trans_peminjaman #peminjaman_grid button[itemId=search]': {
				click : this.do_open_win_cari
			}
		,	'trans_peminjaman #peminjaman_grid button[itemId=print]': {
				click : this.do_print_peminjaman
			}
		,	'trans_peminjaman #peminjaman_grid button[itemId=pengembalian]': {
				click : this.do_pengembalian
			}
		,	'peminjaman_win textfield': {
				change: this.do_activate_grid
			}
		,	'peminjaman_win #peminjaman_rinci': {
				itemdblclick: this.do_deactivate_editor
			}
		,	'pengembalian_win #peminjaman_rinci': {
				itemdblclick: this.do_deactivate_editor
			}
		,	'peminjaman_win grid button[action=add]': {
				click : this.do_add_berkas
			}
		,	'peminjaman_win button[action=submit]': {
				click : this.do_submit
			}
		,	'pengembalian_win button[action=submit]': {
				click : this.do_pengembalian_submit
			}
		,	'peminjaman_win grid button[action=del]': {
				click : this.do_delete_berkas
			}
		,	'caripeminjamanwin combo[itemId=pilihan_tanggal]' : {
				change	: this.do_enable_tgl_range
			}
		,	'caripeminjamanwin button[itemId=cari]' : {
				click	: this.do_cari
			}
		});
		
		var form = this
	}

,	user_select : function (gr, records)
	{
		var peminjaman	= this.getTrans_peminjaman ();
		var	grid		= peminjaman.down ('#peminjaman_grid');
		var grid_berkas	= peminjaman.down ('#berkas_pinjam_grid');
		var b_edit		= grid.down ('#edit');
		var b_del		= grid.down ('#del');
		var b_back		= grid.down ('#pengembalian');

		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);

		if (records.length > 0) {
			b_back.setDisabled (records[0].get ('status'));
			peminjaman.win.do_load (records[0]);
			grid_berkas.getStore ().load ({
				params	: {
					peminjaman_id : records[0].get ('id')
				}
			});
		} else {
			grid_berkas.clearData ();
		}
	}

,	do_add : function (button)
	{
		var panel = this.getTrans_peminjaman ();
		var	grid_peminjaman = panel.down ('#peminjaman_grid');
		var grid_rinci = panel.win.down ('#peminjaman_rinci');
		var form = panel.win.down ('form').getForm ();
		var berkaspinjam_store = Ext.StoreManager.lookup ('BerkasPinjam');
		grid_peminjaman.getSelectionModel (). deselectAll ();
		form.reset ();
		panel.win.down ('#nama_petugas').setValue (Earsip.username);
		berkaspinjam_store.filter ('arsip_status_id',0);
		berkaspinjam_store.load ();
		grid_rinci.getStore ().load();
		panel.win.show ();
		panel.win.action = 'create';
		
	}
,	do_refresh : function (button)
	{
		this.getTrans_peminjaman ().down ('#peminjaman_grid').getStore ().load ();
		this.getTrans_peminjaman ().down ('#berkas_pinjam_grid').getStore ().load ();
	}
,	do_select	: function (editor, o)
	{
		return false;
	}
,	do_edit : function (b)
	{
		var panel = this.getTrans_peminjaman ();
		panel.win.show ();
		panel.win.action = 'update';
	}
	
, 	do_delete_peminjaman	: function (button)
	{	
		var grid = button.up ('#peminjaman_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}
		
		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus berkas?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}
			
			var store = grid.getStore ();
			store.remove (data);
			store.sync ();
		}
		, this);
	}
	
,	do_open_win_cari	: function (button)
	{
		var panel	= this.getTrans_peminjaman ();
		if (Ext.getCmp ('caripeminjamanwin') == undefined)
		{
			panel.win_cari = Ext.create ('Earsip.view.CariPeminjamanWin', {});	
		}
		panel.win_cari.show ();
		
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
	
,	do_pengembalian	: function (button){
		var panel = this.getTrans_peminjaman ();
		var grid  = panel.down ('#peminjaman_grid');
		var records = grid.getSelectionModel().getSelection ();
		if (Ext.getCmp ('pengembalian_win') == undefined){
				panel.win_pengembalian = Ext.create ('Earsip.view.PengembalianWin', {});
			}
		panel.win_pengembalian.load (records[0]);
		panel.win_pengembalian.show ();
		
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
		var grid	= this.getTrans_peminjaman ().down ('#peminjaman_grid');
		var win		= button.up ('#peminjaman_win');
		var form	= win.down ('form').getForm ();
		var grid_rinci 	= win.down ('grid');
		var records = grid_rinci.getStore ().getRange ();
		var berkas = [];

		if ((! form.isValid ())) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		
		if (records.length <= 0){
			Ext.msg.error ('Silahkan isi tabel rincian peminjaman');
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
					Ext.msg.info (action.result.info);
					win.close ();
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
	
,	do_pengembalian_submit	: function (button)
	{
		var grid	= this.getTrans_peminjaman ().down ('#peminjaman_grid');
		var win		= button.up ('#pengembalian_win');
		var form	= win.down ('form').getForm ();


		if ((! form.isValid ())) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		
		form.submit ({
			scope	: this
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					win.close ();
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
	
,	do_enable_tgl_range : function (combo)
	{ 
		var win	= combo.up ('#caripeminjamanwin');
		var tgl_setelah	= win.down ('#tgl_setelah');
		var tgl_sebelum	= win.down ('#tgl_sebelum');
	
		tgl_setelah.setDisabled (! (combo.getRawValue () != ''));
		tgl_sebelum.setDisabled (! (combo.getRawValue () != ''));

	}
	
,	do_cari	: function (button)
	{
		var form 	= button.up ('#caripeminjamanwin').down ('form').getForm ();
		var grid 	= this.getTrans_peminjaman ().down ('#peminjaman_grid');
		var store	= grid.getStore ();
		var proxy	= store.getProxy ();
		var org_url = proxy.api.read;
		
		proxy.api.read	= 'data/caripeminjaman.jsp';
		
		store.load ({
			params	:	form.getValues ()
		});
		
		proxy.api.read	= org_url;
	}
	
,	do_print_peminjaman: function (button)
	{
		var grid = button.up ('#peminjaman_grid');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}
		var url = 'data/bapeminjamanreport_submit.jsp?peminjaman_id=' + data[0].get ('id');
		window.open (url);
	}
});
