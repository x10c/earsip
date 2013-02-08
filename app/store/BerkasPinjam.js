Ext.define ('Earsip.model.BerkasPinjam', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'nama'
	,	'nomor'
	,	'pembuat'
	,	'judul'
	,	'masalah'
	,	'jra_aktif'
	,	'jra_inaktif'
	,	'status'
	,	'status_hapus'
	,	'arsip_status_id'
	]
});

Ext.define ('Earsip.store.BerkasPinjam', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.BerkasPinjam'
,	storeId		: 'BerkasPinjam'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/berkaspinjam.jsp'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
