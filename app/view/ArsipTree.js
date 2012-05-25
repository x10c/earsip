Ext.define ('Earsip.view.ArsipTree', {
	extend		: 'Ext.tree.Panel'
,	alias		: 'widget.arsiptree'
,	itemId		: 'arsiptree'
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
		},'-'
		]
	}]

,	initComponent	: function()
	{
		this.callParent (arguments);
	}

,	do_load_tree : function ()
	{
		Ext.Ajax.request ({
			url		: 'data/arsip_tree.jsp'
		,	scope	: this
		,	success	: function (response)
			{
				var o = Ext.decode (response.responseText);
				if (o.success == true) {
					this.suspendEvents (false);
					this.setRootNode (o.data);
					this.getRootNode ().raw = o.data;
					this.resumeEvents ();
					this.doLayout();

					if (Earsip.arsip.tree.pid != 0) {
						var node = this.getRootNode ().findChild ('id', Earsip.arsip.tree.id, true);

						if (node != null) {
							this.expandAll ();
							this.getSelectionModel ().select (node);
						}
					}
				} else {
					Ext.Msg.alert ('Kesalahan', o.info);
				}
			}
		,	failure	: function (response) {
				Ext.Msg.alert ('Kesalahan', 'Server error: data arsip tidak dapat diambil!');
			}
		});
	}
});
