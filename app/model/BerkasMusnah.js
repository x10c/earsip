Ext.define ('Earsip.model.BerkasMusnah', {
	extend		: 'Ext.data.Model'
,	fields		: [
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
,	idProperty	: 'id'
,	hasMany	:	'PemusnahanRinci'
});
