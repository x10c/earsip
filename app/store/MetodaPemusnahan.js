Ext.define ('Earsip.store.MetodaPemusnahan', {
	extend		: 'Ext.data.Store'
,	storeId		: 'MetodaPemusnahan'
,	model		: 'Earsip.model.MetodaPemusnahan'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/metodapemusnahan.jsp'
		,	create		: 'data/metodapemusnahan_submit.jsp?action=create'
		,	update		: 'data/metodapemusnahan_submit.jsp?action=update'
		,	destroy		: 'data/metodapemusnahan_submit.jsp?action=destroy'
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
