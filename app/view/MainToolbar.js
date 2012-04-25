Ext.define ('Earsip.view.MainToolbar', {
	extend			: 'Ext.toolbar.Toolbar'
,	alias			: 'widget.maintoolbar'
,	flex			: 1
,	height			: 30
,	initComponent	: function ()
	{
		this.callParent (arguments);
		if (this.items.length <= 0) {
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
					var tb = this;

					tb.suspendLayout = true;

					for (var i = 0; i < o.menu.length; i++) {
						tb.add (o.menu[i]);
						tb.add ('-');
					}

					tb.add ('->');
					tb.add ('-');
					tb.add ({ text		: 'Logout'
							, action	: 'logout'});

					tb.suspendLayout = false;
					tb.doLayout();
				} else {
					Ext.Msg.alert ('Kesalahan', o.info);
				}
			}
		,	failure	: function (response) {
				Ext.Msg.alert ('Kesalahan', 'Server error: data menu tidak dapat diambil!');
			}
		});
	}
});
