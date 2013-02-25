Ext.define('Earsip.view.NotifPemindahanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.notif_pemindahan_win'
,	title		: 'Notifikasi Pemindahan'
,	itemId		: 'notif_pemindahan_win'
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
			xtype			: 'combo'
		,	fieldLabel		: 'Unit Kerja'
		,	itemId			: 'unit_kerja_id'
		,	name			: 'unit_kerja_id'
		,	store			: 'UnitKerja'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	showClear		: false
        ,	disabled		: true
		},{
			fieldLabel		: 'No Reg/ No Surat'
		,	itemId			: 'kode'
		,	name			: 'kode'
		,	showClear		: false
		,	disabled		: true

		},{
			xtype			: 'datefield'
		,	fieldLabel		: 'Tanggal'
		,	itemId			: 'tgl'
		,	name			: 'tgl'
		,	allowBlank		: false
		,	showClear		: false
        ,	disabled		: true
		},{
			fieldLabel		: 'Nama Petugas'
		,	itemId			: 'nama_petugas'
		,	name			: 'nama_petugas'
		,	hidden			: true
       
		},{
			fieldLabel		: 'Penanggung Jawab Unit Berkas'
		,	itemId			: 'pj_unit_kerja'
		,	name			: 'pj_unit_kerja'
		,	showClear		: false
        ,	disabled		: true
		},{
			fieldLabel		: 'Penanggung Jawab Unit Arsip'
		,	itemId			: 'pj_unit_arsip'
		,	name			: 'pj_unit_arsip'
		
		},{
			xtype			: 'checkbox'
		,	fieldLabel		: 'Lengkap'
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
	,	iconCls			: 'save'
	,	formBind		: true
	}]
});
