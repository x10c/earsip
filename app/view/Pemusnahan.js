Ext.require ([
	'Earsip.store.MetodaPemusnahan'
]);

Ext.define ('Earsip.view.Pemusnahan', {
	extend			: 'Ext.grid.Panel'
,	id				: 'trans_pemusnahan'
,	alias			: 'widget.trans_pemusnahan'
,	itemId			: 'trans_pemusnahan'
,	title			: 'Daftar Pemusnahan'
,	store			: 'Pemusnahan'
,	closable		: true
,	plugins		: [
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns			: [{
		text		: 'ID'
	,	dataIndex	: 'id'
	, 	hidden		: true
	, 	hideable	: false
	},{
		text		: 'Metoda Pemusnahan'
	,	dataIndex	: 'metoda_id'
	,	flex		: 0.5
	,	editor		: {
			xtype			: 'combo'
		,	store			: Ext.create ('Earsip.store.MetodaPemusnahan', {
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
		text			: 'Nama Petugas'
	,	dataIndex		: 'nama_petugas'
	,	flex			: 0.5
	},{
		text			: 'Tanggal Pemusnahan'
	,	dataIndex		: 'tgl'
	,	flex			: 0.5
	},{
		text			: 'PJ. Unit Kerja'
	,	dataIndex		: 'pj_unit_kerja'
	,	flex			: 0.5
	},{
		text			: 'PJ. pusat Berkas/Arsip'
	,	dataIndex		: 'pj_berkas_arsip'
	,	flex			: 0.5
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
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}
});
