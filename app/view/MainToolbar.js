Ext.define ('Earsip.view.MainToolbar', {
	extend			: 'Ext.toolbar.Toolbar'
,	alias			: 'widget.maintoolbar'
,	id				: 'maintoolbar'
,	flex			: 1
,	height			: 42
,	cls				: 'maintoolbarbg'
,	initComponent	: function ()
	{
		this.callParent (arguments);
		if (this.items.length > 0) {
			this.do_load_menu ();
		}
	}
,	do_load_menu : function (comp, opts)
	{
		Ext.Ajax.request ({
			url		: 'data/menu.jsp'
		,	scope	: this
		,	success	: function (response) {
				var o = Ext.decode(response.responseText);
				if (o.success == true) {
					this.suspendLayout = true;
					this.removeAll (true);

					this.add ({
						xtype	: 'tbspacer'
					,	width	: 80
					});
					this.add ('-');

					for (var i = 0; i < o.menu.length; i++) {
						this.add (o.menu[i]);
						this.add ('-');
					}
					this.add ('->');
					this.add ('-');
					this.add ({
						iconCls	: 'app'
					,	text	: Earsip.username
					,	menu	: {
							xtype	: 'menu'
						,	items	: [{
								text	: 'Ubah Password'
							,	action	: 'edit'
							,	iconCls	: 'edit'
							},{
								text	: 'Logout'
							,	action	: 'logout'
							,	iconCls	: 'logout'
							}]	
						}
					});	

					this.suspendLayout = false;
					this.doLayout();
				} else {
					Ext.msg.error (o.info);
				}
			}
		,	failure	: function (response) {
				Ext.msg.error ('Server error: data menu tidak dapat diambil!');
			}
		});
	}
});
