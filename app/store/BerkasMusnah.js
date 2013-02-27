Ext.define ('Earsip.model.BerkasMusnah', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	hasMany		:'PemusnahanRinci'
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

Ext.define ('Earsip.store.BerkasMusnah', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.BerkasMusnah'
,	storeId		: 'BerkasMusnah'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	id			: 'berkasmusnah'
	,	api			: {
			read		: 'data/berkasmusnah.jsp'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
