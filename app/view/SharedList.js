Ext.require ('Earsip.store.SharedList');

Ext.define ('Earsip.view.SharedList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.sharedlist'
,	store		: 'SharedList'
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
	,	dataIndex	: 'status'
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
