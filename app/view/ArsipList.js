Ext.require ([
	'Earsip.store.Arsip'
,	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
,	'Earsip.view.ArsipCariWin'
]);

Ext.define ('Earsip.view.ArsipList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.arsiplist'
,	itemId		: 'arsiplist'
,	store		: 'Arsip'
,	columns		: [{
		text		: 'Nama'
	,	width		: 300
	,	hideable	: false
	,	dataIndex	: 'nama'
	,	locked		: true
	,	renderer	: function (v, md, r)
		{
			if (r.get ('tipe_file') == 0) {
				return "<span class='dir'>"+ v +"</span>";
			} else {
				return "<a class='doc' target='_blank'"
					+" href='data/download.jsp"
					+"?berkas="+ r.get('sha') +"&nama="+ v +"'>"
					+ v +"</a>";
			}
		}
	},{
		text		: 'Klasifikasi'
	,	width		: 150
	,	dataIndex	: 'berkas_klas_id'
	,	renderer	: store_renderer ('id', 'nama', Ext.getStore ('KlasArsip'))
	},{
		text		: 'Tipe'
	,	width		: 150
	,	dataIndex	: 'berkas_tipe_id'
	,	renderer	: store_renderer ('id', 'nama', Ext.getStore ('TipeArsip'))
	},{
		text		: 'Tanggal Dibuat'
	,	width		: 150
	,	dataIndex	: 'tgl_dibuat'
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		},'-',{
			text		: 'Kembali'
		,	itemId		: 'dirup'
		,	iconCls		: 'dirup'
		},'-','->','-',{
			text		: 'Cari'
		,	itemId		: 'search'
		,	iconCls		: 'search'
		}]
	}]

,	initComponent	: function ()
	{
		this.win_search	= Ext.create ('Earsip.view.ArsipCariWin', {});
		this.callParent (arguments);
	}

,	do_load_list : function (berkas_id)
	{
		this.getStore ().load ({
			params	: {
				type			: Earsip.arsip.tree.type
			,	id				: Earsip.arsip.tree.id
			,	pid				: Earsip.arsip.tree.pid
			,	unit_kerja_id	: Earsip.arsip.tree.unit_kerja_id
			,	kode_rak		: Earsip.arsip.tree.kode_rak
			,	kode_box		: Earsip.arsip.tree.kode_box
			,	kode_folder		: Earsip.arsip.tree.kode_folder
			}
		});
	}
});
