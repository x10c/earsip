Ext.define ('Earsip.store.PeminjamanRinci', {
	extend		: 'Ext.data.Store'
,	storeId		: 'PeminjamanRinci'
,	model		: 'Earsip.model.PeminjamanRinci'
,	autoSync	: false
,	autoSave	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/peminjamanrinci.jsp'
		,	create		: 'data/peminjamanrinci_submit.jsp?action=create'
		,	update		: 'data/peminjamanrinci_submit.jsp?action=update'
		,	destroy		: 'data/peminjamanrinci_submit.jsp?action=destroy'
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
