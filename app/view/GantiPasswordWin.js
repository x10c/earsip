Ext.define ('Earsip.view.GantiPasswordWin', {
	extend			: 'Ext.Window'
,	alias			: 'widget.gantipassword'
,	itemId			: 'gantipassword'
,	title			: 'Ganti Password'
,	autoHeight		: true
,	closable		: true
,	resizable		: false
,	draggable		: false
,	autoHeight		: true
,	layout			: 'fit'
,	border			: true
,	modal			: true
,	defaultFocus	: 'old_psw'
,	items			:
	[{
		xtype			: 'form'
	,	url				: 'data/gantipassword.jsp'
	,	plain			: true
	,	frame			: true
	,	border			: 0
	,	bodyPadding		: 5
	,	defaults		:
		{
			xtype			: 'textfield'
		,	allowBlank		: false
		,	anchor			: '100%'
		,	selectOnFocus	: true
		,	labelWidth		: 200
		,	labelAlign		: 'right'
		}
	,	items			:
		[{
        	fieldLabel		: 'Password Lama'
        ,	itemId			: 'old_psw'
		,	inputType		: 'password'
        ,	name			: 'old_psw'
        },{
        	fieldLabel		: 'Password Baru'
        ,	itemId			: 'new_psw'
		,	inputType		: 'password'
        ,	name			: 'new_psw'
        },{
        	fieldLabel		: 'Konfirmasi Password Baru'
        ,	itemId			: 'conf_psw'
		,	inputType		: 'password'
        ,	name			: 'conf_psw'
        }]
	}]
,	buttons			:
	[{
		text	: 'Simpan'
	,	itemId	: "save"
	,	type	: 'submit'
	,	action	: 'submit'
	,	iconCls	: 'save'
	,	formBind: true
	}]

,	do_submit: function (b)
	{
		var form	= this.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu.');
			return;
		}

		form.submit ({
			scope	: this
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					this.destroy ();
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error (action.result.info);
			}
		});
	}

,	initComponent	: function ()
	{
		this.callParent (arguments);

		this.down ("#save").on ("click", this.do_submit, this);
	}
});
