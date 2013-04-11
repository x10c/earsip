Ext.define ('Earsip.model.BerkasInAktif', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'pid'
	,	'tipe_file'
	,	'mime'
	,	'sha'
	,	'pegawai_id'
	,	'unit_kerja_id'
	,	'berkas_klas_id'
	,	'berkas_tipe_id'
	,	'nama'
	,	'tgl_unggah'
	,	'tgl_dibuat'
	,	'nomor'
	,	'pembuat'
	,	'judul'
	,	'masalah'
	,	'jra_aktif'
	,	'jra_inaktif'
	,	'status'
	,	'status_hapus'
	,	'akses_berbagi_id'
	,	'n_output_images'
	]
});

Ext.define ('Earsip.store.BerkasInAktif', {
	extend		: 'Ext.data.Store'
,	storeId		: 'BerkasInAktif'
,	model		: 'Earsip.model.BerkasInAktif'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/berkasinaktif.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
