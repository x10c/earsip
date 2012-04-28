Ext.define ('Earsip.store.DirList', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.DirList'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/dirlist.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
