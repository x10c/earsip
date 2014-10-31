Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.ArsipCariWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.arsipcariwin'
,	itemId		: 'arsipcariwin'
,	title		: 'Cari arsip'
,	closable	: true
,	autoHeight	: true
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'arsipcari_form'
	,	url			: 'data/arsip_cari.jsp'
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
			fieldLabel		: 'Nama Berkas'
		,	itemId			: 'nama'
		,	name			: 'nama'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Tanggal dibuat setelah'
		,	xtype			: 'datefield'
		,	itemId			: 'tgl_dibuat_setelah'
		,	name			: 'tgl_dibuat_setelah'
		,	emptyText		: '-'
		},{
			fieldLabel		: 'Tanggal dibuat sebelum'
		,	xtype			: 'datefield'
		,	itemId			: 'tgl_dibuat_sebelum'
		,	name			: 'tgl_dibuat_sebelum'
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
			fieldLabel		: 'Perihal'
		,	itemId			: 'judul'
		,	name			: 'judul'
		,	emptyText		: '-'
		}]
	,	buttons		: [{
			text			: 'Cari'
		,	itemId			: 'search'
		,	formBind		: true
		,	handler			: function (b)
			{
				var list		= Ext.ComponentQuery.query ("#arsiplist")[0];
				var cariform	= list.win_search.down ('form').getForm ()
				var list_store	= list.getStore ();
				var list_proxy	= list_store.getProxy ();
				var org_url		= list_proxy.url;

				list_proxy.url = 'data/arsip_cari.jsp'

				list_store.load ({
					params	: cariform.getValues ()
				});

				list_proxy.url = org_url;
			}
		}]
	}]
});
