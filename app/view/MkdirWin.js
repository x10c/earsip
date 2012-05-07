Ext.require ([
	'Earsip.store.BerkasKlasifikasi'
,	'Earsip.store.BerkasTipe'
]);

Ext.define ('Earsip.view.MkdirWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.mkdirwin'
,	itemId		: 'mkdirwin'
,	title		: 'Buat folder baru'
,	width		: 400
,	closable	: true
,	closeAction	: 'hide'
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	resizable	: false
,	draggable	: false
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/mkdir.jsp'
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
			itemId			: 'id'
		,	name			: 'id'
		,	hidden			: true
		},{
			itemId			: 'pid'
		,	name			: 'pid'
		,	hidden			: true
		},{
			fieldLabel		: 'Nama'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	allowBlank		: false
		},{
			xtype			: 'datefield'
		,	fieldLabel		: 'Tanggal'
		,	itemId			: 'tgl_dibuat'
		,	name			: 'tgl_dibuat'
		,	format			: 'Y-m-d'
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Klasifikasi'
		,	itemId			: 'berkas_klas_id'
		,	name			: 'berkas_klas_id'
		,	store			: 'BerkasKlasifikasi'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	triggerAction	: 'all'
		,	allowBlank		: false
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Tipe'
		,	store			: 'BerkasTipe'
		,	itemId			: 'berkas_tipe_id'
		,	name			: 'berkas_tipe_id'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	triggerAction	: 'all'
		,	allowBlank		: false
		},{
			fieldLabel		: 'Nomor'
		,	itemId			: 'nomor'
		,	name			: 'nomor'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Pembuat'
		,	itemId			: 'pembuat'
		,	name			: 'pembuat'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Judul'
		,	itemId			: 'judul'
		,	name			: 'judul'
		,	emptyText		: '-'
		},{
			xtype			: 'textarea'
		,	fieldLabel		: 'Masalah'
		,	itemId			: 'masalah'
		,	name			: 'masalah'
		,	emptyText		: '-'
		},{
			xtype			: 'numberfield'
		,	fieldLabel		: 'JRA (tahun)'
		,	itemId			: 'jra'
		,	name			: 'jra'
		,	emptyText		: '0'
		}]
	}]
,	buttons			: [{
		text			: 'Buat'
	,	type			: 'submit'
	,	action			: 'submit'
	,	formBind		: true
	}]
});
