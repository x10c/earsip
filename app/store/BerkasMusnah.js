Ext.define ('Earsip.store.BerkasMusnah', {
	extend		: 'Ext.data.Store'
,	model		: 'Earsip.model.BerkasMusnah'
,	storeId		: 'BerkasMusnah'
,	autoSync	: false
,	autoLoad	: false
,	proxy		: {
		type		: 'ajax'
	,	id			: 'berkasmusnah'
	,	api			: {
			read		: 'data/berkasmusnah.jsp'
		}
	,	reader		: {
			type		: 'json'
		,	root		: 'data'
		}
	}
});
