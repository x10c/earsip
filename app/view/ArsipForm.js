Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.ArsipForm', {
	extend		: 'Ext.form.Panel'
,	alias		: 'widget.arsipform'
,	itemId		: 'arsip_form'
,	url			: 'data/arsip_submit.jsp'
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
			,	fieldLabel		:'* Nama Berkas'
			,	allowBlank		:false
			},{
				xtype			: 'datefield'
			,	fieldLabel		: 'Tanggal dibuat'
			,	itemId			: 'tgl_dibuat'
			,	name			: 'tgl_dibuat'
			},{
				xtype			: 'combo'
			,	fieldLabel		: '* Klasifikasi'
			,	itemId			: 'berkas_klas_id'
			,	name			: 'berkas_klas_id'
			,	store			: Ext.getStore ('KlasArsip')
			,	displayField	: 'nama_alt'
			,	valueField		: 'id'
			,	triggerAction	: 'all'
			,	allowBlank		:false
			},{
				xtype			: 'combo'
			,	fieldLabel		: '* Tipe'
			,	store			: Ext.getStore ('TipeArsip')
			,	itemId			: 'berkas_tipe_id'
			,	name			: 'berkas_tipe_id'
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	triggerAction	: 'all'
			,	allowBlank		:false
			},{
				fieldLabel		:'Unit Kerja'
			,	xtype			:'combo'
			,	store			:Ext.getStore ('UnitKerja')
			,	itemId			:'unit_kerja_id'
			,	name			:'unit_kerja_id'
			,	displayField	:'nama'
			,	valueField		:'id'
			,	triggerAction	:'all'
			,	disabled		:true
			},{
				fieldLabel		: '* Kode Rak'
			,	itemId			: 'kode_rak'
			,	name			: 'kode_rak'
			,	allowBlank		:false
			},{
				fieldLabel		: '* Kode Box'
			,	itemId			: 'kode_box'
			,	name			: 'kode_box'
			,	allowBlank		:false
			},{
				fieldLabel		: '* Kode Folder'
			,	itemId			: 'kode_folder'
			,	name			: 'kode_folder'
			,	allowBlank		:false
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
				xtype			:'numberfield'
			,	fieldLabel		:'JRA Inaktif'
			,	name			:'jra_inaktif'
			,	itemId			:'jra_inaktif'
			}]
		}]
	}]
,	buttons		: [{
		text		:'Arsip Baru'
	,	itemId		:'arsip_baru'
	,	iconCls		:'add'
	,	tooltip		:'Isi form di atas, dan klik tombol ini untuk membuat arsip baru.'
	,	disabled	:true
	,	handler		:function (b)
		{
			b.up ('#mas_arsip').arsip_baru_onclick ();
		}
	},'-','->','-',{
		text		: 'Simpan'
	,	itemId		: 'save'
	,	iconCls		: 'save'
	,	disabled	: true
	}]

,	initComponent	:function (opt)
	{
		this.callParent (opt || arguments);

		var fuk = this.down ('#unit_kerja_id');

		if (1 == is_pusatarsip) {
			fuk.setDisabled (false);
		}
	}

,	listeners	:{
		validitychange	:function (f, valid, e)
		{
			var arsip_baru	= this.down ('#arsip_baru');
			var save		= this.down ('#save');

			s = !(valid && (is_pusatarsip == 1));

			arsip_baru.setDisabled (s);
			save.setDisabled (s);
		}
	}
});
