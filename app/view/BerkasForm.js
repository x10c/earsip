Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.BerkasForm', {
	extend		: 'Ext.form.Panel'
,	alias		: 'widget.berkasform'
,	plain		: true
,	frame		: true
,	autoScroll	: true
,	border		: 0
,	bodyPadding	: 5
,	layout		: 'anchor'
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
		itemId			:'tipe_file'
	,	name			:'tipe_file'
	,	hidden			:true
	},{
		fieldLabel		: '* Nama'
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
		xtype 	: 'container'
	,	layout	: 'hbox'
	,	margin	: '0 0 5 0'
	,	items	: [{
			xtype			: 'combo'
		,	fieldLabel		: 'Klasifikasi'
		,	labelAlign		: 'right'
		,	itemId			: 'berkas_klas_id'
		,	name			: 'berkas_klas_id'
		,	store			: Ext.getStore ('KlasArsip')
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	forceSelection	:true
		,	editable		:false
		,	triggerAction	: 'all'
		,	flex			: 1
		,	emptyText		:'-'
		},{
			xtype			: 'button'
		,	text			: 'Cari Indeks Relatif'
		,	itemId			: 'indeks_relatif'
		,	iconCls			: 'search'
		,	width			: 140
		,	margin			: '0 0 0 10'
		}]
	},{
		xtype			: 'combo'
	,	fieldLabel		: 'Tipe'
	,	store			: Ext.getStore ('TipeArsip')
	,	itemId			: 'berkas_tipe_id'
	,	name			: 'berkas_tipe_id'
	,	displayField	: 'nama'
	,	valueField		: 'id'
	,	forceSelection	:true
	,	editable		:false
	,	triggerAction	: 'all'
	,	emptyText		:'-'
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
	,	fieldLabel		: 'JRA Aktif'
	,	itemId			: 'jra_aktif'
	,	name			: 'jra_aktif'
	,	minValue		: 1
	},{
		xtype			: 'numberfield'
	,	fieldLabel		: 'JRA Inaktif'
	,	itemId			: 'jra_inaktif'
	,	name			: 'jra_inaktif'
	,	minValue		: 1
	},{
		xtype			: 'numberfield'
	,	name			: 'status_hapus'
	,	itemId			: 'status_hapus'
	,	hidden			: true
	}]
});
