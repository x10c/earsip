Ext.define ('Earsip.controller.BerkasBerbagi', {
	extend		: 'Ext.app.Controller'
,	refs		: [{
		ref			: 'berkasberbagi'
	,	selector	: 'berkasberbagi'
	},{
		ref			: 'berkasberbagitree'
	,	selector	: 'berkasberbagitree'
	},{
		ref			: 'berkasberbagilist'
	,	selector	: 'berkasberbagilist'
	}]
,	init		: function ()
	{
		this.control ({
			'berkasberbagitree': {
				selectionchange : this.tree_selectionchange
			}
		,	'berkasberbagitree button[itemId=refresh]': {
				click : this.tree_do_refresh
			}
		,	'berkasberbagilist' : {
				itemdblclick : this.list_itemdblclick
			,	selectionchange : this.list_selectionchange
			}
		,	'berkasberbagilist button[itemId=refresh]': {
				click : this.list_do_refresh
			}
		,	'berkasberbagilist button[itemId=dirup]': {
				click : this.do_dirup
			}
		});
	}

,	tree_selectionchange : function (tree, records, opts)
	{
		if (records.length > 0) {
			Earsip.share.id		= records[0].get ('id');
			Earsip.share.pid	= (records[0].get ('parentId') == null)
								? 0
								: records[0].get ('parentId');
			Earsip.share.peg_id	= (records[0].raw == undefined)
								? 0
								: records[0].raw.pegawai_id;

			this.getBerkasberbagilist ().do_load_list (Earsip.share.id
													, Earsip.share.pid
													, Earsip.share.peg_id);
		}
	}

,	tree_do_refresh : function (b)
	{
		this.getBerkasberbagitree ().do_load_tree ();
		Earsip.share.id		= 0;
		Earsip.share.pid	= 0;
	}

,	list_itemdblclick : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}

		Earsip.share.id		= r.get ('id');
		Earsip.share.pid	= r.get ('pid');

		var tree	= this.getBerkasberbagitree ();
		var node	= tree.getRootNode ().findChild ('id', Earsip.share.id, true);

		tree.expandAll ();
		tree.getSelectionModel ().select (node);
	}

,	list_selectionchange : function (model, records)
	{
		var list = this.getBerkasberbagilist ();

		if (records.length > 0) {
			this.getBerkasberbagi ().down ('#berkasberbagi_form').loadRecord (records[0]);
			Earsip.share.id	= records[0].get ('id');
		}
	}

,	list_do_refresh : function (b)
	{
		this.getBerkasberbagilist ().getStore ().load ();
	}

,	do_dirup : function (b)
	{
		if (Earsip.share.pid == 0) {
			return;
		}

		var tree	= this.getBerkasberbagitree ();
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
});
