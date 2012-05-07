Ext.define ('Earsip.store.IndeksRelatif', {
	extend	: 'Ext.data.Store'
,	model	: 'Earsip.model.IndeksRelatif'
,	storeId	: 'IndeksRelatif'
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
