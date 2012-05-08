Ext.define ('Earsip.store.UnitKerja', {
	extend		: 'Ext.data.Store'
,	storeId		: 'UnitKerja'
,	model		: 'Earsip.model.UnitKerja'
,	autoLoad	: false
,	autoSync	: false
,	proxy		: {
		type		: 'ajax'
	,	api			: {
			read		: 'data/unitkerja.jsp'
		,	create		: 'data/unitkerja_submit.jsp?action=create'
		,	update		: 'data/unitkerja_submit.jsp?action=update'
		,	destroy		: 'data/unitkerja_submit.jsp?action=destroy'
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
