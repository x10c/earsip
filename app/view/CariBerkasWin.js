Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.CariBerkasWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.cariberkaswin'
,	itemId		: 'cariberkaswin'
,	title		: 'Cari berkas'
,	closable	: true
,	autoHeight	: true
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'cariberkas_form'
	,	url			: 'data/cariberkas.jsp'
	,	plain		: false
	,	autoScroll	: true
	,	border		: 0
	,	bodyPadding	: 5
	,	layout		: 'anchor'
	,	width		: 400
	,	defaultType	: 'textfield'
	,	defaults	: {
			anchor			: '100%'
		,	selectOnFocus	: true
		,	labelAlign		: 'right'
		,	labelWidth		: 160
		}
	,	items		: [{
			fieldLabel		: 'Cari teks'
		,	itemId			: 'text'
		,	name			: 'text'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Nama'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Tanggal dibuat setelah'
		,	xtype			: 'datefield'
		,	itemId			: 'tgl_dibuat_setelah'
		,	name			: 'tgl_dibuat_setelah'
		,	format			: 'Y-m-d'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Tanggal dibuat sebelum'
		,	xtype			: 'datefield'
		,	itemId			: 'tgl_dibuat_sebelum'
		,	name			: 'tgl_dibuat_sebelum'
		,	format			: 'Y-m-d'
		,	emptyText		: '-'
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Klasifikasi'
		,	itemId			: 'berkas_klas_id'
		,	name			: 'berkas_klas_id'
		,	store			: Ext.getStore ('KlasArsip')
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	triggerAction	: 'all'
		,	emptyText		: '-'
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Tipe'
		,	store			: Ext.getStore ('TipeArsip')
		,	itemId			: 'berkas_tipe_id'
		,	name			: 'berkas_tipe_id'
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	triggerAction	: 'all'
		,	emptyText		: '-'
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
		}]
	,	buttons		: [{
			text			: 'Cari'
		,	itemId			: 'cari'
		,	formBind		: true
		}]
	}]
});
