Ext.require ('Earsip.view.GantiPasswordWin');

Ext.define ('Earsip.controller.GantiPassword', {
	extend	: 'Ext.app.Controller'
,	init	: function ()
	{
		this.control ({
			'gantipassword button[action=submit]': {
				click		: this.do_submit
			}
		,	'gantipassword textfield': {
				specialkey	: this.do_keyenter
			}
		});
	}

,	do_submit: function (button)
	{
		var win		= button.up ('window');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		form.submit ({
			scope	: this
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.Msg.alert ('Informasi', action.result.info);
					win.destroy();
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

,	do_keyenter: function ()
	{
	}
});
