Ext.define('Earsip.view.PemusnahanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pemusnahan_win'
,	title		: 'Pemusnahan'
,	itemId		: 'pemusnahan_win'
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
	,	url			: 'data/pemusnahan_submit.jsp'
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
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Metoda Pemusnahan'
		,	itemId			: 'metoda_id'
		,	name			: 'metoda_id'
		,	store			: 'MetodaPemusnahan'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	allowBlank		: false
		},{
			fieldLabel		: 'Nama Petugas'
		,	itemId			: 'nama_petugas'
		,	name			: 'nama_petugas'
		,	allowBlank		: false
		},{
			xtype			: 'datefield'
		,	fieldLabel		: 'Tanggal Pemusnahan'
		,	itemId			: 'tgl'
		,	name			: 'tgl'
		,	format			: 'Y-m-d'
		,	allowblank		: false
		,	editable		: false
		,	value			: new Date ()
		},{
			fieldLabel		: 'PJ. Unit Kerja'
		,	itemId			: 'pj_unit_kerja'
		,	name			: 'pj_unit_kerja'
		},{
			fieldLabel		: 'PJ. Pusat Berkas/Arsip'
		,	itemId			: 'pj_berkas_arsip'
		,	name			: 'pj_berkas_arsip'
	
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