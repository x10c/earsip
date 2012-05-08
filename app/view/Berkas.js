Ext.require ([
	'Earsip.view.DirList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.Berkas', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.berkas'
,	itemId		: 'berkas'
,	title		: 'Berkas'
,	layout		: 'border'
,	items		: [{
		xtype		: 'dirlist'
	,	region		: 'center'
	},{
		xtype		: 'berkasform'
	,	itemId		: 'berkas_form'
	,	url			: 'data/berkas_submit.jsp'
	,	region		: 'south'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	,	buttons		: [{
			text		: 'Simpan'
		,	itemId		: 'save'
		,	iconCls		: 'save'
		}]
	}]
});
