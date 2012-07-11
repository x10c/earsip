Ext.define ('Earsip.store.Arsip', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.Arsip'
,	storeId		: 'Arsip'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/arsip.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
