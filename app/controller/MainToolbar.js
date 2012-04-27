Ext.require ('Earsip.view.AdmSistem');
Ext.require ('Earsip.view.AdmHakAkses');

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
	},{
		ref		: 'content'
	,	selector: 'content'
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
		var tabpanel = this.getContent ();

		Earsip.acl = button.acl;

		var c = tabpanel.getComponent (button.itemId);
		if (c == undefined) {
			tabpanel.add ({
				xtype	: button.itemId
			});
		}
		tabpanel.setActiveTab (button.itemId);
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
