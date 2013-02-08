Ext.define ('Earsip.model.TimPemusnahan', {
	extend	:'Ext.data.Model'
,	fields	:[
		'nama'
	,	'jabatan'
	]
});

Ext.define ('Earsip.store.TimPemusnahan', {
	extend		: 'Ext.data.Store'
,	storeId		: 'TimPemusnahan'
,	model		: 'Earsip.model.TimPemusnahan'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	id			: 'timpemusnahan'
	,	api			: {
			read		: 'data/timpemusnahan.jsp'
		,	destroy		: 'data/timpemusnahan_submit.jsp?action=destroy'
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
