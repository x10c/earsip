Ext.define ('Earsip.controller.DirTree', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'dirlist'
	,	selector: 'dirlist'
	}]

,	init	: function ()
	{
		this.control ({
			'dirtree': {
				selectionchange : this.dir_selected
			}
		});
	}

,	dir_selected : function (tree, records, opts)
	{
		Earsip.dir_id		= records[0].get ('id');
		Earsip.tree_path	= records[0].getPath ("text");

		this.getDirlist ().do_load_list (Earsip.dir_id);
	}
});
