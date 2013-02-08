Ext.define ('Earsip.model.LapBerkasMusnah', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'nama'
	,	'kode'
	,	'judul'
	,	'tgl'
	,	'keterangan'
	]
});

Ext.define ('Earsip.store.LapBerkasMusnah', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.LapBerkasMusnah'
,	storeId		: 'LapBerkasMusnah'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/lapberkasmusnah.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
