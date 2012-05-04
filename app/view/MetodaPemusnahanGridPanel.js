Ext.require ('Earsip.store.MetodaPemusnahan');

Ext.define ('Earsip.view.MetodaPemusnahanGridPanel', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.metoda_pemusnahan_grid'
,	itemId		: 'metoda_pemusnahan_grid'
,	store		: 'MetodaPemusnahan'
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
