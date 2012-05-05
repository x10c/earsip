Ext.define ('Earsip.store.SharedList', {
	extend		: 'Ext.data.Store'
,	storeId		: 'SharedList'
,	model		: 'Earsip.model.SharedList'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/sharedlist.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
