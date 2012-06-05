Ext.require ('Earsip.view.NotifPemindahan');

Ext.define ('Earsip.controller.Login', {
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
		ref		: 'berkastree'
	,	selector: 'berkastree'
	}]

,	init	: function ()
	{
		this.control ({
			'loginwindow button[action=login]': {
				click		: this.do_login
			}
		,	'loginwindow textfield[name=user_psw]': {
				specialkey	: this.do_keyenter
			}
		});
	}

,	do_login: function (button)
	{
		var win		= this.getLoginwindow ();
		var form	= win.down ('form').getForm ();

		if (form.isValid ()) {
			form.submit ({
				scope	: this
			,	success	: function (form, action)
				{
					if (action.result.success == false) {
						Ext.msg.error (action.result.info);
						return;
					}

					Earsip.username		= action.result.user_name;
					this.is_pusatarsip	= action.result.is_pusatarsip;
					win.hide ();

					if (action.result.psw_is_expired == 1) {
						var win_psw = Ext.create ('Earsip.view.GantiPasswordWin', {});
						win_psw.on ("destroy", this.after_login_success, this);
						win_psw.show ();
					} else {
						this.after_login_success ();
					}
				}
			,	failure	: function (form, action)
				{
					Ext.msg.error (action.result.info);
				}
			});
		}
	}

,	do_keyenter: function (field, e)
	{
		if (e.getKey () == e.ENTER) {
			this.do_login ();
		}
	}

,	after_login_success : function ()
	{
		var tabpanel = this.getMainview ().down ('#content_tab');

		if (this.is_pusatarsip == true){
			if (tabpanel.getComponent ('notif_pemindahan') == undefined) {
				tabpanel.add ({
					xtype	: 'notif_pemindahan'
				});
				tabpanel.setActiveTab ('notif_pemindahan');
			}
		} else {
			tabpanel.remove ('notif_pemindahan');
		}
		this.getMainview ().open_view_main ();
		this.getMaintoolbar ().do_load_menu ();
		this.getBerkastree ().do_load_tree ();
	}
});
