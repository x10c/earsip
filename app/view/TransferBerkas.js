Ext.require ([
	'Earsip.store.Pegawai'
]);

Ext.define ('Earsip.view.TransferBerkas', {
	extend		: 'Ext.Window'
,	alias		: 'widget.trans_transfer_berkas'
,	itemId		: 'trans_transfer_berkas'
,	title		: 'Transfer berkas antar pegawai'
,	closable	: true
,	autoHeight	: true
,	resizable	: false
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'transferberkas_form'
	,	url			: 'data/transfer_berkas.jsp'
	,	plain		: true
	,	border		: 0
	,	bodyPadding	: 5
	,	width		: 400
	,	defaults	: {
			labelAlign		: 'right'
		,	allowBlank		: false
		,	anchor			: '100%'
		,	forceSelection	: true
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	emptyText		: '-'
		}
	,	items		: [{
			xtype			: 'combo'
		,	itemId			: 'from_peg'
		,	name			: 'from_peg'
		,	fieldLabel		: 'Dari Pegawai'
		,	store			: Ext.create ('Earsip.store.Pegawai')
		},{
			xtype			: 'combo'
		,	itemId			: 'to_peg'
		,	name			: 'to_peg'
		,	fieldLabel		: 'Ke Pegawai'
		,	store			: Ext.create ('Earsip.store.Pegawai')
		}]
	,	buttons			: [{
			text	: 'Transfer'
		,	type	: 'submit'
		,	action	: 'submit'
		,	iconCls	: 'save'
		,	formBind: true
		}]
	}]
});
