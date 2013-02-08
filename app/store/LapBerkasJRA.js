Ext.define ('Earsip.model.LapBerkasJRA', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'tgl_dibuat'
	,	'nama'
	,	'tahun'
	,	'bulan'
	,	'hari'
	,	'jra'
	,	'lokasi'
	]
});

Ext.define ('Earsip.store.LapBerkasJRA', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.LapBerkasJRA'
,	storeId		: 'LapBerkasJRA'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/lapberkasjra.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
