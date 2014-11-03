var s_pil_tgl = Ext.create ('Ext.data.Store', {
	fields	: ['id','name']
,	data	: [
		{id: 0	, name:'Peminjaman'}
	,	{id: 1	, name:'Batas Pengembalian'}
	,	{id: 2	, name:'Pengembalian'}
	]
});

var s_status = Ext.create ('Ext.data.Store', {
	fields	: ['id','name']
,	data	: [
		{id: 0	, name:'Belum Kembali'}
	,	{id: 1	, name:'Sudah Kembali'}
	]
});


Ext.define ('Earsip.view.CariPeminjamanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.caripeminjamanwin'
,	itemId		: 'caripeminjamanwin'
,	id			: 'caripeminjamanwin'
,	title		: 'Cari peminjaman'
,	closable	: true
,	autoHeight	: true
,	modal		: true
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'caripeminjaman_form'
	,	url			: 'data/caripeminjaman.jsp'
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
		,	itemId			: 'unit_kerja_peminjam'
		,	name			: 'unit_kerja_peminjam'
		,	store			: Ext.getStore ('UnitKerja')
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	triggerAction	: 'all'
		,	emptyText		: 'Unit Kerja Peminjam'
		},{
			itemId			: 'nama_peminjam'
		,	name			: 'nama_peminjam'
		,	emptyText		: 'Nama Peminjam'
		},{
			itemId			: 'nama_pimpinan_peminjam'
		,	name			: 'nama_pimpinan_peminjam'
		,	emptyText		: 'Pimpinan Peminjam'
		},{
			itemId			: 'nama_petugas'
		,	name			: 'nama_petugas'
		,	emptyText		: 'Nama Petugas'
		},{
			itemId			: 'nama_pimpinan_petugas'
		,	name			: 'nama_pimpinan_petugas'
		,	emptyText		: 'Pimpinan Petugas'
		},{
			xtype			: 'fieldset'
		,	collapsable		: true
		,	layout			: 'anchor'
		,	anchor			: '100%'
		,	title			: 'Pencarian Tanggal'
		,	items			: [{
				xtype			: 'combo'
			,	anchor			: '100%'
			,	itemId			: 'pilihan_tanggal'
			,	name			: 'pilihan_tanggal'
			,	store			: s_pil_tgl
			,   displayField	: 'name'
			,	valueField		: 'id'
			,	triggerAction	: 'all'
			,	emptyText		: 'Pilihan Tanggal'
			},{
				xtype			: 'container'
			,	layout			: 'column'
			,	plain			: true
			,	anchor			: '100%'
			,	defaults		: {
					disabled	: true
				}
			,	items			: [{
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
				}]
			}]
		},{
			itemId			: 'keterangan'
		,	name			: 'keterangan'
		,	emptyText		: 'Keterangan'
		},{
			xtype			: 'combo'
		,	anchor			: '100%'
		,	itemId			: 'status'
		,	name			: 'status'
		,	store			: s_status
		,   displayField	: 'name'
		,	valueField		: 'id'
		,	triggerAction	: 'all'
		,	emptyText		: 'Status'
		}]
	,	buttons		: [{
			text			: 'Cari'
		,	itemId			: 'cari'
		,	formBind		: true
		}]
	}]
});
