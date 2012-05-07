Ext.define ('Earsip.store.BerkasTipe', {
	extend	: 'Ext.data.Store'
,	model	: 'Earsip.model.BerkasTipe'
,	storeId	: 'BerkasTipe'
,	autoSync: false
,	autoLoad: false
,	proxy	: {
		type	: 'ajax'
	,	api		: {
			read	: 'data/berkas_tipe.jsp'
		,	create	: 'data/berkas_tipe_submit.jsp?action=create'
		,	update	: 'data/berkas_tipe_submit.jsp?action=update'
		,	destroy	: 'data/berkas_tipe_submit.jsp?action=destroy'
		}
	,	reader	: {
			type	: 'json'
		,	root	: 'data'
		}
	,	write	: {
			type	: 'json'
		}
	}
});
