Ext.define ('Earsip.model.Arsip.Box', {
	extend		:'Ext.data.Model'
,	idProperty	:'kode_box'
,	fields		:[
		'type'
	,	'kode_box'
	]
});

Ext.define ('Earsip.store.Arsip.Box', {
	extend		:'Ext.data.Store'
,	model		:'Earsip.model.Arsip.Box'
,	storeId		:'Box'
,	autoLoad	:false
,	autoSync	:false
,	proxy		:{
		type		:'ajax'
	,	url			:'data/Arsip/Box.jsp'
	,	reader		:{
			type		:'json'
		,	root		:'data'
		}
	}
});
