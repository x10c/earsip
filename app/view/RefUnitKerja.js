Ext.require ('Earsip.store.UnitKerja');

Ext.define ('Earsip.view.RefUnitKerja', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_unit_kerja'
,	title		: 'Referensi Unit Kerja'
,	itemId		: 'ref_unit_kerja'
,	store		: 'UnitKerja'
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Kode'
	,	dataIndex	: 'kode'
	,	width		: 50
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Nama'
	,	dataIndex	: 'nama'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
	,	width		: 350
	,	editor		: {
			xtype		: 'textfield'
		}
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
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		},'->',{
			text		: 'Hapus'
		,	itemId		: 'delete'
		,	action		: 'delete'
		,	iconCls		: 'delete'
		}]
	}]
});
