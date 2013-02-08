Ext.define ('Earsip.model.PemusnahanRinci', {
	extend	:'Ext.data.Model'
,	fields	:[
		'berkas_id'
	,	'nama'
	,	'keterangan'
	,	'jml_lembar'
	,	'jml_set'
	,	'jml_berkas'
	]
});

Ext.define ('Earsip.store.PemusnahanRinci', {
	extend		: 'Ext.data.Store'
,	storeId		: 'PemusnahanRinci'
,	model		: 'Earsip.model.PemusnahanRinci'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/pemusnahanrinci.jsp'
		,	destroy		: 'data/pemusnahanrinci_submit.jsp?action=destroy'
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
