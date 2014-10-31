Ext.require ([
	'Earsip.view.BerkasBerbagiTree'
,	'Earsip.view.BerkasBerbagiList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.BerkasBerbagi', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.berkasberbagi'
,	itemId		: 'berkasberbagi'
,	title		: 'Berkas berbagi'
,	layout		: 'border'
,	items		: [{
		xtype		: 'berkasberbagitree'
	,	region		: 'west'
	},{
		xtype		: 'berkasberbagilist'
	,	region		: 'center'
	},{
		xtype		: 'berkasform'
	,	itemId		: 'berkasberbagi_form'
	,	region		: 'east'
	,	width		: 400
	,	split		: true
	,	collapsible	: true
	,	header		: false
	}]
	
,	listeners :
	{
		activate	: function (c)
		{
			c.down ('#berkasberbagitree').do_refresh ();
		}
	,	beforerender: function (comp)
		{
			this.down ('#berkasberbagi_form').down ('#indeks_relatif').hide ();
		}
	}

,	tree_on_selectionchange : function (tree, r, opts)
	{
		if (r.length > 0) {
			Earsip.share.id		= r[0].get ('id');
			Earsip.share.pid	= (r[0].get ('parentId') == null)
								? 0
								: r[0].get ('parentId');
			Earsip.share.peg_id	= (r[0].raw == undefined)
								? 0
								: r[0].raw.pegawai_id;

			this.down ("#berkasberbagilist").do_load_list (Earsip.share.id
													, Earsip.share.pid
													, Earsip.share.peg_id);
		}
	}

,	tree_do_refresh : function (b)
	{
		this.down ("#berkasberbagitree").do_load_tree ();
		Earsip.share.id		= 0;
		Earsip.share.pid	= 0;
	}

,	list_on_itemdblclick : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			Earsip.win_viewer.down ('#download').hide ();
			Earsip.win_viewer.do_open (r);
			return;
		}

		Earsip.share.id		= r.get ('id');
		Earsip.share.pid	= r.get ('pid');

		var tree	= this.down ("#berkasberbagitree");
		var node	= tree.getRootNode ().findChild ('id', Earsip.share.id, true);

		if (node) {
			tree.expandAll ();
			tree.getSelectionModel ().select (node);
		}
	}

,	list_on_selectionchange : function (m, r)
	{
		if (r.length > 0) {
			this.down ('#berkasberbagi_form').loadRecord (r[0]);
			Earsip.share.id	= r[0].get ('id');
		}
	}

,	list_do_dirup : function (b)
	{
		var tree	= this.down ("#berkasberbagitree");
		var root	= tree.getRootNode ();
		var node	= null;

		if (root.get ('id') == Earsip.share.pid) {
			node = root;
		} else {
			node = root.findChild ('id', Earsip.share.pid, true);
		}

		tree.expandAll ();
		tree.getSelectionModel ().select (node);
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#berkasberbagitree").on ("selectionchange", this.tree_on_selectionchange, this);
		this.down ("#berkasberbagitree").down ("#refresh").on ("click", this.tree_do_refresh, this);

		this.down ("#berkasberbagilist").on ("itemdblclick", this.list_on_itemdblclick, this);
		this.down ("#berkasberbagilist").on ("selectionchange", this.list_on_selectionchange, this);
		this.down ("#berkasberbagilist").down ("#dirup").on ("click", this.list_do_dirup, this);
	}
});
