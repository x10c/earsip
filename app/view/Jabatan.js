Ext.require ('Earsip.store.Jabatan');

Ext.define ('Earsip.view.Jabatan', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_jabatan'
,	itemId		: 'ref_jabatan'
,	title		: 'Referensi Jabatan'
,	store		: 'Jabatan'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Nama'
	,	dataIndex	: 'nama'
	,	width		: 100
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
		,	action		: 'add'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		},'-','->','-',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	action		: 'del'
		,	iconCls		: 'del'
		,	disabled	: true
		}]
	}]
});
