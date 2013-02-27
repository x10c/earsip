Ext.define ('Earsip.model.BerkasTree', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'pid'
	,	'text'
	,	'children'
	]
});

Ext.define ('Earsip.store.BerkasTree', {
	extend		:'Ext.data.TreeStore'
,	storeId		:'BerkasTree'
,	model		:'Earsip.model.BerkasTree'
,	autoSync	:false
,	autoLoad	:false
,	root		:{
		expanded	:true
	}
,	proxy		:{
		type		:'ajax'
	,	api			:{
			read		:'data/berkas_tree.jsp'
		}
	,	reader		:{
			type		:'json'
		}
	}
});
