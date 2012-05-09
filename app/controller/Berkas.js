Ext.define ('Earsip.controller.Berkas', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'berkas'
	,	selector: 'berkas'
	}]
,	init	: function ()
	{
		this.control ({
			'berkas button[itemId=save]': {
				click : this.do_submit
			}
		});
	}

,	do_submit : function (b)
	{
		var form = this.getBerkas ().down ('#berkas_form').getForm ();

		if (! form.isValid ()) {
			return;
		}

		form.submit ({
			success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.Msg.alert ('Informasi', action.result.info);
				} else {
					Ext.Msg.alert ('Error', action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.Msg.alert ('Error', action.result.info);
			}
		});
	}
});
