Ext.define ('Earsip.store.PemindahanRinci', {
	extend		: 'Ext.data.Store'
,	storeId		: 'PemindahanRinci'
,	model		: 'Earsip.model.PemindahanRinci'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/pemindahanrinci.jsp'
		,	create		: 'data/pemindahanrinci_submit.jsp?action=create'
		,	update		: 'data/pemindahanrinci_submit.jsp?action=update'
		,	destroy		: 'data/pemindahanrinci_submit.jsp?action=destroy'
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
