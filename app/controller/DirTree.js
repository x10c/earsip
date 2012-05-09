Ext.define ('Earsip.controller.DirTree', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
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
});
