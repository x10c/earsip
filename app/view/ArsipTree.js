Ext.define ('Earsip.view.ArsipTree', {
	extend		:'Ext.tree.Panel'
,	alias		:'widget.arsiptree'
,	id			:'arsiptree'
,	margins		:'5 0 0 5'
,	store		:'ArsipTree'
,	rootVisible	:false
,	tbar		: [{
		iconCls		:'refresh'
	,	handler		:function (b)
		{
			b.up ('treepanel').do_refresh ();
		}
	},'-','->','-',{
		text		: 'Cetak Label'
	,	itemId		: 'label'
	,	iconCls		: 'print'
	}]

,	initComponent	: function()
	{
		this.callParent (arguments);
	}

,	do_refresh	:function ()
	{
		this.getStore ().load ();
	}

,	do_config_label : function ()
	{
		this.down ('#label').setDisabled (true);
	}
});
