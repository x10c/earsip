Ext.define ('Earsip.controller.Login', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
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
						this.getMainview ().getLayout ().setActiveItem ('main');
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
