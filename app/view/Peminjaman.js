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
		,	dataIndex	: 'berkas_id'
		,	flex		: 1
		,	editor		: {
				xtype			: 'combobox'
			,	store			: 'BerkasPinjam'
			,	valueField		: 'id'
			,	displayField	: 'nama'
			,	allowBlank		: false
			,	autoSelect		: true
			,	triggerAction	: 'all'
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text		: 'Nomor'
		,	flex		: 1
		,	editor		: {
				xtype			: 'combobox'
			,	store			: 'BerkasPinjam'
			,	valueField		: 'id'
			,	displayField	: 'nomor'
			,	allowBlank		: false
			,	autoSelect		: true
			,	triggerAction	: 'all'
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{	
				v = r.get ('berkas_id');
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text		: 'Pembuat'
		,	flex		: 1
		,	editor		: {
				xtype			: 'combobox'
			,	store			: 'BerkasPinjam'
			,	valueField		: 'id'
			,	displayField	: 'pembuat'
			,	allowBlank		: false
			,	autoSelect		: true
			,	triggerAction	: 'all'
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{	
				v = r.get ('berkas_id');
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text		: 'Judul'
		,	flex		: 1
		,	editor		: {
				xtype			: 'combobox'
			,	store			: 'BerkasPinjam'
			,	valueField		: 'id'
			,	displayField	: 'judul'
			,	allowBlank		: false
			,	autoSelect		: true
			,	triggerAction	: 'all'
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{	
				v = r.get ('berkas_id');
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text		: 'Masalah'
		,	flex		: 1
		,	editor		: {
				xtype			: 'combobox'
			,	store			: 'BerkasPinjam'
			,	valueField		: 'id'
			,	displayField	: 'masalah'
			,	allowBlank		: false
			,	autoSelect		: true
			,	triggerAction	: 'all'
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{	
				v = r.get ('berkas_id');
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text		: 'JRA(Tahun)'
		,	flex		: 0.4
		,	editor		: {
				xtype			: 'combobox'
			,	store			: 'BerkasPinjam'
			,	valueField		: 'id'
			,	displayField	: 'jra_inaktif'
			,	allowBlank		: false
			,	autoSelect		: true
			,	triggerAction	: 'all'
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{	
				v = r.get ('berkas_id');
				return combo_renderer (v, this.columns[colidx]);
			}
		}]
	}]
,	listeners		: {
		activate		: function (comp)
		{
			this.down ('#peminjaman_grid').getStore ().load ();
			Ext.StoreManager.lookup ('BerkasPinjam').load ({
				scope	: this
			,	callback: function (r, op, success){
					if (success)
					{
						this.down ('#berkas_pinjam_grid').getStore ().load ();
					}
				}
			});
		}
	}

,	initComponent : function ()
	{
		this.win = Ext.create ('Earsip.view.PeminjamanWin', {});
		this.win.hide ();
		this.callParent (arguments);
	}	
});
