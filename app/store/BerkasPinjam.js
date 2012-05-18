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
		,	create		: 'data/berkaspinjam_submit.jsp?action=create'
		,	update		: 'data/berkaspinjam_submit.jsp?action=update'
		,	destroy		: 'data/berkaspinjam_submit.jsp?action=destroy'
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
