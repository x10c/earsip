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
	,	dockedItems	:
		[{
			xtype		:"toolbar"
		,	dock		:"bottom"
		,	itemId		:"bar_mkdir"
		,	hidden		:true
		,	items		:
			[{
				xtype		:"button"
			,	text		:"Batal"
			,	itemId		:"mkdir_cancel"
			,	iconCls		:"del"
			,	handler		:function (b)
				{
					var berkas = b.up ("#berkas");
					var form = berkas.down ("#berkasform");

					berkas.down ("#berkastree").setDisabled (false);
					berkas.down ("#berkaslist").setDisabled (false);
					form.set_disabled (true);
					form.down ("#bar_mkdir").hide ();
					form.down ("#bar_default").show ();
				}
			},"-","->","-",{
				xtype		:"button"
			,	text		: 'Folder baru'
			,	itemId		: 'mkdir'
			,	iconCls		: 'add'
			,	handler		:function (b)
				{
					b.up ('#berkas').form_do_mkdir ();
				}
			}]
		},{
			xtype	:"toolbar"
		,	dock	:"bottom"
		,	itemId	:"bar_default"
		,	hidden	:false
		,	items	:
			[{
				xtype		:"button"
			,	text		:"Ubah data"
			,	itemId		:"edit"
			,	iconCls		:"edit"
			,	handler		:function (b)
				{
					b.up ('#berkas').form_do_edit ();
				}
			}]
		},{
			xtype	:"toolbar"
		,	dock	:"bottom"
		,	itemId	:"bar_edit"
		,	hidden	:true
		,	items	:
			[{
				xtype		:"button"
			,	text		:"Batal"
			,	itemId		:"edit_cancel"
			,	iconCls		:"del"
			,	handler		:function (b)
				{
					var berkas = b.up ("#berkas");
					var form = b.up ("#berkasform");

					berkas.down ("#berkaslist").setDisabled (false);
					berkas.down ("#berkastree").setDisabled (false);

					form.down ("#bar_edit").hide ();
					form.down ("#bar_default").show ();
					form.set_disabled (true);
				}
			},"-","->","-",{
				xtype		:"button"
			,	text		:"Simpan"
			,	itemId		:"save"
			,	iconCls		:"save"
			,	handler		:function (b)
				{
					b.up ('#berkas').form_do_save ();
				}
			}]
		}]
	}]

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

		berkasform.down ("#bar_default").hide ();
		berkasform.down ("#bar_mkdir").show ();
		this.down ("#berkaslist").setDisabled (true);
		this.down ("#berkastree").setDisabled (true);
	}

,	form_do_edit	: function ()
	{
		var berkasform	= this.down ('#berkasform');

		berkasform.getForm ().url = 'data/berkas_submit.jsp';
		berkasform.set_disabled (false);
		berkasform.down ('#bar_default').hide ();
		berkasform.down ('#bar_edit').show ();
		this.down ("#berkaslist").setDisabled (true);
		this.down ("#berkastree").setDisabled (true);
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
					berkastree.setDisabled (false);
					berkaslist.setDisabled (false);
					berkasform.down ("#bar_mkdir").hide ();
					berkasform.down ("#bar_default").show ();
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
		var berkastree	= this.down ("#berkastree");
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
					berkastree.do_refresh ();
					berkaslist.do_refresh (Earsip.berkas.pid);
					form.reset ();
					berkasform.set_disabled (true);
					berkasform.down ("#bar_edit").hide ();
					berkasform.down ("#bar_default").show ();
					berkaslist.setDisabled (false);
					berkastree.setDisabled (false);
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

,	tree_on_selectionchange : function (tree, r)
	{
		if (r.length <= 0) {
			return;
		}

		Earsip.berkas.id		= r[0].get ('id');
		Earsip.berkas.pid		= r[0].get ('parentId');
		Earsip.berkas.tree.id	= r[0].get ('id');
		Earsip.berkas.tree.pid	= r[0].get ('parentId');

		this.down ("#berkaslist").do_refresh ();
	}

,	list_on_itemdblclick : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			Earsip.win_viewer.down ('#download').show ();
			Earsip.win_viewer.do_open (r);
			return;
		}

		Earsip.berkas.id	= r.get ("id");
		Earsip.berkas.pid	= r.get ("pid");

		var berkastree	= this.down ("#berkastree");
		var node		= berkastree.getRootNode ().findChild ('id', Earsip.berkas.id, true);

		berkastree.expandAll ();
		berkastree.getSelectionModel ().select (node);
	}

,	do_upload : function (b)
	{
		if (Earsip.berkas.tree.id <= 0) {
			Ext.msg.error ('Pilih direktori penyimpanan terlebih dahulu!');
			return;
		}

		this.win_upload.show ();
	}

,	list_do_refresh : function (b)
	{
		var form	= this.down ("#berkasform");
		var bform	= form.getForm ();

		this.down ("#berkaslist").do_refresh ();

		bform.reset ();
		form.set_disabled (true);
	}

,	list_do_dirup : function (b)
	{
		if (Earsip.berkas.tree.pid == 0) {
			return;
		}

		var berkastree	= this.down ("#berkastree");
		var root		= berkastree.getRootNode ();
		var node		= null;

		if (root.get ('id') == Earsip.berkas.tree.pid) {
			node = root;
		} else {
			node = root.findChild ('id', Earsip.berkas.tree.pid, true);
		}

		berkastree.expandAll ();
		berkastree.getSelectionModel ().select (node);
	}

,	list_open_search_win : function (b)
	{
		this.win_search.show ();
	}

,	list_open_share_win : function (b)
	{
		var berkaslist = this.down ("#berkaslist");

		Earsip.acl = 4;
		this.win_share.load (berkaslist.record);
		this.win_share.show ();
	}

,	list_do_delete : function (b)
	{
		var form			= this.down ('#berkasform');
		var stat_hapus_f	= form.getComponent ('status_hapus');

		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus berkas?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}

			stat_hapus_f.setValue (0);

			form.submit ({
				scope	: this
			,	url		: 'data/berkas_submit.jsp'
			,	success	: function (form, action)
				{
					if (action.result.success == true) {
						this.down ("#berkastree").do_refresh ();
						this.down ("#berkaslist").do_refresh ();
						form.reset ();
						Ext.msg.info (action.result.info);
					} else {
						Ext.msg.error (action.result.info);
					}
				}
			,	failure	: function (form, action)
				{
					Ext.msg.error ('Gagal menghapus berkas!');
				}
			});
		}
		, this);
	}

,	berkasform_on_select_berkas_klas : function (cb, r)
	{
		var berkasform = this.down ("#berkasform");

		berkasform.down ('#jra_aktif').setValue (r[0].get ('jra_aktif'));
		berkasform.down ('#jra_inaktif').setValue (r[0].get ('jra_inaktif'));
	}

,	berkasform_open_indeks_relatif_win : function (comp)
	{
		this.win_ir.show ();
	}

,	do_search : function (b)
	{
		var cariform	= this.win_search.down ('form').getForm ();
		var list		= this.down ("#berkaslist");
		var list_store	= list.getStore ();
		var list_proxy	= list_store.getProxy ();
		var org_url		= list_proxy.url;

		list_proxy.url = 'data/cariberkas.jsp'

		list_store.load ({
			params	: cariform.getValues ()
		});

		list_proxy.url = org_url;
	}

,	win_upload_on_close : function (win)
	{
		this.down ("#berkaslist").do_refresh ();
	}

,	win_share_do_add_pegawai : function (b)
	{
		var grid	= b.up ('#berkasberbagi_win_grid');
		var editor	= grid.getPlugin ('roweditor');
		var peg		= Ext.getStore ('Pegawai').getAt (0);
		var peg_id	= 0;

		if (peg) {
			peg_id = peg.get ('id');
		}

		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.BerkasBerbagi', {
				id				: 0
			,	berkas_id		: Earsip.berkas.id
			,	bagi_ke_peg_id	: peg_id
			,	hak_akses_id	: Earsip.share.hak_akses_id
			});

		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
	}

,	win_share_do_del_pegawai : function (b)
	{
		var grid = b.up ('#berkasberbagi_win_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

,	win_share_do_submit : function (b)
	{
		var win		= b.up ('#berkasberbagi_win');
		var grid	= b.up ('form').down ('#berkasberbagi_win_grid');
		var records	= grid.getStore ().getRange ();
		var pegs	= [];

		if ((Earsip.share.hak_akses_id == 1
		|| Earsip.share.hak_akses_id == 2)
		&&  records.length <= 0) {
			Ext.msg.error ('Data pegawai kosong!');
			return;
		}

		if (Earsip.share.hak_akses_id == 1 || Earsip.share.hak_akses_id == 2) {
			for (var i = 0; i < records.length; i++) {
				pegs.push (records[i].get ('bagi_ke_peg_id'));
			}
			pegs.sort ();
		}

		Ext.Ajax.request ({
			url			: 'data/berkasberbagi_submit.jsp'
		,	params		: {
				berkas_id		: Earsip.berkas.id
			,	hak_akses_id	: Earsip.share.hak_akses_id
			,	bagi_ke_peg_id	: '['+ pegs +']'
			}
		,	scope		: this
		,	success		: function (resp)
			{
				var o = Ext.decode (resp.responseText);
				if (o.success == true) {
					this.down ("#berkaslist").do_refresh ();
					win.hide ();
				} else {
					Ext.msg.error (o.info);
				}
			}
		,	failure		: function (resp)
			{
				Ext.msg.error ('Tidak dapat membagi berkas. Koneksi ke server bermasalah.');
			}
		});
	}

,	win_share_do_akses_change : function (cb, r)
	{
		if (r.length <= 0) {
			return;
		}

		var form	= cb.up ('#berkasberbagi_win_form');
		var id		= r[0].get ('id');

		Earsip.share.hak_akses_id = id;

		if (id == 1 || id == 2) {
			form.down ('#berkasberbagi_win_grid').setDisabled (false);
		} else {
			form.down ('grid').setDisabled (true);
		}
	}

,	win_ir_on_ambil : function (btn)
	{
		var grid = this.win_ir.down ('#grid_ir');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var berkasform = this.down ("#berkasform");
		var combo_klas = berkasform.down ('#berkas_klas_id');
		var id = data[0].get ('berkas_klas_id');
		var r = combo_klas.getStore ().getById (id);
		combo_klas.setValue (id);
		this.berkasform_on_select_berkas_klas (combo_klas, new Array(r));
		this.win_ir.hide ();
	}

,	initComponent	: function()
	{
		this.callParent (arguments);

		this.down ('#berkasform').set_disabled (true);
		this.down ("#berkastree").on ("selectionchange", this.tree_on_selectionchange, this);

		this.down ("#berkaslist").on ("itemdblclick", this.list_on_itemdblclick, this);
		this.down ("#berkaslist").down ("#upload").on ("click", this.do_upload, this);
		this.down ("#berkaslist").down ("#refresh").on ("click", this.list_do_refresh, this);
		this.down ("#berkaslist").down ("#dirup").on ("click", this.list_do_dirup, this);
		this.down ("#berkaslist").down ("#search").on ("click", this.list_open_search_win, this);
		this.down ("#berkaslist").down ("#share").on ("click", this.list_open_share_win, this);
		this.down ("#berkaslist").down ("#del").on ("click", this.list_do_delete, this);

		this.down ("#berkasform").down ("#berkas_klas_id").on ("select", this.berkasform_on_select_berkas_klas, this);
		this.down ("#berkasform").down ("#indeks_relatif").on ("click", this.berkasform_open_indeks_relatif_win, this);

		if (this.win_search == undefined) {
			this.win_search = Ext.create ("Earsip.view.CariBerkasWin", {});

			this.win_search.down ("#cari").on ("click", this.do_search, this);
		}

		if (this.win_upload == undefined) {
			this.win_upload = Ext.create ('Earsip.view.WinUpload');

			this.win_upload.on ("close", this.win_upload_on_close, this);
		}

		if (this.win_share == undefined) {
			this.win_share = Ext.create ('Earsip.view.BerkasBerbagiWin', {});

			this.win_share.down ("#add").on ("click", this.win_share_do_add_pegawai, this);
			this.win_share.down ("#del").on ("click", this.win_share_do_del_pegawai, this);
			this.win_share.down ("#save").on ("click", this.win_share_do_submit, this);
			this.win_share.down ("#berkasberbagi_win_form").down ("#akses_berbagi_id").on ("select", this.win_share_do_akses_change, this);
		}

		if (this.win_ir == undefined) {
			this.win_ir = Ext.create ('Earsip.view.WinIndeksRelatif', {});

			this.win_ir.down ("#ambil").on ("click", this.win_ir_on_ambil, this);
		}
	}
});

//# sourceURL=app/view/Berkas.js
