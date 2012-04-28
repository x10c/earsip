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
		this.getDirlist ().do_load_list (records[0].get ('id'));
	}
});
