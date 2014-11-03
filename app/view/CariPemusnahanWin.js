Ext.define ('Earsip.view.CariPemusnahanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.caripemusnahanwin'
,	itemId		: 'caripemusnahanwin'
,	id			: 'caripemusnahanwin'
,	title		: 'Cari Pemusnahan'
,	closable	: true
,	autoHeight	: true
,	modal		: true
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'caripemusnahan_form'
	,	url			: 'data/caripemusnahan.jsp'
	,	plain		: false
	,	autoScroll	: true
	,	frame		: true
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
			itemId			: 'text'
		,	name			: 'text'
		,	emptyText		: 'Cari teks'
		},{
			xtype			: 'combo'
		,	itemId			: 'metoda_id'
		,	name			: 'metoda_id'
		,	store			: Ext.getStore ('MetodaPemusnahan')
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	triggerAction	: 'all'
		,	emptyText		: 'Metode Pemusnahan'
		},{
			itemId			: 'nama_petugas'
		,	name			: 'nama_petugas'
		,	emptyText		: 'Nama Petugas'
		},{	
			xtype			: 'datefield'
		,	columnWidth		: .5
		,	itemId			: 'tgl_setelah'
		,	name			: 'tgl_setelah'
		,	emptyText		: 'Setelah Tanggal'
		},{
			xtype			: 'datefield'
		,	columnWidth		: .5
		,	itemId			: 'tgl_sebelum'
		,	name			: 'tgl_sebelum'
		,	emptyText		: 'Sebelum Tanggal'
		},{
			itemId			: 'pj_unit_kerja'
		,	name			: 'pj_unit_kerja'
		,	emptyText		: 'Penanggung Jawab Unit Kerja'
		},{
			itemId			: 'pj_berkas_arsip'
		,	name			: 'pj_berkas_arsip'
		,	emptyText		: 'Penanggung Jawab Pusat Berkas/Arsip'
		}]
	,	buttons		: [{
			text			: 'Cari'
		,	itemId			: 'cari'
		,	formBind		: true
		}]
	}]
});
