Ext.require ([
	'Earsip.view.BerkasJRAList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.BerkasJRA', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.lap_berkas_jra1'
,	itemId		: 'lap_berkas_jra1'
,	title		: 'Berkas JRA'
,	layout		: 'border'
,	closable	: true
,	items		: [{
		xtype		: 'berkas_jra_list'
	,	region		: 'center'
	},{
		xtype		: 'berkasform'
	,	itemId		: 'berkas_jra_form'
	,	region		: 'south'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	}]
});
