Ext.define ('Earsip.model.Arsip.UnitKerja', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'kode'
	,	'nama'
	,	'nama_pimpinan'
	,	'keterangan'
	,	'urutan'
	]
});

Ext.define ('Earsip.store.Arsip.UnitKerja', {
	extend		: 'Ext.data.Store'
,	storeId		: 'ArsipUnitKerja'
,	model		: 'Earsip.model.Arsip.UnitKerja'
,	autoLoad	: false
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/Arsip/UnitKerja.jsp'
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
