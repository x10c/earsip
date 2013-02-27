Ext.define ('Earsip.model.Arsip.Rak', {
	extend		:'Ext.data.Model'
,	idProperty	:'kode_rak'
,	fields		:[
		'type'
	,	'kode_rak'
	]
});

Ext.define ('Earsip.store.Arsip.Rak', {
	extend		:'Ext.data.Store'
,	model		:'Earsip.model.Arsip.Rak'
,	storeId		:'Rak'
,	autoLoad	:false
,	autoSync	:false
,	proxy		:{
		type		:'ajax'
	,	url			:'data/Arsip/Rak.jsp'
	,	reader		:{
			type		:'json'
		,	root		:'data'
		}
	}
});
