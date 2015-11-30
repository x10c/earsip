Ext.define ('Earsip.model.ModeArsip', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'nama'
	]
});

Ext.define ('Earsip.store.ModeArsip', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.ModeArsip'
,	storeId		: 'ModeArsip'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/mode_arsip.jsp'
		,	create		: 'data/mode_arsip_submit.jsp?action=create'
		,	update		: 'data/mode_arsip_submit.jsp?action=update'
		,	destroy		: 'data/mode_arsip_submit.jsp?action=destroy'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	,	writer		: {
			type		: 'json'
		}
	}
});
