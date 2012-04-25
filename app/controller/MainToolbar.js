Ext.define ('Earsip.controller.MainToolbar', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
	},{
		ref		: 'loginwindow'
	,	selector: 'loginwindow'
	},{
		ref		: 'maintoolbar'
	,	selector: 'maintoolbar'
	}]

,	init	: function ()
	{
		this.control ({
			'maintoolbar menu > menuitem': {
				click: this.menuitem_on_click
			}
		,	'maintoolbar button[action=logout]': {
				click: this.do_logout
			}
		});
	}

,	menuitem_on_click : function (button)
	{
		console.log (button.itemId);
	}

,	do_logout : function (button)
	{
		Ext.Ajax.request ({
			url		: 'data/logout.jsp'
		,	scope	: this
		,	success	: function (response)
			{
				var o = Ext.decode(response.responseText);
				if (o.success == true) {
					this.getMainview ().getLayout ().setActiveItem ('login');
					this.getLoginwindow ().show ();
				} else {
					Ext.Msg.alert ('Kesalahan', o.info);
				}
			}
		,	failure	: function (response)
			{
				Ext.Msg.alert ('Kesalahan', 'Server error: tidak dapat keluar dari aplikasi!');
			}
		});
	}
});
