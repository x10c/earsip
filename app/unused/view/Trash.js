Ext.require ([
	'Earsip.store.Berkas'
,	'Earsip.view.TrashList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.Trash', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.trash'
,	itemId		: 'trash'
,	title		: 'Berkas Buangan'
,	layout		: 'border'
,	closable	: true
,	items		: [{
		xtype		: 'trashlist'
	,	region		: 'center'
	},{
		xtype		: 'berkasform'
	,	itemId		: 'berkasform'
	,	url			: 'data/berkas_submit.jsp'
	,	region		: 'south'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	,	margin		: '5 10 10 5'
	}]
});
