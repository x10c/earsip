Ext.define ('Earsip.store.Berkas', {
	extend		: 'Ext.data.Store'
,	storeId		: 'DirList'
,	model		: 'Earsip.model.Berkas'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/berkas.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
