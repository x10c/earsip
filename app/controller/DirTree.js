Ext.require ([
	'Earsip.view.Trash'
]);

Ext.define ('Earsip.controller.DirTree', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
	},{
		ref		: 'dirtree'
	,	selector: 'dirtree'
	},{
		ref		: 'dirlist'
	,	selector: 'dirlist'
	}]

,	init	: function ()
	{
		this.control ({
			'dirtree': {
				selectionchange : this.dir_selected
			}
		,	'dirtree button[itemId=refresh]': {
				click : this.do_refresh
			}
		,	'dirtree button[itemId=trash]': {
				click : this.do_open_trash
			}
		});
	}

,	dir_selected : function (tree, records, opts)
	{
		Earsip.dir_id		= records[0].get ('id');
		Earsip.tree_path	= records[0].getPath ("text");

		this.getDirlist ().do_load_list (Earsip.dir_id);
	}

,	do_refresh : function ()
	{
		this.getDirtree ().do_load_tree ();
		Earsip.dir_id		= 0;
		Earsip.path_tree	= '';
	}

,	do_open_trash : function (b)
	{
		var tabpanel = this.getMainview ().down ('#content_tab');

		Earsip.acl = b.acl;

		var c = tabpanel.getComponent (b.itemId);
		if (c == undefined) {
			tabpanel.add ({
				xtype	: b.itemId
			});
		}
		tabpanel.setActiveTab (b.itemId);
	}
});
