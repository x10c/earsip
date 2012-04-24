Ext.require (['Earsip.view.Main']);

Ext.define ('Earsip.view.LoginWindow', {
	extend			: 'Ext.Window'
,	alias			: 'widget.loginwindow'
,	title			: 'Login'
,	width			: 400
,	autoHeight		: true
,	closable		: false
,	resizable		: false
,	draggable		: false
,	autoHeight		: true
,	layout			: 'fit'
,	border			: false
,	modal			: true
,	items			: [{
		xtype			: 'form'
	,	url				: 'data/login.jsp'
	,	plain			: true
	,	frame			: true
	,	border			: 0
	,	bodyPadding		: 5
	,	defaults		: {
			xtype			: 'textfield'
		,	allowBlank		: false
		,	anchor			: '100%'
		,	selectOnFocus	: true
		}
	,	items			: [{
			fieldLabel		: 'NIP'
		,	itemId			: 'user_nip'
		,	name			: 'user_nip'
		},{
			fieldLabel		: 'Password'
		,	inputType		: 'password'
		,	name			: 'user_psw'
		}]
	}]
,	defaultFocus	: 'user_name'
,	buttons			: [{
		text			: 'Login'
	,	type			: 'submit'
	,	action			: 'login'
	,	formBind		: true
    }]

,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
