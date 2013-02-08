Ext.define ('Earsip.model.PemindahanRinci', {
	extend		:'Ext.data.Model'
,	idProperty	:'pemindahan_id'
,	fields		:[
		'pemindahan_id'
	,	'berkas_id'
	,	'nama'
	,	'arsip_status_id'
	,	'jra_aktif'
	,	'jra_inaktif'
	,	'kode_folder'
	,	'kode_rak'
	,	'kode_box'
	]
});

Ext.define ('Earsip.store.PemindahanRinci', {
	extend		: 'Ext.data.Store'
,	storeId		: 'PemindahanRinci'
,	model		: 'Earsip.model.PemindahanRinci'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/pemindahanrinci.jsp'
		,	create		: 'data/pemindahanrinci_submit.jsp?action=create'
		,	update		: 'data/pemindahanrinci_submit.jsp?action=update'
		,	destroy		: 'data/pemindahanrinci_submit.jsp?action=destroy'
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
