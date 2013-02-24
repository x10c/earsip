Ext.define ('Earsip.model.ArsipTree', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'pid'
	,	'text'
	,	'unit_kerja_id'
	,	'kode_rak'
	,	'kode_box'
	,	'kode_folder'
	,	'type'
	,	'leaf'
	,	'children'
	,	'depth'
	,	'index'
	]
});

Ext.define ('Earsip.store.ArsipTree', {
	extend		:'Ext.data.TreeStore'
,	storeId		:'ArsipTree'
,	model		:'Earsip.model.ArsipTree'
,	autoSync	:false
,	autoLoad	:false
,	root		:{
		expanded	:true
	}
,	proxy		:{
		type		:'ajax'
	,	api			:{
			read		:'data/arsip_tree.jsp'
		}
	,	reader		:{
			type		:'json'
		}
	}
});
