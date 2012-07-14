Ext.require ([
	'Earsip.view.NotifPemindahanWin'
,	'Earsip.store.Pemindahan'
,	'Earsip.store.PemindahanRinci'
,	'Earsip.store.UnitKerja'
]);

Ext.define ('Earsip.view.NotifPemindahan', {
	extend 	: 'Ext.panel.Panel'
,	alias	: 'widget.notif_pemindahan'
,	itemId	: 'notif_pemindahan'
,	title	: 'Notifikasi Pemindahan'
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
	,	title			: 'Notifikasi Pemindahan'
	,	store			: 'Pemindahan'
	,	region			: 'center'
	,	flex			: 1
	,	plugins		: [
			Ext.create ('Earsip.plugin.RowEditor')
		]
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
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.getStore ('UnitKerja')
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
			text			: 'Kode'
		,	dataIndex		: 'kode'
		,	flex			: 0.5
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text			: 'Tanggal'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: false
		,	editor		: {
				xtype		: 'textfield'
			}

		},{
			text			: 'PJ. Pusat Berkas'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		,	editable		: false
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text			: 'PJ. Pusat Arsip'
		,	dataIndex		: 'pj_unit_arsip'
		,	flex			: 0.5
		,	editor		: {
				xtype		: 'textfield'

			}
		,	renderer	: function (v)
			{
				if (v == null || v == 'null') 
					return String.format( '<span style="color: red">{0}</span>', 'Harap diisi');
				else {
					return v;
				}
			}
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
				text		: 'Refresh'
			,	itemId		: 'refresh'
			,	iconCls		: 'refresh'
			,	action		: 'refresh'
			},{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
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
	,	plugins			:[
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'Pemindahan_id'
		,	dataIndex	: 'pemindahan_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'ID'
		,	dataIndex	: 'berkas_id'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			text		: 'Nama Berkas'
		,	dataIndex	: 'nama'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	disabled	: false
			}
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			
			dataIndex	: 'arsip_status_id'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			text		: 'Kode Folder'
		,	dataIndex	: 'kode_folder'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text		: 'Kode Rak'
		,	dataIndex	: 'kode_rak'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text		: 'Kode Box'
		,	dataIndex	: 'kode_box'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
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
		
	}
});
