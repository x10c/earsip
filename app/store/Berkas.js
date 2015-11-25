Ext.define ('Earsip.model.Berkas', {
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

Ext.define ('Earsip.store.Berkas', {
	extend		: 'Ext.data.Store'
,	storeId		: 'DirList'
,	model		: 'Earsip.model.Berkas'
,	autoSync	: false
,	autoLoad	: false
,	pageSize	: 50
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/berkas.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});

//# sourceURL=app/store/Berkas.js
