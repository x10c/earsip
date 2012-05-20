Ext.define ('Earsip.store.Arsip', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.Berkas'
,	storeId		: 'Arsip'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/arsip.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
