Ext.define ('Earsip.model.PeminjamanRinci', {
	extend		:'Ext.data.Model'
,	idProperty	:'peminjaman_id'
,	fields		:[
		'peminjaman_id'
	,	'berkas_id'
	]
});

Ext.define ('Earsip.store.PeminjamanRinci', {
	extend		: 'Ext.data.Store'
,	storeId		: 'PeminjamanRinci'
,	model		: 'Earsip.model.PeminjamanRinci'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/peminjamanrinci.jsp'
		,	create		: 'data/peminjamanrinci_submit.jsp?action=create'
		,	destroy		: 'data/peminjamanrinci_submit.jsp?action=destroy'
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
