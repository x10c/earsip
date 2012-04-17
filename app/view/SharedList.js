Ext.require ('Earsip.store.DirList');

Ext.define ('Earsip.view.SharedList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.sharedlist'
,	store		: 'DirList' 
,	title		: 'Berkas Berbagi'
,	columns		: [{
		text		: 'Nama'
	,	flex		: 1
	,	sortable	: false
	,	hideable	: false
	,	dataIndex	: 'name'
	},{
		text		: 'Tanggal Dibuat'
	,	width		: 150
	,	dataIndex	: 'date_created'
	},{
		text		: 'Status'
	,	dataIndex	: 'state'
	}]
,	initComponent	: function() {
		this.callParent (arguments);
	}
});
