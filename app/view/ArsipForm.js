Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.ArsipForm', {
	extend		: 'Ext.form.Panel'
,	alias		: 'widget.arsipform'
,	plain		: true
,	frame		: true
,	autoScroll	: true
,	border		: 0
,	bodyPadding	: 5
,	layout		: 'anchor'
,	items		: [{
		xtype		: 'container'
	,	anchor		: '100%'
	,	layout		: 'hbox'
	,	items		: [{
			xtype			: 'container'
		,	flex			: 1
		,	layout			: 'anchor'
		,	defaults		: {
				xtype			: 'textfield'
			,	anchor			: '100%'
			,	selectOnFocus	: true
			,	labelAlign		: 'right'
			,	editable		: false
			}
		,	items			: [{
				itemId			: 'id'
			,	name			: 'id'
			,	hidden			: true
			},{
				itemId			: 'pid'
			,	name			: 'pid'
			,	hidden			: true
			},{
				itemId			: 'nama'
			,	name			: 'nama'
			,	hidden			: true
			},{
				xtype			: 'datefield'
			,	fieldLabel		: 'Tanggal dibuat'
			,	itemId			: 'tgl_dibuat'
			,	name			: 'tgl_dibuat'
			,	format			: 'Y-m-d'
			},{
				xtype			: 'combo'
			,	fieldLabel		: 'Klasifikasi'
			,	itemId			: 'berkas_klas_id'
			,	name			: 'berkas_klas_id'
			,	store			: Ext.getStore ('KlasArsip')
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	editable		: false
			,	triggerAction	: 'all'
			},{
				xtype			: 'combo'
			,	fieldLabel		: 'Tipe'
			,	store			: Ext.getStore ('TipeArsip')
			,	itemId			: 'berkas_tipe_id'
			,	name			: 'berkas_tipe_id'
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	editable		: false
			,	triggerAction	: 'all'
			},{
				fieldLabel		: 'Kode Rak'
			,	itemId			: 'kode_rak'
			,	name			: 'kode_rak'
			,	editable		: true
			},{
				fieldLabel		: 'Kode Box'
			,	itemId			: 'kode_box'
			,	name			: 'kode_box'
			,	editable		: true
			},{
				fieldLabel		: 'Kode Folder'
			,	itemId			: 'kode_folder'
			,	name			: 'kode_folder'
			,	editable		: true
			}]
		},{
			xtype		: 'container'
		,	flex		: 1
		,	layout		: 'anchor'
		,	defaults		: {
				xtype			: 'textfield'
			,	anchor			: '100%'
			,	selectOnFocus	: true
			,	labelAlign		: 'right'
			,	editable		: false
			}
		,	items		: [{
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
			}]
		}]
	}]
});
