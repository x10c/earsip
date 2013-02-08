Ext.define ('Earsip.model.Grup', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'nama'
	,	'keterangan'
	]
});

Ext.define ('Earsip.store.Grup', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Grup'
,	model		: 'Earsip.model.Grup'
,	autoSync	: false
,	autoLoad	: true
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/grup.jsp'
		,	create		: 'data/grup_submit.jsp?action=create'
		,	update		: 'data/grup_submit.jsp?action=update'
		,	destroy		: 'data/grup_submit.jsp?action=destroy'
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
