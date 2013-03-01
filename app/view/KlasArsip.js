Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.UnitKerja'
,	'Earsip.view.KlasArsipWin'
]);

var groupingFeature = Ext.create('Ext.grid.feature.Grouping',{
        groupHeaderTpl: 'Unit Kerja : {name} ({rows.length} Item)'
    });

Ext.define ('Earsip.view.KlasArsip', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_klasifikasi_arsip'
,	itemId		: 'ref_klasifikasi_arsip'
,	title		: 'Referensi Klasifikasi Berkas'
,	store		: 'KlasArsip'
,	closable	: true
,	features	: [groupingFeature]
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		xtype		: 'rownumberer'
	},{
		text		: 'Unit Kerja ID'
	,	dataIndex	: 'unit_kerja_id'
	,	flex		: 1
	,	hidden		: true
	,	hideable	: false
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
		text		: 'Kode'
	,	dataIndex	: 'kode'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	, 	groupable	: false
	},{
		text		: 'Nama Klasifikasi'
	,	dataIndex	: 'nama'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	, 	groupable	: false
	},{
		text		: 'JRA Aktif'
	,	dataIndex	: 'jra_aktif'
	,	flex		: 1
	,	editor		: {
			xtype		: 'numberfield'
		,	allowBlank	: false
		,	minValue	: 1
		}
	},{
		text		: 'JRA Inaktif'
	,	dataIndex	: 'jra_inaktif'
	,	flex		: 1
	,	editor		: {
			xtype		: 'numberfield'
		,	allowBlank	: false
		,	minValue	: 1
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
	,	flex		: 2
	,	editor		: {
			xtype		: 'textfield'
		}
	, 	groupable	: false
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		: 'Tambah'
		,	itemId		: 'add'
		,	action		: 'add'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Ubah'
		,	itemId		: 'edit'
		,	iconCls		: 'edit'
		,	action		: 'edit'
		,	disabled	: true
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		},'->',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	action		: 'del'
		,	iconCls		: 'del'
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
