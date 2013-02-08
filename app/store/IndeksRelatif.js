Ext.define ('Earsip.model.IndeksRelatif', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'berkas_klas_id'
	,	'keterangan'
	]
});

Ext.define ('Earsip.store.IndeksRelatif', {
	extend	: 'Ext.data.Store'
,	model	: 'Earsip.model.IndeksRelatif'
,	storeId	: 'IndeksRelatif'
,	autoLoad: true
,	proxy	: {
		type	: 'ajax'
	,	api		: {
			read	: 'data/ir.jsp'
		,	create	: 'data/ir_submit.jsp?action=create'
		,	update	: 'data/ir_submit.jsp?action=update'
		,	destroy	: 'data/ir_submit.jsp?action=destroy'
		}
	,	reader	: {
			type	: 'json'
		,	root	: 'data'
		}
	,	writer	: {
			type	: 'json'
		}
	}
});
