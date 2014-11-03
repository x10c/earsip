Ext.require ([
	'Earsip.view.BerkasList'
]);

Ext.define ('Earsip.view.WinUploadSingle', {
	extend		: 'Ext.window.Window'
,	alias		: 'widget.winuploadsingle'
,	title		: 'Unggah berkas'
,	closeAction	: 'hide'
,	resizable	: true
,	layout		: 'fit'
,	modal		: true
,	items		: [{
		xtype		:'form'
	,	layout		:'anchor'
	,	bodyPadding	:5
	,	items		:[{
			xtype		:'filefield'
		,	name		:'berkas_upload'
		,	fieldLabel	:'Berkas'
		,	labelWidth	:50
		,	labelAlign	:'right'
		,	width		:500
		,	msgTarget	:'side'
		,	allowBlank	:false
		,	anchor		:'100%'
		,	buttonText	:'Pilih Berkas ...'
		}]
	,	buttons		:[{
			text		:'Unggah'
		,	formBind	:true
		,	handler		:function ()
			{
				var win		= this.up ('window');
				var form	= this.up ('form').getForm ();

				if (! form.isValid ()) {
					Ext.msg.info ('Silahkan pilih salah satu berkas terlebih dahulu!');
					return;
				}

				form.submit ({
					url		:'data/upload_single.jsp'
				,	waitMsg	:'Mengunggah berkas ...'
				,	params	:{
						id		:Earsip.berkas.tree.id
					}
				,	success	:function (fp, o)
					{
						Ext.msg.info ('Berkas anda "'+ o.result.file +'" telah tersimpan!');
						Ext.getCmp ('berkaslist').do_refresh (parseInt (o.result.id));
						win.close ();
					}
				,	failure	:function (fp, o)
					{
						Ext.msg.error (o.result.info);
					}
				});
			}
		}]
	}]
});
