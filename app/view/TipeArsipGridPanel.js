Ext.require ('Earsip.store.TipeArsip');

Ext.define ('Earsip.view.TipeArsipGridPanel', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.tipe_arsip_grid'
,	itemId		: 'tipe_arsip_grid'
,	store		: 'TipeArsip'
,	loadmask	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'ID'
	,	dataIndex	: 'id'
	,	flex		: 0.2
	,	editor		: {
			xtype		: 'textfield'
		,	disabled	: true
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
	,	flex		: 2
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
		,	itemId		: 'del'
		,	action		: 'del'
		,	iconCls		: 'del'
		}]
	}]
});
