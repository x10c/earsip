Ext.define('Earsip.view.KlasArsipWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.klas_arsip_win'
,	title		: 'Klasifikasi Arsip'
,	itemId		: 'klas_arsip_win'
,   width		: 500
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/klasarsip_submit.jsp'
	,	plain		: true
	,	frame		: true
	,	border		: 0
	,	bodyPadding	: 5
	,	defaults	: {
			xtype			: 'textfield'
		,	anchor			: '100%'
		,	selectOnFocus	: true
		,	labelAlign		: 'right'
		}
	,	items		: [{
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		},{
			fieldLabel		: 'Kode'
		,	itemId			: 'kode'
		,	name			: 'kode'
		,	allowBlank		: false
		},{
			fieldLabel		: 'Nama Klasifikasi'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	allowBlank		: false
		},{
			xtype			: 'numberfield'
		,	fieldLabel		: 'JRA Aktif'
		,	itemId			: 'jra_aktif'
		,	name			: 'jra_aktif'
		,	minValue		: 1
		,	allowBlank		: false
		},{
			xtype			: 'numberfield'
		,	fieldLabel		: 'JRA Inaktif'
		,	itemId			: 'jra_inaktif'
		,	name			: 'jra_inaktif'
		,	minValue		: 1
		,	allowBlank		:false
		},{
			xtype			: 'textarea'
		,	fieldLabel		: 'Keterangan'
		,	itemId			: 'keterangan'
		,	name			: 'keterangan'
		,	allowBlank		: false
		}]
	}]
,	buttons			: [{
		text			: 'Simpan'
	,	itemId			: "save"
	,	type			: 'submit'
	,	action			: 'submit'
	,	iconCls			: 'save'
	,	formBind		: true
	}]

});
