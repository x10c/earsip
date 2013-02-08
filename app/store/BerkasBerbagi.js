Ext.define ('Earsip.model.BerkasBerbagi', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'berkas_id'
	,	'bagi_ke_peg_id'
	]
});

Ext.define ('Earsip.store.BerkasBerbagi', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.BerkasBerbagi'
,	storeId		: 'BerkasBerbagi'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/berkasberbagi.jsp'
		,	create		: 'data/berkasberbagi_submit.jsp?action=create'
		,	update		: 'data/berkasberbagi_submit.jsp?action=update'
		,	destroy		: 'data/berkasberbagi_submit.jsp?action=destroy'
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
