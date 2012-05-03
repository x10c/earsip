Ext.define ('Earsip.store.Pegawai', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.Pegawai'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/pegawai.jsp'
		,	create		: 'data/pegawai_submit.jsp?action=create'
		,	update		: 'data/pegawai_submit.jsp?action=update'
		,	destroy		: 'data/pegawai_submit.jsp?action=destroy'
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
