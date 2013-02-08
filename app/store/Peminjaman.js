Ext.define ('Earsip.model.Peminjaman', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
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
});

Ext.define ('Earsip.store.Peminjaman', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Peminjaman'
,	model		: 'Earsip.model.Peminjaman'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/peminjaman.jsp'
		,	create		: 'data/peminjaman_submit.jsp?action=create'
		,	update		: 'data/peminjaman_submit.jsp?action=update'
		,	destroy		: 'data/peminjaman_submit.jsp?action=destroy'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
