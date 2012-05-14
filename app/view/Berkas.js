Ext.require ([
	'Earsip.view.BerkasList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.Berkas', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.berkas'
,	itemId		: 'berkas'
,	title		: 'Berkas'
,	layout		: 'border'
,	items		: [{
		xtype		: 'berkaslist'
	,	region		: 'center'
	},{
		xtype		: 'berkasform'
	,	itemId		: 'berkas_form'
	,	url			: 'data/berkas_submit.jsp'
	,	region		: 'south'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	,	margin		: '5 10 10 5'
	,	buttons		: [{
			text		: 'Simpan'
		,	itemId		: 'save'
		,	iconCls		: 'save'
		}]
	}]
});
