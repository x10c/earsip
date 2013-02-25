Ext.define('Earsip.view.PemindahanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pemindahan_win'
,	title		: 'Pemindahan'
,	itemId		: 'pemindahan_win'
,	width		: 500
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'anchor'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/pemindahan_submit.jsp'
	,	plain		: true
	,	frame		: true
	,	border		: 0
	,	bodyPadding	: 5
	,	layout		: 'anchor'
	,	defaults	: {
			xtype		: 'textfield'
		,	anchor		: '100%'
		,	labelAlign	: 'right'
		}
	,	items		: [{
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		},{
			hidden			: true
		,	itemId			: 'unit_kerja_id'
		,	name			: 'unit_kerja_id'
		},{
			fieldLabel		: 'No Reg/ No Surat'
		,	itemId			: 'kode'
		,	name			: 'kode'
		,	allowBlank		: false
		},{
			xtype			: 'datefield'
		,	fieldLabel		: 'Tanggal'
		,	itemId			: 'tgl'
		,	name			: 'tgl'
		,	allowBlank		: false
		,	editable		: false
		,	value			: new Date ()
		},{
			fieldLabel		: 'Nama Petugas'
		,	itemId			: 'nama_petugas'
		,	name			: 'nama_petugas'
		,	hidden			: true
		},{
			fieldLabel		: 'Penanggung Jawab Unit kerja'
		,	itemId			: 'pj_unit_kerja'
		,	name			: 'pj_unit_kerja'
		,	allowBlank		: false
		},{
			fieldLabel		: 'Penanggung Jawab Unit Arsip'
		,	itemId			: 'pj_unit_arsip'
		,	name			: 'pj_unit_arsip'
		, 	hidden			: true
		},{
			fieldLabel		: 'Status'
		,	itemId			: 'status'
		,	name			: 'status'
		,	hidden			: true
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
