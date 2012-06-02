Ext.require ([
	'Earsip.view.PeminjamanWin'
,	'Earsip.store.Peminjaman'
,	'Earsip.store.UnitKerja'
]);

Ext.define ('Earsip.view.Peminjaman', {
	extend			: 'Ext.grid.Panel'
,	id				: 'trans_peminjaman'
,	alias			: 'widget.trans_peminjaman'
,	itemId			: 'trans_peminjaman'
,	title			: 'Daftar Peminjaman'
,	store			: 'Peminjaman'
,	closable		: true
,	plugins		: [
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns			: [{
		text		: 'ID'
	,	dataIndex	: 'id'
	,	hidden		: true
	,	hideable	: false
	},{
		text		: 'Unit Kerja Peminjam'
	,	dataIndex	: 'unit_kerja_peminjam_id'
	,	flex		: 0.5
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
	,	flex			: 0.5
	},{
		text			: 'Pimpinan Peminjam'
	,	dataIndex		: 'nama_pimpinan_peminjam'
	,	flex			: 0.5
	},{
		text			: 'Nama Petugas'
	,	dataIndex		: 'nama_petugas'
	,	flex			: 0.5
	},{
		text			: 'Pimpinan Petugas'
	,	dataIndex		: 'nama_pimpinan_petugas'
	,	flex			: 0.5
	},{
		text			: 'Tanggal Peminjaman'
	,	dataIndex		: 'tgl_pinjam'
	,	flex			: 0.5
	},{
		text			: 'Tanggal Batas Pengembalian'
	,	dataIndex		: 'tgl_batas_kembali'
	,	flex			: 0.5
	},{
		text			: 'Tanggal Kembali'
	,	dataIndex		: 'tgl_kembali'
	,	flex			: 0.5
	,	hidden			: true
	,	hideable		: false
	},{
		text			: 'Keterangan'
	,	dataIndex		: 'keterangan'
	,	flex			: 1
	
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
		},'-','->','-',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	iconCls		: 'del'
		,	action		: 'del'
		,	disabled	: true
		}]
	}]
,	listeners		: {
		activate		: function (comp)
		{
			this.getStore ().load ();
			
		}

	,	afterrender : function (comp)
		{
			if (Ext.getCmp ('peminjaman_win')!= undefined)
				this.win = Ext.getCmp ('peminjaman_win');
		}
	}	
	
});
