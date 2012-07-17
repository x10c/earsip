Ext.define('Earsip.view.RefIndeksRelatifWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.indeks_relatif_win'
,	title		: 'Indeks Relatif'
,	itemId		: 'indeks_relatif_win'
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
	,	url			: 'data/ir_submit.jsp'
	,	plain		: true
	,	frame		: true
	,	border		: 0
	,	bodyPadding	: 5
	,	defaults	: {
			xtype			: 'textfield'
		,	anchor			: '100%'
		,	selectOnFocus	: true
		,	labelAlign		: 'right'
		,	labelWidth		: 140
		}
	,	items		: [{
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Klasifikasi Berkas'
		,	itemId			: 'berkas_klas_id'
		,	name			: 'berkas_klas_id'
		,	store			: 'KlasArsip'
		,	displayField	: ['nama']
		,	valueField		: 'id'
		,	editable		: false
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
