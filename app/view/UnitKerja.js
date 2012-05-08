Ext.require ('Earsip.store.UnitKerja');

Ext.define ('Earsip.view.UnitKerja', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.mas_unit_kerja'
,	title		: 'Data Unit Kerja'
,	itemId		: 'mas_unit_kerja'
,	store		: 'UnitKerja'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Kode'
	,	dataIndex	: 'kode'
	,	width		: 100
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
		text		: 'Pimpinan'
	,	dataIndex	: 'nama_pimpinan'
	,	width		: 200
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
	,	width		: 300
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
		,	iconCls		: 'add'
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		},'->',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	iconCls		: 'del'
		}]
	}]
});
