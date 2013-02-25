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
	,	itemId			: 'pemindahan_grid'
	,	title			: 'Daftar Pemindahan'
	,	store			: 'Pemindahan'
	,	region			: 'center'
	,	flex			: 1
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
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
			text			: 'No Reg/ No Surat'
		,	dataIndex		: 'kode'
		,	flex			: 0.5
		},{
			text			: 'Tanggal'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'status'
		,	dataIndex		: 'status'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
		},{
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
		},{
			text			: 'Penanggung Jawab Pusat Berkas'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		},{
			text			: 'Penanggung Jawab Pusat Arsip'
		,	dataIndex		: 'pj_unit_arsip'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		,	width		: 80
		,	editor		: {
				xtype		: 'textfield'
			}
		,	renderer	: function (v)
			{
				if (v == 1) {
					return String.format( '<span style="color: green">{0}</span>', 'Lengkap');
				} else {
					return String.format( '<span style="color: red">{0}</span>', 'Tidak Lengkap');
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
	,	alias			: 'widget.berkas_pindah_grid'
	,	itemId			: 'berkas_pindah_grid'
	,	title			: 'Daftar Berkas'
	,	store			: 'PemindahanRinci'
	,	region			: 'south'
	,	flex			: 1
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'pemindahan_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Berkas'
		,	dataIndex	: 'nama'
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
			},{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
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
