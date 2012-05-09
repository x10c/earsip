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
,	items			: [{
		xtype			: 'form'
	,	url				: 'data/gantipassword.jsp'
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
,	defaultFocus	: 'old_psw'
,	buttons			: [{
			text	: 'Simpan'
		,	type	: 'submit'
		,	action	: 'submit'
		,	iconCls	: 'save'
		,	formBind: true
		}]

,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
