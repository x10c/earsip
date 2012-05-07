Ext.define ('Earsip.store.TipeArsip', {
	extend	: 'Ext.data.Store'
,	model	: 'Earsip.model.TipeArsip'
,	storeId	: 'TipeArsip'
,	autoSync: false
,	autoLoad: false
,	proxy	: {
		type	: 'ajax'
	,	api		: {
			read	: 'data/tipearsip.jsp'
		,	create	: 'data/tipearsip_submit.jsp?action=create'
		,	update	: 'data/tipearsip_submit.jsp?action=update'
		,	destroy	: 'data/tipearsip_submit.jsp?action=destroy'
		}
	,	reader	: {
			type	: 'json'
		,	root	: 'data'
		}
	,	write	: {
			type	: 'json'
		}
	}
});
