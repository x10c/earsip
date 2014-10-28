Ext.require ([
	'Earsip.view.BerkasTree'
,	'Earsip.view.BerkasList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.Berkas', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.berkas'
,	id			: 'berkas'
,	title		: 'Berkas'
,	layout		: 'border'
,	items		: [{
		xtype		: 'berkastree'
	,	region		: 'west'
	},{
		xtype		: 'berkaslist'
	,	region		: 'center'
	,	tbar		: [{
			text		: 'Berkas dengan scan'
		,	itemId		: 'upload'
		,	iconCls		: 'upload'
		},'-',{
			text		:'Berkas tanpa scan'
		,	itemId		:'berkas_baru'
		,	iconCls		:'add'
		,	formBind	:true
		,	handler		:function (b)
			{
				b.up ('#berkas').list_onclick_berkas_noscan ();
			}
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		},'-',{
			text		: 'Kembali'
		,	itemId		: 'dirup'
		,	iconCls		: 'dirup'
		},'-','->','-',{
			text		: 'Cari'
		,	itemId		: 'search'
		,	iconCls		: 'search'
		},'-',{
			text		: 'Bagi'
		,	itemId		: 'share'
		,	iconCls		: 'dir'
		,	disabled	: true
		},'-',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	iconCls		: 'del'
		,	disabled	: true
		}]

	,	listeners	:{
			selectionchange	:function (m, r)
			{
				this.up ('#berkas').list_on_select (r);
			}
		}
	},{
		xtype		: 'berkasform'
	,	id			: 'berkasform'
	,	url			: 'data/berkas_submit.jsp'
	,	region		: 'east'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	,	width		: 400
	,	buttons		: [{
			text		: 'Folder baru'
		,	itemId		: 'mkdir'
		,	iconCls		: 'add'
		,	disabled	:true
		,	handler		:function (b)
			{
				b.up ('#berkas').form_do_mkdir ();
			}
		},'-','->','-',{
			text		: 'Ubah data'
		,	itemId		: 'edit'
		,	iconCls		: 'edit'
		,	disabled	: true
		,	handler		:function (b)
			{
				b.up ('#berkas').form_do_edit ();
			}
		},'-',{
			text		: 'Simpan'
		,	itemId		: 'save'
		,	iconCls		: 'save'
		,	disabled	:true
		,	handler		:function (b)
			{
				b.up ('#berkas').form_do_save ();
			}
		}]
	}]

,	initComponent	: function()
	{
		this.callParent (arguments);

		this.down ('#berkasform').set_disabled (true);
	}

,	list_on_select	: function (r)
	{
		var berkaslist	= this.down ('#berkaslist');
		var berkasform	= this.down ('#berkasform');

		if (r.length > 0) {
			berkasform.loadRecord (r[0]);
			berkaslist.record	= r[0];
			Earsip.berkas.id	= r[0].get ('id');
			Earsip.berkas.pid	= r[0].get ('pid');
		}

		this.down ('#edit').setDisabled (! r.length);
		berkaslist.down ('#del').setDisabled (! r.length);
		berkaslist.down ('#share').setDisabled (! r.length);
	}

,	list_onclick_berkas_noscan: function ()
	{
		var berkasform	= this.down ('#berkasform');
		var form		= berkasform.getForm ();

		form.reset ();
		form.url = 'data/berkas_baru.jsp'
		berkasform.down ('#berkas_id').setValue (Earsip.berkas.tree.id);
		berkasform.down ('#pid').setValue (Earsip.berkas.tree.id);
		berkasform.down ('#tipe_file').setValue (1);
		berkasform.set_disabled (false);
	}

,	form_do_edit	: function ()
	{
		var berkasform	= this.down ('#berkasform');

		berkasform.getForm ().url = 'data/berkas_submit.jsp';
		berkasform.set_disabled (false);
		berkasform.down ('#save').setDisabled (false);
	}

,	form_do_mkdir	:function ()
	{
		var berkastree	= this.down ('#berkastree');
		var berkaslist	= this.down ('#berkaslist');
		var berkasform	= this.down ('#berkasform');
		var form		= berkasform.getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		if (Earsip.berkas.tree.id <= 0) {
			Ext.msg.error ('Pilih tempat untuk direktori baru terlebih dahulu!');
			return;
		}

		berkasform.down ('#tipe_file').setValue (0);

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
					berkastree.do_refresh ();
					berkaslist.do_refresh ();
					form.reset ();
					berkasform.set_disabled (true);
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error ('Gagal membuat direktori!');
			}
		});
	}

,	form_do_save	:function ()
	{
		var berkasform	= this.down ('#berkasform');
		var berkaslist	= this.down ('#berkaslist');
		var form		= berkasform.getForm ();

		if (! form.isValid ()) {
			return;
		}

		form.submit ({
			scope	: this
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					if (action.result.info) {
						Ext.msg.info (action.result.info);
					} else if (action.result.data) {
						Ext.msg.info (action.result.data);
					}
					berkaslist.do_refresh (Earsip.berkas.pid);
					form.reset ();
					berkasform.set_disabled (true);
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error ('Gagal menyimpan data berkas!');
			}
		});
	}
});
