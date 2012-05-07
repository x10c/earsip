Ext.define ('Earsip.store.BerkasKlasifikasi', {
	extend	: 'Ext.data.Store'
,	model	: 'Earsip.model.BerkasKlasifikasi'
,	storeId	: 'BerkasKlasifikasi'
,	proxy	: {
		type	: 'ajax'
	,	api		: {
			read		: 'data/berkas_klasifikasi.jsp'
		,	create		: 'data/berkas_klasifikasi_submit.jsp?action=create'
		,	update		: 'data/berkas_klasifikasi_submit.jsp?action=update'
		,	destroy		: 'data/berkas_klasifikasi_submit.jsp?action=destroy'
		}
	,	reader	: {
			type		: 'json'
		,	root		: 'data'
		}
	,	writer	: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
