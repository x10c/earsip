Ext.require ([
	'Earsip.store.BerkasTree'
]);

Ext.define ('Earsip.view.BerkasTree', {
	extend		: 'Ext.tree.Panel'
,	alias		: 'widget.berkastree'
,	id			: 'berkastree'
,	region		: 'west'
,	width		: 220
,	margins		: '5 0 0 5'
,	split		: true
,	store		:'BerkasTree'
,	rootVisible	:false
,	tbar		: [{
		itemId		: 'refresh'
	,	iconCls		: 'refresh'
	,	handler		:function (b)
		{
			b.up ('treepanel').do_refresh ();
		}
	},'-','->','-',{
		itemId		: 'trash'
	,	iconCls		: 'trash'
	}]

,	initComponent	: function()
	{
		this.callParent (arguments);
	}

,	do_refresh	:function ()
	{
		this.getStore ().load ({
			scope		:this
		,	callback	: function (data, op, success)
			{
				if (success) {
					var node = null;

					if (Earsip.berkas.tree.pid != 0) {
						node = this.getRootNode ().findChild ('id', Earsip.berkas.tree.id, true);
					}
					if (node == null) {
						node = this.getRootNode ().getChildAt (0);
					}
					if (node != null) {
						node.expand ();
					}

					this.selectPath (node.getPath ());
				} else {
					Ext.msg.error ('Server error: data berkas tidak dapat diambil!');
				}
			}
		});
	}
});
