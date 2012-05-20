Ext.define('Earsip.view.PemindahanRinciWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pemindahanrinci_win'
,	title		: 'Tambah Berkas'
,	itemId		: 'pemindahanrinci_win'
,   width		: 500
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'anchor'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/pemindahanrinci_submit.jsp'
	,	plain		: true
	,	frame		: true
	,	border		: 0
	,	bodyPadding	: 5	
	,	layout		: 'anchor'
	,	defaults	: {
			xtype	: 'textfield'	
		,	anchor	: '100%'
	}
	,	items		: [{	
			itemId			: 'pemindahan_id'
		,	name			: 'pemindahan_id'
		,	allowBlank		: false
		, 	hidden			: true
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Berkas'
		,	itemId			: 'berkas_id'
		,	name			: 'berkas_id'
		,	store			: 'BerkasPindah'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	allowBlank		: false
		
		}]
	}]
,	buttons			: [{
		text			: 'Simpan'
	,	type			: 'submit'
	,	action			: 'submit'
	,	iconCls			: 'save'
	,	formBind		: true
	}]
});