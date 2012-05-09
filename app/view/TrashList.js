Ext.require ([
	'Earsip.store.Berkas'
,	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.TrashList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.trashlist'
,	itemId		: 'trashlist'
,	store		: 'Trash'
,	columns		: [{
		text		: 'Nama'
	,	flex		: 1
	,	sortable	: false
	,	hideable	: false
	,	dataIndex	: 'nama'
	,	renderer	: function (v, md, r)
		{
			if (r.get ('tipe_file') == 0) {
				return "<span class='dir'>"+ v +"</span>";
			} else {
				return "<span class='doc'>"+ v +"</span>";
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
	},{
		text		: 'Status'
	,	dataIndex	: 'status'
	,	hidden		: true
	,	renderer	: function (v, md, r)
		{
			if (v == 1) {
				return 'Aktif';
			}
			return 'Non-Aktif';
		}
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		,	handler		: function (b)
			{
				b.up ('#trashlist').getStore ().load ();
			}
		},'-',{
			text		: 'Kembalikan'
		,	itemId		: 'restore'
		,	iconCls		: 'upload'
		,	disabled	: true
		}]
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
,	listeners : {
		activate : function (comp)
		{
			this.getStore ().load ();
		}
	}
,	do_load_list : function ()
	{
		this.getStore ().load ();
	}
});
