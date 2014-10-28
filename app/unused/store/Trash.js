Ext.define ('Earsip.store.Trash', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Trash'
,	model		: 'Earsip.model.Berkas'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/trash.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
