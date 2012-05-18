Ext.define ('Earsip.store.BerkasPinjam', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.BerkasPinjam'
,	storeId		: 'BerkasPinjam'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/berkaspinjam.jsp'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
