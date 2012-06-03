Ext.define ('Earsip.model.Peminjaman', {
	extend		: 'Ext.data.Model'
,	fields		: [ 
		'id'
	, 	'unit_kerja_peminjam_id'
	, 	'nama_petugas'
	, 	'nama_pimpinan_petugas'
	, 	'nama_peminjam'
	, 	'nama_pimpinan_peminjam'
	,	'tgl_pinjam'
	,	'tgl_batas_kembali'
	,	'tgl_kembali'
	,	'keterangan'
	,	'status'
]
,	idProperty	: 'id'
});
