Ext.define ('Earsip.store.BerkasJRA', {
	extend		: 'Ext.data.Store'
,	storeId		: 'BerkasJRA'
,	model		: 'Earsip.model.BerkasJRA'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/berkasjra.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
