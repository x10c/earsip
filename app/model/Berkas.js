Ext.define ('Earsip.model.Berkas', {
	extend		: 'Ext.data.Model'
,	fields		: [
		'id'
	,	'pid'
	,	'tipe_file'
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
	,	'jra'
	,	'status'
	]
,	idProperty	: 'id'
});