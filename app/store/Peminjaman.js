Ext.define ('Earsip.store.Peminjaman', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Peminjaman'
,	model		: 'Earsip.model.Peminjaman'
,	autoSync	: false
,	autoload	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/peminjaman.jsp'
		,	create		: 'data/peminjaman_submit.jsp?action=create'
		,	update		: 'data/peminjaman_submit.jsp?action=update'
		,	destroy		: 'data/peminjaman_submit.jsp?action=destroy'
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
