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
,	id			: 'berkaslist'
,	store		: 'Berkas'
,	columns		: [{
		text		: 'Nama Berkas'
	,	width		:320
	,	hideable	: false
	,	dataIndex	: 'nama'
	,	locked		: true
	,	renderer	: function (v, md, r)
		{
			if (r.get ('tipe_file') == 0) {
				md.tdCls = 'dir';
			} else {
				md.tdCls = 'doc';
			}
			return v;
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
	,	align		:'center'
	,	renderer	: function(v)
			{return date_renderer (v);}
	},{
		text		: 'Status'
	,	dataIndex	: 'status'
	,	hidden		: true
	,	width		: 100
	,	renderer	: function (v, md, r)
		{
			if (v == 1) {
				return 'Aktif';
			}
			return 'Non-Aktif';
		}
	}]
,	tbar : [{
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

,	initComponent	: function ()
	{
		this.win_share	= Ext.create ('Earsip.view.BerkasBerbagiWin', {});
		this.win_search	= Ext.create ('Earsip.view.CariBerkasWin', {});
		Earsip.win_viewer	= Ext.create ('Earsip.view.DocViewer', {});
		this.callParent (arguments);
	}

,	do_refresh	: function ()
	{
		this.getStore ().load ({
			params	: {
				berkas_id : Earsip.berkas.tree.id
			}
		});
	}
});
