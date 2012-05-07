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
			xtype			: 'combo'
		,	fieldLabel		: 'Unit Kerja'
		,	itemId			: 'unit_kerja_id'
		,	name			: 'unit_kerja_id'
		,	store			: 'UnitKerja'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	allowBlank		: false
		},{
			fieldLabel		: 'Kode'
		,	itemId			: 'kode'
		,	name			: 'kode'
		,	allowBlank		: false
		},{
			fieldLabel		: 'Nama'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	allowBlank		: false
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
	,	type			: 'submit'
	,	action			: 'submit'
	,	iconCls			: 'save'
	,	formBind		: true
	}]

});