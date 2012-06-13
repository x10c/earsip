Ext.define ('Earsip.model.BerkasMusnah', {
	extend		: 'Ext.data.Model'
,	fields		: [
		'id'
	,	'nama'
	,	'nomor'
	,	'pembuat'
	,	'judul'
	,	'masalah'
	,	'jra'
	,	'status'
	,	'status_hapus'
	,	'arsip_status_id'
	]
,	idProperty	: 'id'
,	hasMany	:	'PemusnahanRinci'
});