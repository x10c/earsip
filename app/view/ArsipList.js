Ext.require ([
	'Earsip.store.Arsip'
,	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
]);

Ext.define ('Earsip.view.ArsipList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.arsiplist'
,	itemId		: 'arsiplist'
,	store		: 'Arsip'
,	columns		: [{
		text		: 'Nama'
	,	flex		: 1
	,	hideable	: false
	,	dataIndex	: 'nama'
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
		},'-'
		]
	}]

,	initComponent	: function ()
	{
		this.win		= Ext.create ('Earsip.view.MkdirWin', {});
		this.win_share	= Ext.create ('Earsip.view.BerkasBerbagiWin', {});
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
