Ext.define ('Earsip.view.WinUpload', {
	extend		: 'Ext.window.Window'
,	alias		: 'widget.winupload'
,	title		: 'Unggah berkas'
,	closeAction	: 'hide'
,	resizable	: true
,	layout		: 'fit'
,	width		: 700
,	height		: 400
,	modal		: true
,	items		: [{
		xtype			: 'xuploadpanel'
	,	chunk_size		: _g_max_upload_size +' KB'
	,	max_file_size 	: _g_max_upload_size +' KB'
	,	multipart_params: {
			id				: Earsip.berkas.tree.id
		}
	}]
});
