Ext.define ('Earsip.store.MenuAccess', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.MenuAccess'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/menuaccess.jsp'
		,	create		: 'data/menuaccess_submit.jsp?action=create'
		,	update		: 'data/menuaccess_submit.jsp?action=update'
		,	destroy		: 'data/menuaccess_submit.jsp?action=destory'
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
