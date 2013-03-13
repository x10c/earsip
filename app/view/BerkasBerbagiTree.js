Ext.define ('Earsip.view.BerkasBerbagiTree', {
	extend		: 'Ext.tree.Panel'
,	alias		: 'widget.berkasberbagitree'
,	id			: 'berkasberbagitree'
,	region		: 'west'
,	width		: 220
,	margins		: '5 0 0 5'
,	split		: true
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			itemId		: 'refresh'
		,	iconCls		: 'refresh'
		},'-']
	}]

,	initComponent	: function()
	{
		this.callParent (arguments);
	}

,	do_load_tree : function ()
	{
		Ext.Ajax.request ({
			url		: 'data/berkasberbagi_tree.jsp'
		,	scope	: this
		,	success	: function (response) {
				var o = Ext.decode(response.responseText);
				if (o.success == true) {
					this.suspendEvents (false);
					this.setRootNode (o.data);
					this.getRootNode ().cascadeBy (function (n){
						n.set ('iconCls', 'treeicon');
					});
					this.resumeEvents ();
					this.doLayout();

					if (Earsip.share.id != 0) {
						var node = this.getRootNode ().findChild ('id', Earsip.share.id, true);

						if (node != null) {
							this.expandAll ();
							this.getSelectionModel ().select (node);
						}
					}
				} else {
					Ext.msg.error (o.info);
				}
			}
		,	failure	: function (response) {
				Ext.msg.error ('Server error: data berkas berbagi tidak dapat diambil!');
			}
		});
	}

,	do_refresh	:function ()
	{
		this.do_load_tree ();
	}
});
