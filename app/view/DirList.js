Ext.require ([
	'Earsip.store.Berkas'
,	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
,	'Earsip.view.MkdirWin'
]);

Ext.define ('Earsip.view.DirList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.dirlist'
,	itemId		: 'dirlist'
,	store		: 'Berkas'
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
			text		: 'Folder baru'
		,	itemId		: 'mkdir'
		,	action		: 'mkdir'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Upload'
		,	itemId		: 'upload'
		,	action		: 'upload'
		,	iconCls		: 'upload'
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		}]
	}]
,	initComponent	: function ()
	{
		this.win = Ext.create ('Earsip.view.MkdirWin', {});
		this.callParent (arguments);
	}

,	do_load_list : function (arsip_id)
	{
		this.getStore ().load ({
			params	: {
				arsip_id : arsip_id
			}
		});
	}
});
