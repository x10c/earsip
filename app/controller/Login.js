Ext.require ('Earsip.view.NotifPemindahan');

Ext.define ('Earsip.controller.Login', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
	},{
		ref		: 'maintoolbar'
	,	selector: 'maintoolbar'
	},{
		ref		: 'berkastree'
	,	selector: 'berkastree'
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
						var tabpanel = this.getMainview ().down ('#content_tab');
						if (action.result.is_pusatarsip == true){
							if (tabpanel.getComponent ('notif_pemindahan') == undefined) {
								tabpanel.add ({
									xtype	: 'notif_pemindahan'
								}); 
								tabpanel.setActiveTab ('notif_pemindahan');
							}
						} else {
							tabpanel.remove ('notif_pemindahan');
						}
						this.getMainview ().getLayout ().setActiveItem ('main');
						this.getMaintoolbar ().do_load_menu ();
						this.getBerkastree ().do_load_tree ();
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
