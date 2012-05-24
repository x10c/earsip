Ext.define('Earsip.view.NotifPemindahanRinciWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.notif_pemindahanrinci_win'
,	title		: 'Data Berkas'
,	itemId		: 'notif_pemindahanrinci_win'
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
			itemId			: 'berkas_id'
		,	name			: 'berkas_id'
		,	allowBlank		: false
		, 	hidden			: true
		},{
			fieldLabel		: 'Berkas'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	editable		: false
		,	allowBlank		: false
		},{
			itemId			: 'status'
		,	name			: 'status'
		, 	hidden			: true
		},{
			itemId			: 'arsip_status_id'
		,	name			: 'arsip_status_id'
		, 	hidden			: true
		},{
			fieldLabel		: 'Kode Folder'
		,	itemId			: 'kode_folder'
		,	name			: 'kode_folder'
		},{
			fieldLabel		: 'Kode Rak'
		,	itemId			: 'kode_rak'
		,	name			: 'kode_rak'

		},{
			fieldLabel		: 'Kode Box'
		,	itemId			: 'kode_box'
		,	name			: 'kode_box'

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