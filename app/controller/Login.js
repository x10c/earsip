Ext.define ('Earsip.controller.Login', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
	},{
		ref		: 'maintoolbar'
	,	selector: 'maintoolbar'
	},{
		ref		: 'dirtree'
	,	selector: 'dirtree'
	}]

,	init	: function ()
	{
		this.control ({
			'loginwindow button[action=login]': {
				click		: this.do_login
			}
		,	'loginwindow textfield': {
				specialkey	: this.do_keyenter
			}
		});
	}

,	do_login: function (button)
	{
		var win		= button.up ('window');
		var form	= win.down ('form').getForm ();

		if (form.isValid ()) {
			form.submit ({
				scope	: this
			,	success	: function (form, action)
				{
					if (action.result.success == true) {
						win.hide ();
						Earsip.username = action.result.user_name;
						this.getMainview ().getLayout ().setActiveItem ('main');
						this.getMaintoolbar ().do_load_menu ();
						this.getDirtree ().do_load_tree ();
					} else {
						Ext.Msg.alert ('Kesalahan', action.result.info);
					}
				}
			,	failure	: function (form, action)
				{
					Ext.Msg.alert ('Kesalahan', action.result.info);
				}
			});
		}
	}

,	do_keyenter: function ()
	{
	}
});
