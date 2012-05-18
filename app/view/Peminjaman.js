Ext.require ('Earsip.view.PeminjamanWin');

Ext.define ('Earsip.view.Peminjaman', {
	extend			: 'Ext.grid.Panel'
,	alias			: 'widget.trans_peminjaman'
,	itemId			: 'trans_peminjaman'
,	title			: 'Daftar Peminjaman'
,	store			: 'Peminjaman'
,	closable		: true
,	columns			: [{
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
		
		text			: 'Peminjam'
	,	dataIndex		: 'nm_peminjam'
	,	flex			: 0.5
	},{
		text			: 'Pimpinan Peminjam'
	,	dataIndex		: 'nm_pim_peminjam'
	,	flex			: 0.5
	},{
		text			: 'Tanggal'
	,	dataIndex		: 'tgl_pinjam'
	,	flex			: 0.5
	},{
		text			: 'Petugas'
	,	dataIndex		: 'nm_ptgs'
	,	flex			: 0.5
	},{
		text			: 'Pimpinan Petugas'
	,	dataIndex		: 'nm_pim_ptgs'
	,	flex			: 0.5
	},{
		text			: 'Batas Kembali'
	,	dataIndex		: 'tgl_batas'
	,	flex			: 0.5
	},{
		text			: 'Tanggal Kembali'
	,	dataIndex		: 'tgl_kembali'
	,	flex			: 0.5
	,	hidden			: true
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
			this.win = Ext.create ('Earsip.view.PeminjamanWin', {});
			this.win.hide ();
		}
	}
});
