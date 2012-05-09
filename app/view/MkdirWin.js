Ext.require ([
	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.MkdirWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.mkdirwin'
,	itemId		: 'mkdirwin'
,	title		: 'Buat folder baru'
,	width		: 400
,	closable	: true
,	closeAction	: 'hide'
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	resizable	: false
,	draggable	: false
,	items		: [{
		xtype		: 'berkasform'
	,	itemId		: 'mkdirwin_form'
	,	url			: 'data/mkdir.jsp'
	}]
,	buttons			: [{
		text			: 'Buat'
	,	type			: 'submit'
	,	action			: 'submit'
	,	formBind		: true
	}]
});
