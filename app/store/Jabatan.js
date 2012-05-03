Ext.define ('Earsip.store.Jabatan', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.Jabatan'
,	autoLoad	: false
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/jabatan.jsp'
		,	create		: 'data/jabatan_submit.jsp?action=create'
		,	update		: 'data/jabatan_submit.jsp?action=update'
		,	destro		: 'data/jabatan_submit.jsp?action=destroy'
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
