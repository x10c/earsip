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
			text			: 'PJ. Pusat Berkas'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		},{
			text			: 'PJ. Pusat Arsip'
		,	dataIndex		: 'pj_unit_arsip'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
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
	,	autoScroll		: true
	,	flex			: 1
	,	columns			: [{
			text		: 'ID'
		,	dataIndex	: 'pemindahan_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Berkas'
		,	dataIndex	: 'berkas_id'
		,	flex		: 0.5
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.create ('Earsip.store.BerkasPindah',{
						autoLoad	: true
				})
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	triggerAction	: 'all'
			,	lazyRender		: true
			,	mode			: 'local'
			,	autoSelect		: true
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{
				return combo_renderer (v, this.columns[colidx]);
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
