Ext.define ('Earsip.store.BerkasBerbagiList', {
	extend		: 'Ext.data.Store'
,	storeId		: 'BerkasBerbagiList'
,	model		: 'Earsip.model.Berkas'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/berkasberbagi_list.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
