Ext.define ('Earsip.store.TipeArsip', {
	extend		: 'Ext.data.Store'
,	storeId		: 'TipeArsip'
,	model		: 'Earsip.model.TipeArsip'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/tipearsip.jsp'
		,	create		: 'data/tipearsip_submit.jsp?action=create'
		,	update		: 'data/tipearsip_submit.jsp?action=update'
		,	destroy		: 'data/tipearsip_submit.jsp?action=destroy'
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
