Ext.require ([
	'Earsip.view.PeminjamanWin'
,	'Earsip.store.Peminjaman'
,	'Earsip.store.UnitKerja'
]);

Ext.define ('Earsip.view.Peminjaman', {
	extend			: 'Ext.panel.Panel'
,	alias			: 'widget.trans_peminjaman'
,	itemId			: 'trans_peminjaman'
,	title			: 'Peminjaman'
,	closable		: true
,	plain			: true
,	layout			: 'border'
,	defaults		: {
		split		: true
	,	autoScroll	: true
	}
,	items			: [{
		xtype			: 'grid'
	,	alias			: 'widget.peminjaman_grid'
	,	itemId			: 'peminjaman_grid'
	,	title			: 'Daftar Peminjaman'
	,	region			: 'center'
	,	autoScroll		: true
	,	store			: 'Peminjaman'
	,	plugins		: [
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'id'
		,	hidden		: true
		,	hideable	: false
		},{
			text		: 'Unit Kerja Peminjam'
		,	dataIndex	: 'unit_kerja_peminjam_id'
		,	width		: 140
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.create ('Earsip.store.UnitKerja', {
					autoLoad		: true
				})
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	mode			: 'local'
			,	typeAhead		: false
			,	triggerAction	: 'all'
			,	lazyRender		: true
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text			: 'Nama Peminjam'
		,	dataIndex		: 'nama_peminjam'
		,	width			: 120
		},{
			text			: 'Pimpinan Peminjam'
		,	dataIndex		: 'nama_pimpinan_peminjam'
		,	width			: 120
		,	hidden			: true
		},{
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	width			: 120
		},{
			text			: 'Pimpinan Petugas'
		,	dataIndex		: 'nama_pimpinan_petugas'
		,	width			: 120
		,	hidden			: true
		},{
			text			: 'Tgl. Pinjam'
		,	dataIndex		: 'tgl_pinjam'
		,	width			: 100
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'Tgl. Batas Kembali'
		,	dataIndex		: 'tgl_batas_kembali'
		,	width			: 120
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'Tgl. Kembali'
		,	dataIndex		: 'tgl_kembali'
		,	width			: 100
		,	hideable		: false
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'Keterangan'
		,	dataIndex		: 'keterangan'
		,	flex			: 1
		},{
			text			: 'Status'
		,	dataIndex		: 'status'
		,	width			: 80
		,	renderer		: function (v){
				if (v == 0){
					return Ext.String.format( '<span style="color: red">{0}</span>', 'Belum Kembali');
				}
				else {
					return Ext.String.format( '<span style="color: green">{0}</span>', 'Sudah Kembali');;
				}
			}
		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Tambah'
			,	itemId		: 'add'
			,	iconCls		: 'add'
			,	action		: 'add'
			},'-',{
				text		: 'Ubah'
			,	itemId		: 'edit'
			,	iconCls		: 'edit'
			,	action		: 'edit'
			,	disabled	: true
			},'-',{
				text		: 'Refresh'
			,	itemId		: 'refresh'
			,	iconCls		: 'refresh'
			,	action		: 'refresh'
			},'-',{
				text		: 'Pengembalian'
			,	itemId		: 'pengembalian'
			,	iconCls		: 'dirup'
			,	disabled	: true
			},'-','->','-',{
				text		: 'Cari'
			,	itemId		: 'search'
			,	iconCls		: 'search'
			},{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
			},'-',{
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			}]
		}]
	},{
		xtype			: 'grid'
	,	id				: 'berkas_pinjam_grid'
	,	alias			: 'widget.berkas_pinjam_grid'
	,	itemId			: 'berkas_pinjam_grid'
	,	title			: 'Daftar Berkas'
	,	store			: 'PeminjamanRinci'
	,	region			: 'south'
	,	flex			: 1
	,	plugins			: [
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'peminjaman_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Berkas'
		,	dataIndex	: 'nama'
		,	flex		: 1
		},{
			text		: 'Nomor'
		,	dataIndex	: 'nomor'
		,	flex		: 1
		},{
			text		: 'Pembuat'
		,	dataIndex	:'pembuat'
		,	flex		: 1
		},{
			text		: 'Perihal'
		,	dataIndex	:'judul'
		,	flex		: 1
		},{
			text		: 'Keterangan'
		,	dataIndex	:'masalah'
		,	flex		: 1
		},{
			text		: 'JRA(Tahun)'
		,	dataIndex	:'jra_inaktif'
		,	flex		: 0.4
		}]
	}]
,	listeners		: {
		activate		: function (comp)
		{
			this.down ('#peminjaman_grid').getStore ().load ();
		}
	}

,	master_on_selectionchange : function (cm, r)
	{
		var	grid		= this.down ('#peminjaman_grid');
		var grid_berkas	= this.down ('#berkas_pinjam_grid');
		var b_edit		= grid.down ('#edit');
		var b_del		= grid.down ('#del');
		var b_back		= grid.down ('#pengembalian');

		b_edit.setDisabled (! r.length);
		b_del.setDisabled (! r.length);

		if (r.length > 0) {
			b_back.setDisabled (r[0].get ('status'));
			this.win.do_load (r[0]);
			grid_berkas.getStore ().load ({
				params	: {
					peminjaman_id : r[0].get ('id')
				}
			});
		} else {
			grid_berkas.clearData ();
		}
	}

,	on_beforeedit : function (editor, o)
	{
		return false;
	}

,	master_do_add : function (b)
	{
		var	grid_peminjaman = this.down ('#peminjaman_grid');
		var grid_rinci = this.win.down ('#peminjaman_rinci');
		var form = this.win.down ('form').getForm ();
		var berkaspinjam_store = Ext.StoreManager.lookup ('BerkasPinjam');

		grid_peminjaman.getSelectionModel (). deselectAll ();
		form.reset ();

		this.win.down ('#nama_petugas').setValue (Earsip.username);

		berkaspinjam_store.filter ('arsip_status_id',0);
		berkaspinjam_store.load ();
		grid_rinci.getStore ().load();

		this.win.show ();
		this.win.action = 'create';

	}

,	master_do_refresh : function (b)
	{
		this.down ('#peminjaman_grid').getStore ().load ();
		this.down ('#berkas_pinjam_grid').getStore ().load ();
	}

,	master_do_edit : function (b)
	{
		this.win.show ();
		this.win.action = 'update';
	}

, 	master_do_delete : function (b)
	{
		var grid = b.up ('#peminjaman_grid');
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

,	master_do_print : function (b)
	{
		var grid = b.up ('#peminjaman_grid');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}
		var url = 'data/bapeminjamanreport_submit.jsp?peminjaman_id=' + data[0].get ('id');
		window.open (url);
	}

,	master_open_search_win : function (b)
	{
		this.win_cari.show ();
	}

,	master_do_pengembalian	: function (b)
	{
		var grid  = this.down ('#peminjaman_grid');
		var records = grid.getSelectionModel().getSelection ();

		this.win_pengembalian.load (records[0]);
		this.win_pengembalian.show ();
	}

,	win_on_validitychange : function (form, valid)
	{
		this.win.down ("#peminjaman_rinci").setDisabled (! valid);
	}

,	on_itemdblclick : function (v, record, item,index, e)
	{
		var editor	= v.up ('#peminjaman_rinci').getPlugin ('roweditor');
		editor.cancelEdit ();
	}

, 	peminjaman_do_add_berkas : function (b)
	{
		var grid	= b.up ('#peminjaman_rinci');
		var editor	= grid.getPlugin ('roweditor');
		var r		= Ext.create ('Earsip.model.PeminjamanRinci', {});

		editor.cancelEdit ();

		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
	}

, 	peminjaman_do_delete_berkas	: function (b)
	{
		var grid = b.up ('#peminjaman_rinci');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

,	peminjaman_do_submit	: function (b)
	{
		var grid		= this.down ('#peminjaman_grid');
		var form		= this.win.down ('form').getForm ();
		var grid_rinci 	= this.win.down ('grid');
		var records		= grid_rinci.getStore ().getRange ();
		var berkas		= [];

		if ((! form.isValid ())) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		if (records.length <= 0){
			Ext.msg.error ('Silahkan isi tabel rincian peminjaman');
			return;
		}

		for (var i = 0; i < records.length; i++) {
			var berkas_id = records[i].get ('berkas_id');

			if (berkas_id != null && berkas_id != '') {
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
				action		: this.win.action
			,	nama_petugas: Earsip.username
			,	berkas_id	: '['+ berkas +']'
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					this.win.hide ();
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

,	pengembalian_do_submit : function (button)
	{
		var grid	= this.down ('#peminjaman_grid');
		var form	= this.win_pengembalian.down ('form').getForm ();

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
					this.win_pengembalian.hide ();
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
		var tgl_setelah	= this.win_cari.down ('#tgl_setelah');
		var tgl_sebelum	= this.win_cari.down ('#tgl_sebelum');

		tgl_setelah.setDisabled (! (combo.getRawValue () != ''));
		tgl_sebelum.setDisabled (! (combo.getRawValue () != ''));
	}

,	do_cari	: function (button)
	{
		var form 	= button.up ('#caripeminjamanwin').down ('form').getForm ();
		var grid 	= this.down ('#peminjaman_grid');
		var store	= grid.getStore ();
		var proxy	= store.getProxy ();
		var org_url = proxy.api.read;

		proxy.api.read	= 'data/caripeminjaman.jsp';

		store.load ({
			params	:	form.getValues ()
		});

		proxy.api.read	= org_url;
	}

,	initComponent : function ()
	{
		this.callParent (arguments);

		if (this.win == undefined) {
			this.win = Ext.create ('Earsip.view.PeminjamanWin', {});
		}
		this.win.hide ();

		if (this.win_cari == undefined) {
			this.win_cari = Ext.create ('Earsip.view.CariPeminjamanWin', {});
		}
		this.win_cari.hide ();


		if (this.win_pengembalian == undefined) {
			this.win_pengembalian = Ext.create ('Earsip.view.PengembalianWin', {});
		}

		this.down ("#peminjaman_grid").on ("selectionchange", this.master_on_selectionchange, this);
		this.down ("#peminjaman_grid").on ("beforeedit", this.on_beforeedit, this);
		this.down ("#peminjaman_grid").down ("#add").on ("click", this.master_do_add, this);
		this.down ("#peminjaman_grid").down ("#refresh").on ("click", this.master_do_refresh, this);
		this.down ("#peminjaman_grid").down ("#edit").on ("click", this.master_do_edit, this);
		this.down ("#peminjaman_grid").down ("#del").on ("click", this.master_do_delete, this);
		this.down ("#peminjaman_grid").down ("#print").on ("click", this.master_do_print, this);
		this.down ("#peminjaman_grid").down ("#search").on ("click", this.master_open_search_win, this);
		this.down ("#peminjaman_grid").down ("#pengembalian").on ("click", this.master_do_pengembalian, this);

		this.down ("#berkas_pinjam_grid").on ("beforeedit", this.on_beforeedit, this);

		this.win.down ("#save").on ("click", this.peminjaman_do_submit, this);
		this.win.down ("#peminjaman_win_form").on ("validitychange", this.win_on_validitychange, this);
		this.win.down ("#peminjaman_rinci").on ("itemdblclick", this.on_itemdblclick, this);
		this.win.down ("#peminjaman_rinci").down ("#add").on ("click", this.peminjaman_do_add_berkas, this);
		this.win.down ("#peminjaman_rinci").down ("#del").on ("click", this.peminjaman_do_delete_berkas, this);

		this.win_pengembalian.down ("#peminjaman_rinci").on ("itemdblclick", this.on_itemdblclick, this);
		this.win_pengembalian.down ("#save").on ("click", this.pengembalian_do_submit, this);

		this.win_cari.down ("#pilihan_tanggal").on ("change", this.do_enable_tgl_range, this);
		this.win_cari.down ("#cari").on ("change", this.do_cari, this);
	}
});
