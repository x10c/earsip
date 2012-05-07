Ext.require ([
	'Earsip.store.BerkasKlasifikasi'
,	'Earsip.store.UnitKerja'
]);

Ext.define ('Earsip.view.RefBerkasKlasifikasi', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_berkas_klasifikasi'
,	itemId		: 'ref_berkas_klasifikasi'
,	store		: 'BerkasKlasifikasi'
,	title		: 'Referensi Klasifikasi Berkas'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Unit Kerja'
	,	dataIndex	: 'unit_kerja_id'
	,	flex		: 0.3
	,	editor		: {
			xtype			: 'combo'
		,	store			: 'UnitKerja'
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
	,	flex		: 0.2
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Nama'
	,	dataIndex	: 'nama'
	,	flex		: 0.4
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
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
,	listeners	: {
		activate	: function ()
		{
			this.getStore ().load ();
		}
	}
});
