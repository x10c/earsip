Ext.require ([
	'Earsip.store.Arsip'
,	'Earsip.store.KlasArsip'
,	'Earsip.store.TipeArsip'
,	'Earsip.view.ArsipCariWin'
,	'Earsip.view.ArsipTree'
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
	,	renderer	: function (v, md, r)
		{
			if (r.get ('tipe_file') == 0) {
				return "<span class='dir'>"+ v +"</span>";
			} else {
				return "<span class='doc'>"+ v +"</span>";
			}
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
		,	handler		:function (b)
			{
				Earsip.arsip.tree.type = 'folder';
				b.up ('grid').do_refresh ();
			}
		},'-',{
			text		: 'Kembali'
		,	itemId		: 'dirup'
		,	iconCls		: 'dirup'
		,	handler		:function (b)
			{
				Earsip.arsip.tree.type	= 'arsip_folder';
				Earsip.arsip.tree.id	= Earsip.arsip.tree.pid;
				Earsip.arsip.tree.pid	= 0;
				b.up ('grid').do_refresh ();
			}
		},'-','->','-',{
			text		: 'Cari'
		,	itemId		: 'search'
		,	iconCls		: 'search'
		,	handler		:function (b)
			{
				b.up ('grid').win_search.show ();
			}
		},'-',{
			text		:'Cetak label'
		,	itemId		:'cetak_label'
		,	iconCls		:'print'
		,	disabled	:true
		,	handler		:function (b)
			{
				var url = 'data/lapcetaklabel_submit.jsp?' +
							'unit_kerja_id=' + Earsip.arsip.tree.unit_kerja_id + '&&' +
							'kode_rak=' + Earsip.arsip.tree.kode_rak + '&&' +
							'kode_box=' + Earsip.arsip.tree.kode_box
				window.open (url);
			}
		}]
	}]

,	listeners	:{
		itemdblclick	:function (v, r)
		{
			var t = r.get ("tipe_file");

			if (t != 0) {
				return;
			}

			Earsip.arsip.tree.id	= r.get ("id")
			Earsip.arsip.tree.pid	= r.get ("pid");
			Earsip.arsip.tree.type	='arsip_folder';

			this.do_refresh ();
		}
	}

,	initComponent	: function ()
	{
		this.win_search	= Ext.create ('Earsip.view.ArsipCariWin', {});
		this.callParent (arguments);
	}

,	do_refresh		:function ()
	{
		this.do_load_list ();
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
