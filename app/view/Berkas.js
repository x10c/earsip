Ext.require ([
	'Earsip.view.BerkasTree'
,	'Earsip.view.BerkasList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.Berkas', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.berkas'
,	itemId		: 'berkas'
,	title		: 'Berkas'
,	layout		: 'border'
,	items		: [{
		xtype		: 'berkastree'
	,	region		: 'west'
	},{
		xtype		: 'container'
	,	region		: 'center'
	,	layout		: 'border'
	,	items		: [{
			xtype		: 'berkaslist'
		,	region		: 'center'
		},{
			xtype		: 'berkasform'
		,	itemId		: 'berkas_form'
		,	url			: 'data/berkas_submit.jsp'
		,	region		: 'south'
		,	split		: true
		,	collapsible	: true
		,	header		: false
		,	buttons		: [{
				text		: 'Folder Baru'
			,	itemId		: 'mkdir'
			,	iconCls		: 'add'
			,	formBind	:true
			},'-',{
				text		:'Berkas Tanpa Scan'
			,	itemId		:'berkas_baru'
			,	iconCls		:'add'
			,	formBind	:true
			,	handler		:function (b)
				{
					b.up ('#berkas').onclick_berkas_baru ();
				}
			},'-','->','-',{
				text		: 'Simpan'
			,	itemId		: 'save'
			,	iconCls		: 'save'
			,	disabled	: true
			}]
		}]
	}]

,	listeners	:{
		activate	:function (c)
		{
			c.down ('#berkaslist').do_refresh ();
		}
	}

,	initComponent	: function()
	{
		this.callParent (arguments);

		var tree	= this.down ('#berkastree');
		var sm		= tree.getSelectionModel ();

		if (Earsip.berkas.tree.pid != 0) {
			node = tree.getRootNode ().findChild ('id', Earsip.berkas.tree.id, true);
		} else {
			node = tree.getRootNode ().getChildAt (0);
		}

		sm.deselectAll ();
		tree.expandAll ();
		if (node != null) {
			sm.select (node);
		}
	}

,	onclick_berkas_baru: function ()
	{
		var berkas_form = this.down ('#berkas_form');
		var berkas_list	= this.down ('#berkaslist');
		var form		= berkas_form.getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang bertanda "*" atau berwarna merah terlebih dahulu!');
			return;
		}
		if (Earsip.berkas.tree.id <= 0) {
			Ext.msg.error ('Pilih tempat untuk direktori baru terlebih dahulu!');
			return;
		}

		berkas_form.down ('#tipe_file').setValue (1);

		form.submit ({
			scope	: this
		,	url		: 'data/berkas_baru.jsp'
		,	params	: {
				berkas_id	: Earsip.berkas.tree.id
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info ('Berkas baru telah dibuat!');
					berkas_list.do_refresh ();
				} else {
					Ext.msg.error ('Gagal membuat berkas baru!<br/><hr/>'+ action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error ('Gagal membuat berkas baru!<br/><hr/>'+ action.result.info);
			}
		});
	}
});
