Ext.define ('Earsip.store.Grup', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.Grup'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/grup.jsp'
		,	create		: 'data/grup_submit.jsp?action=create'
		,	update		: 'data/grup_submit.jsp?action=update'
		,	destroy		: 'data/grup_submit.jsp?action=destroy'
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
