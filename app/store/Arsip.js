Ext.define ('Earsip.model.Arsip', {
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
	,	'kode_box'
	,	'kode_rak'
	,	'kode_folder'
	]
});

Ext.define ('Earsip.store.Arsip', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.Arsip'
,	storeId		: 'Arsip'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/arsip.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
