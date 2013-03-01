Ext.require ('Earsip.store.Grup');

Ext.define ('Earsip.view.Grup', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.grup'
,	itemId		: 'grup'
,	title		: 'Daftar Grup'
,	store		: 'Grup'
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Nama Grup'
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
