Ext.define ('Earsip.model.Pemindahan', {
	extend		: 'Ext.data.Model'
,	fields		: [ 
		'id'
	, 	'unit_kerja_id'
	, 	'kode'
	, 	'tgl'
	, 	'status'
	, 	'nama_petugas'
	,	'pj_unit_kerja'
	,	'pj_unit_arsip']
,	idProperty	: 'id'
});
