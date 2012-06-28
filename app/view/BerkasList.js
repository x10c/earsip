Ext.require ([
	'Earsip.store.Berkas'
,	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
,	'Earsip.view.BerkasBerbagiWin'
,	'Earsip.view.CariBerkasWin'
,	'Earsip.view.DocViewer'
]);

Ext.define ('Earsip.view.BerkasList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.berkaslist'
,	itemId		: 'berkaslist'
,	store		: 'Berkas'
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
			text		: 'Unggah'
		,	itemId		: 'upload'
		,	iconCls		: 'upload'
		},'-',{
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
		},'-',{
			text		: 'Bagi'
		,	itemId		: 'share'
		,	iconCls		: 'dir'
		,	disabled	: true
		},'-',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	iconCls		: 'del'
		,	disabled	: true
		}]
	}]
,	initComponent	: function ()
	{
		this.win_share	= Ext.create ('Earsip.view.BerkasBerbagiWin', {});
		this.win_search	= Ext.create ('Earsip.view.CariBerkasWin', {});
		this.win_viewer	= Ext.create ('Earsip.view.DocViewer', {});
		this.callParent (arguments);
	}

,	do_load_list : function (berkas_id)
	{
		this.getStore ().load ({
			params	: {
				berkas_id : berkas_id
			}
		});
	}
});
