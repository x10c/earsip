Ext.define ('Earsip.model.Pegawai', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'unit_kerja_id'
	,	'grup_id'
	,	'jabatan_id'
	,	'nip'
	,	'nama'
	,	'status'
	]
});

Ext.define ('Earsip.store.Pegawai', {
	extend		: 'Ext.data.Store'
,	storeId		: 'Pegawai'
,	model		: 'Earsip.model.Pegawai'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/pegawai.jsp'
		,	create		: 'data/pegawai_submit.jsp?action=create'
		,	update		: 'data/pegawai_submit.jsp?action=update'
		,	destroy		: 'data/pegawai_submit.jsp?action=destroy'
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
