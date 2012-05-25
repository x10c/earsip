Ext.define ('Earsip.controller.Arsip', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		:'mas_arsip'
	,	selector:'mas_arsip'
	},{
		ref		:'arsiptree'
	,	selector:'arsiptree'
	},{
		ref		:'arsiplist'
	,	selector:'arsiplist'
	}]
,	init	: function ()
	{
		this.control ({
			'arsiptree': {
				selectionchange : this.tree_selectionchange
			}
		,	'arsiptree button[itemId=refresh]': {
				click : this.tree_do_refresh
			}
		,	'arsiplist': {
				itemdblclick : this.list_itemdblclick
			,	selectionchange : this.list_selectionchange
			}
		,	'arsiplist button[itemId=dirup]': {
				click : this.list_dirup
			}
		});
	}

,	tree_do_refresh : function (b)
	{
		this.getArsiptree ().do_load_tree ();
	}

,	tree_selectionchange : function (tree, records)
	{
		if (records.length <= 0) {
			return;
		}

		Earsip.arsip.id					= records[0].get ('id');
		Earsip.arsip.pid				= records[0].get ('parentId');
		Earsip.arsip.tree.id			= records[0].get ('id');
		Earsip.arsip.tree.pid			= records[0].get ('parentId');
		Earsip.arsip.tree.type			= records[0].raw.type;
		Earsip.arsip.tree.unit_kerja_id	= records[0].raw.unit_kerja_id;
		Earsip.arsip.tree.kode_rak		= records[0].raw.kode_rak;
		Earsip.arsip.tree.kode_box		= records[0].raw.kode_box;
		Earsip.arsip.tree.kode_folder	= records[0].raw.kode_folder;

		if (Earsip.arsip.pid == null) {
			Earsip.arsip.pid			= 0;
			Earsip.arsip.tree.pid		= 0;
		}

		this.getArsiplist ().do_load_list ();
	}

,	list_itemdblclick : function (v, r)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}

		Earsip.arsip.id		= r.get ("id");
		Earsip.arsip.pid	= r.get ("pid");

		var tree	= this.getArsiptree ();
		var node	= tree.getRootNode ().findChild ('id', Earsip.arsip.id, true);

		tree.expandAll ();
		tree.getSelectionModel ().select (node);
	}

,	list_selectionchange : function (model, records)
	{
		var list = this.getArsiplist ();
		var form = this.getMas_arsip ().down ('#arsip_form');

		form.loadRecord (new Earsip.model.Berkas ());

		if (records.length > 0) {
			form.loadRecord (records[0]);
			list.record			= records[0];
			Earsip.arsip.id		= records[0].get ('id');
			Earsip.arsip.pid	= records[0].get ('pid');
		}
	}

,	list_dirup : function (b)
	{
		var tree	= this.getArsiptree ();
		var root	= tree.getRootNode ();
		var node	= null;

		if (root.get ('id') == Earsip.arsip.tree.pid) {
			node = root;
		} else {
			node = root.findChild ('id', Earsip.arsip.tree.pid, true);
		}

		tree.expandAll ();
		tree.getSelectionModel ().select (node);
	}
});
