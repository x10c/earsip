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
		itemId			: 'berkas_id'
	,	name			: 'berkas_id'
	,	hidden			: true
	},{
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
		fieldLabel		: '* Nama Berkas'
	,	itemId			: 'nama'
	,	name			: 'nama'
	,	allowBlank		: false
	},{
		xtype			: 'datefield'
	,	fieldLabel		: 'Tanggal'
	,	itemId			: 'tgl_dibuat'
	,	name			: 'tgl_dibuat'
	},{
		xtype			: 'combo'
	,	fieldLabel		: 'Klasifikasi'
	,	labelAlign		: 'right'
	,	itemId			: 'berkas_klas_id'
	,	name			: 'berkas_klas_id'
	,	store			: Ext.getStore ('KlasArsip')
	,	displayField	: 'nama_alt'
	,	valueField		: 'id'
	,	forceSelection	:true
	,	flex			: 1
	,	emptyText		:'-'
	,	typeAhead		:true
	,	editable		: false
	},{
		xtype			: 'button'
	,	text			: 'Cari Indeks Relatif'
	,	itemId			: 'indeks_relatif'
	,	iconCls			: 'search'
	,	width			: 140
	,	margin			: '0 0 10 0'
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
		fieldLabel		: 'Perihal'
	,	itemId			: 'judul'
	,	name			: 'judul'
	,	emptyText		: '-'
	},{
		xtype			: 'textarea'
	,	fieldLabel		: 'Keterangan'
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

,	set_disabled	:function (s)
	{
		this.down ('#nama').setDisabled (s);
		this.down ('#tgl_dibuat').setDisabled (s);
		this.down ('#berkas_klas_id').setDisabled (s);
		this.down ('#indeks_relatif').setDisabled (s);
		this.down ('#berkas_tipe_id').setDisabled (s);
		this.down ('#nomor').setDisabled (s);
		this.down ('#pembuat').setDisabled (s);
		this.down ('#judul').setDisabled (s);
		this.down ('#masalah').setDisabled (s);
		this.down ('#jra_aktif').setDisabled (s);
		this.down ('#jra_inaktif').setDisabled (s);

		this.down ('#save').setDisabled (s);
		this.down ('#mkdir').setDisabled (s);
	}
});
