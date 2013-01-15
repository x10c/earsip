Ext.require ([
	'Earsip.store.NotifPeminjaman'
,	'Earsip.store.UnitKerja'
]);

Ext.define ('Earsip.view.NotifPeminjaman', {
	extend			: 'Ext.panel.Panel'
,	alias			: 'widget.notif_peminjaman'
,	itemId			: 'notif_peminjaman'
,	title			: 'Notifikasi Peminjaman'
,	plain			: true
,	layout			: 'border'
,	defaults		: {
		autoScroll	: true
	}
,	items			: [{
		xtype			: 'grid'
	,	alias			: 'widget.peminjaman_grid'
	,	itemId			: 'peminjaman_grid'
	,	title			: 'Daftar Peminjaman'
	,	region			: 'center'
	,	store			: 'NotifPeminjaman'
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
		,	flex		: 0.5
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.getStore ('Earsip.store.UnitKerja')
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
		},{
			text			: 'Status'
		,	dataIndex		: 'status'
		,	flex			: 0.5
		,	renderer		: function (v){
				if (v == 0){
					return String.format( '<span style="color: red">{0}</span>', 'Belum Kembali');
				}
				else {
					return String.format( '<span style="color: green">{0}</span>', 'Sudah Kembali');;
				}
			}
		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Refresh'
			,	itemId		: 'refresh'
			,	iconCls		: 'refresh'
			,	action		: 'refresh'
			,	handler	: function (btn, e){
					this.up ('grid').getStore().load ();
				}
			}]
		}]
	}]
,	listeners		: {
		activate		: function (comp)
		{
			this.down ('#peminjaman_grid').getStore ().load ();
		}
	}	

,	do_refresh	:function ()
	{
		this.down ('#peminjaman_grid').getStore ().load ();
	}
});
