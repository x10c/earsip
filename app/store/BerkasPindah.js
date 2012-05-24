Ext.define ('Earsip.store.BerkasPindah', {
	extend		: 'Ext.data.Store'
,	storeId		: 'BerkasPindah'
,	model		: 'Earsip.model.BerkasPindah'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/berkaspindah.jsp'
		,	create		: 'data/berkaspindah_submit.jsp?action=create'
		,	update		: 'data/berkaspindah_submit.jsp?action=update'
		,	destroy		: 'data/berkaspindah_submit.jsp?action=destroy'
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
