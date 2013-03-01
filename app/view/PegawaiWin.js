Ext.require ([
	'Earsip.store.UnitKerja'
,	'Earsip.store.Jabatan'
,	'Earsip.store.Grup'
]);

Ext.define ('Earsip.view.PegawaiWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pegawai_win'
,	itemId		: 'pegawai_win'
,	title		: 'Data Pegawai'
,	width		: 500
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/pegawai_submit.jsp'
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
			fieldLabel		: 'NIP'
		,	itemId			: 'nip'
		,	name			: 'nip'
		,	allowBlank		: false
		},{
			fieldLabel		: 'Nama Pegawai'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	allowBlank		: false
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
			xtype			: 'combo'
		,	fieldLabel		: 'Jabatan'
		,	itemId			: 'jabatan_id'
		,	name			: 'jabatan_id'
		,	store			: 'Jabatan'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	allowBlank		: false
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Grup'
		,	itemId			: 'grup_id'
		,	name			: 'grup_id'
		,	store			: 'Grup'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	allowBlank		: false
		},{
			fieldLabel		: 'Password'
		,	itemId			: 'password'
		,	name			: 'password'
		,	inputType		: 'password'
		,	allowBlank		: false
		},{
			xtype			: 'checkbox'
		,	fieldLabel		: 'Status'
		,	itemId			: 'status'
		,	name			: 'status'
		,	inputValue		: '1'
		,	uncheckedValue	: '0'
		}]
	}]
,	buttons			: [{
		text			: 'Simpan'
	,	type			: 'submit'
	,	action			: 'submit'
	,	formBind		: true
	}]
});
