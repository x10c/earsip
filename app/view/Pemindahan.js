Ext.require ([
	'Earsip.view.PemindahanWin'
,	'Earsip.view.PemindahanRinciWin'
,	'Earsip.store.Pemindahan'
,	'Earsip.store.PemindahanRinci'
,	'Earsip.store.BerkasPindah'
]);

Ext.define ('Earsip.view.Pemindahan', {
	extend 	: 'Ext.panel.Panel'
,	alias	: 'widget.trans_pemindahan'
,	itemId	: 'trans_pemindahan'
,	title	: 'Pemindahan'
,	closable: true
,	plain	: true
,	layout	: 'border'
,	defaults: {
		split		: true
	,	autoScroll	: true
	}
,	items	:[{
		xtype			: 'grid'
	,	alias			: 'widget.pemindahan_grid'
	,	id				: 'pemindahan_grid'
	,	itemId			: 'pemindahan_grid'
	,	title			: 'Daftar Pemindahan'
	,	store			: 'Pemindahan'
	,	region			: 'center'
	,	flex			: 1
	,	plugins		: [
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			text		: 'ID'
		,	dataIndex	: 'id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Unit Kerja'
		,	dataIndex	: 'unit_kerja_id'
		,	flex		: 0.5
		,	hidden		: true
		, 	hideable	: false
		},{
			text			: 'Kode'
		,	dataIndex		: 'kode'
		,	flex			: 0.5
		},{
			text			: 'Tanggal'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		},{
			dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: false
		},{
			text			: 'PJ. Pusat Kerja'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		},{
			dataIndex		: 'pj_unit_arsip'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: false
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		,	width		: 80
		,	renderer	: function (v)
			{
				if (v == 1) {
					return 'Lengkap';
				} else {
					return 'Tidak Lengkap';
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
			},'-','->','-',{
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			}]
		}]
	},{
		xtype			: 'grid'
	,	id				: 'berkas_pindah_grid'
	,	alias			: 'widget.berkas_pindah_grid'
	,	itemId			: 'berkas_pindah_grid'
	,	title			: 'Daftar Berkas'
	,	store			: 'PemindahanRinci'
	,	region			: 'south'
	,	flex			: 1
	,	columns			: [{
			text		: 'Pemindahan_id'
		,	dataIndex	: 'pemindahan_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Berkas ID'
		,	dataIndex	: 'berkas_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Nama Berkas'
		,	dataIndex	: 'nama'
		,	flex		: 1
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		, 	hidden		: true
		, 	hideable	: false
		},{
			
			dataIndex	: 'arsip_status_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Kode Folder'
		,	dataIndex	: 'kode_folder'
		,	flex		: 1
		},{
			text		: 'Kode Rak'
		,	dataIndex	: 'kode_rak'
		,	flex		: 1
		},{
			text		: 'Kode Box'
		,	dataIndex	: 'kode_box'
		,	flex		: 1
		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Tambah'
			,	itemId		: 'add'
			,	iconCls		: 'add'
			,	action		: 'add'
			,	disabled	: true
			},{
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			}]
		}]
	}]
,	listeners		: {
		activate		: function (comp)
		{
			var grid = this.down ('#pemindahan_grid');
			grid.getStore ().load ();
			grid = this.down ('#berkas_pindah_grid');
			grid.getStore ().load ();
		}
		,	removed			: function (comp)
		{
			this.destroy ();
		}
	}
});
