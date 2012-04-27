Ext.define ('Earsip.store.User', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.User'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/user.jsp'
		,	create		: 'data/user_submit.jsp?action=create'
		,	update		: 'data/user_submit.jsp?action=update'
		,	destroy		: 'data/user_submit.jsp?action=destory'
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
