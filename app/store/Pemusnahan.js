Ext.define ('Earsip.model.Pemusnahan', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'metoda_id'
	,	'nama_petugas'
	,	'tgl'
	,	'pj_unit_kerja'
	,	'pj_berkas_arsip'
	]
});

Ext.define ('Earsip.store.Pemusnahan', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Pemusnahan'
,	model		: 'Earsip.model.Pemusnahan'
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	id			: 'pemusnahan'
	,	api			: {
			read		: 'data/pemusnahan.jsp'
		,	create		: 'data/pemusnahan_submit.jsp?action=create'
		,	update		: 'data/pemusnahan_submit.jsp?action=update'
		,	destroy		: 'data/pemusnahan_submit.jsp?action=destroy'
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
