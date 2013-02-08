Ext.define ('Earsip.model.Pemindahan', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	, 	'unit_kerja_id'
	, 	'kode'
	, 	'tgl'
	, 	'status'
	, 	'nama_petugas'
	,	'pj_unit_kerja'
	,	'pj_unit_arsip'
	]
});

Ext.define ('Earsip.store.Pemindahan', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Pemindahan'
,	model		: 'Earsip.model.Pemindahan'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/pemindahan.jsp'
		,	create		: 'data/pemindahan_submit.jsp?action=create'
		,	update		: 'data/pemindahan_submit.jsp?action=update'
		,	destroy		: 'data/pemindahan_submit.jsp?action=destroy'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	,	writer		: {
			type		: 'json'
		}
	}

});
