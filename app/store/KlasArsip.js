Ext.define ('Earsip.model.KlasArsip', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'unit_kerja_id'
	,	'kode'
	,	'nama'
	,	'keterangan'
	,	'jra_aktif'
	,	'jra_inaktif'
	]
});

Ext.define ('Earsip.store.KlasArsip', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.KlasArsip'
,	storeId		: 'KlasArsip'
,	groupField	: 'unit_kerja_id'
,	sorters		: ['kode']
,	autoSync	: false
,	autoLoad	: true
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/klasarsip.jsp'
		,	create		: 'data/klasarsip_submit.jsp?action=create'
		,	update		: 'data/klasarsip_submit.jsp?action=update'
		,	destroy		: 'data/klasarsip_submit.jsp?action=destroy'
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
