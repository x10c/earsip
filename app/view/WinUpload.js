Ext.define ('Earsip.view.WinUpload', {
	extend	: 'Ext.window.Window'
,	alias	: 'widget.winupload'
,	title	: 'Unggah berkas'
,	layout	: 'fit'
,	items	: {
		xtype		: 'form'
	,	labelAlign	: 'right'
	,	buttonAlign	: 'center'
	,	width		: 400
	,	padding		: 10
	,	frame		: true
	,	items		: [{
			xtype		: 'filefield'
		,	name		: 'fileupload'
		,	itemId		: 'fileupload'
		,	fieldLabel	: 'Berkas'
		,	labelAlign	: 'right'
		,	msgTarget	: 'side'
		,	allowBlank	: false
		,	anchor		: '100%'
		,	buttonText	: 'Pilih berkas ...'
		}]
	,	buttons		: [{
			text		: 'Unggah'
		,	itemId		: 'upload'
		,	action		: 'upload'
		,	iconCls		: 'upload'
		}]
	}
});
