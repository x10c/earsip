Ext.define ('Earsip.model.Arsip.Folder', {
	extend		:'Ext.data.Model'
,	idProperty	:'kode_folder'
,	fields		:[
		'type'
	,	'kode_folder'
	]
});

Ext.define ('Earsip.store.Arsip.Folder', {
	extend		:'Ext.data.Store'
,	model		:'Earsip.model.Arsip.Folder'
,	storeId		:'Folder'
,	autoLoad	:false
,	autoSync	:false
,	proxy		:{
		type		:'ajax'
	,	url			:'data/Arsip/Folder.jsp'
	,	reader		:{
			type		:'json'
		,	root		:'data'
		}
	}
});
