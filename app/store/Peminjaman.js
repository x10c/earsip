Ext.define ('Earsip.store.Peminjaman', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Peminjaman'
,	model		: 'Earsip.model.Peminjaman'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/peminjaman.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
