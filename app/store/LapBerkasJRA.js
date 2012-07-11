Ext.define ('Earsip.store.LapBerkasJRA', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.LapBerkasJRA'
,	storeId		: 'LapBerkasJRA'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	url			: 'data/lapberkasjra.jsp'
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});