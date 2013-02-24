Ext.require ([
	'Earsip.view.ArsipTree'
,	'Earsip.view.ArsipList'
,	'Earsip.view.ArsipForm'
]);

Ext.define ('Earsip.view.Arsip', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.mas_arsip'
,	itemId		: 'mas_arsip'
,	title		: 'Arsip'
,	layout		: 'border'
,	closable	: true
,	items		: [{
		xtype		: 'arsiptree'
	,	region		: 'west'
	,	width		: 220
	,	split		: true
	},{
		xtype		: 'container'
	,	region		: 'center'
	,	layout		: 'border'
	,	items		: [{
			xtype		: 'arsiplist'
		,	region		: 'center'
		},{
			xtype		: 'arsipform'
		,	itemId		: 'arsip_form'
		,	url			: 'data/arsip_submit.jsp'
		,	region		: 'south'
		,	split		: true
		,	collapsible	: true
		,	header		: false
		}]
	}]

,	do_refresh:	function ()
	{
		var tree = this.down ('#arsiptree');
		tree.do_refresh ();
		tree.do_config_label ();
	}

,	arsip_baru_onclick: function ()
	{
		var arsip_tree	= this.down ('#arsip_tree');
		var arsip_form	= this.down ('#arsip_form');
		var f			= arsip_form.getForm ();

		if (! f.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang bertanda "*" atau berwarna merah terlebih dahulu!');
			return;
		}

		f.submit ({
			scope	:this
		,	params	:{
				action	:'create'
			}
		,	success	:function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					arsip_tree.do_refresh ();
				} else {
					Ext.msg.error ('Gagal membuat arsip baru!<br/><hr/>'+ action.result.info);
				}
			}
		,	failure	:function (form, action)
			{
				Ext.msg.error ('Gagal membuat arsip baru!<br/><hr/>'+ action.result.info);
			}
		});
	}
});
