Ext.define ('Earsip.view.BerkasTree', {
	extend		: 'Ext.tree.Panel'
,	alias		: 'widget.berkastree'
,	id			: 'berkastree'
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
		},'-','->','-',{
			itemId		: 'trash'
		,	iconCls		: 'trash'
		}]
	}]

,	initComponent	: function()
	{
		this.callParent (arguments);
	}

,	do_load_tree : function ()
	{
		Ext.Ajax.request ({
			url		: 'data/berkas_tree.jsp'
		,	scope	: this
		,	success	: function (response) {
				var o = Ext.decode(response.responseText);
				if (o.success == true) {
					var sm = this.getSelectionModel ();
					var node;

					this.suspendEvents (false);
					this.setRootNode (o.data);
					this.getRootNode ().raw = o.data;
					this.resumeEvents ();
					this.doLayout();

					if (Earsip.berkas.tree.pid != 0) {
						node = this.getRootNode ().findChild ('id', Earsip.berkas.tree.id, true);
					} else {
						node = this.getRootNode ();
					}

					sm.deselectAll ();
					this.expandAll ();
					if (node != null) sm.select (node);
				} else {
					Ext.msg.error (o.info);
				}
			}
		,	failure	: function (response) {
				Ext.msg.error ('Server error: data berkas tidak dapat diambil!');
			}
		});
	}
});
