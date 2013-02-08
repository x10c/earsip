Ext.define ('Earsip.model.User', {
	extend		:'Ext.data.Model'
,	idProperty	:'user_id'
,	fields		:[
		'user_id'
	,	'grup_id'
	,	'user_nip'
	,	'user_name'
	]
});

Ext.define ('Earsip.store.User', {
	extend		: 'Ext.data.Store'
,	storeId		: 'User'
,	model		: 'Earsip.model.User'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/user.jsp'
		,	create		: 'data/user_submit.jsp?action=create'
		,	update		: 'data/user_submit.jsp?action=update'
		,	destroy		: 'data/user_submit.jsp?action=destroy'
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
