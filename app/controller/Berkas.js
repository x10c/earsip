Ext.require ([
	'Earsip.view.Trash'
,	'Earsip.view.WinUpload'
]);

Ext.define ('Earsip.controller.Berkas', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
	},{
		ref		: 'berkas'
	,	selector: 'berkas'
	},{
		ref		: 'berkastree'
	,	selector: 'berkastree'
	},{
		ref		: 'berkaslist'
	,	selector: 'berkaslist'
	},{
		ref		: 'mkdirwin'
	,	selector: 'mkdirwin'
	}]
,	init	: function ()
	{
		this.control ({
			'berkas button[itemId=save]': {
				click : this.do_form_save
			}
		,	'berkastree': {
				selectionchange : this.tree_selectionchange
			}
		,	'berkastree button[itemId=refresh]': {
				click : this.tree_refresh
			}
		,	'berkastree button[itemId=trash]': {
				click : this.do_open_trash
			}
		,	'berkaslist' : {
				itemdblclick : this.list_itemdblclick
			,	selectionchange : this.list_selectionchange
			}
		,	'berkaslist button[itemId=mkdir]': {
				click : this.do_mkdir
			}
		,	'berkaslist button[itemId=upload]': {
				click : this.do_upload
			}
		,	'berkaslist button[itemId=refresh]': {
				click : this.list_refresh
			}
		,	'berkaslist button[itemId=dirup]' : {
				click : this.do_dirup
			}
		,	'berkaslist button[itemId=share]': {
				click : this.do_share
			}
		,	'berkaslist button[itemId=del]': {
				click : this.do_delete
			}
		,	'mkdirwin button[action=submit]' : {
				click : this.do_mkdir_submit
			}
		});
	}

,	do_form_save : function (b)
	{
		var form = this.getBerkas ().down ('#berkas_form').getForm ();

		if (! form.isValid ()) {
			return;
		}

		form.submit ({
			success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.Msg.alert ('Informasi', action.result.info);
				} else {
					Ext.Msg.alert ('Error', action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.Msg.alert ('Error', action.result.info);
			}
		});
	}

,	tree_selectionchange : function (tree, records, opts)
	{
		if (records.length > 0) {
			Earsip.berkas.id		= records[0].get ('id');
			Earsip.berkas.pid		= records[0].get ('parentId');
			Earsip.berkas.tree.id	= records[0].get ('id');
			Earsip.berkas.tree.pid	= records[0].get ('parentId');

			this.getBerkaslist ().do_load_list (Earsip.berkas.id);
		}
	}

,	tree_refresh : function ()
	{
		this.getBerkastree ().do_load_tree ();
	}

,	do_open_trash : function (b)
	{
		var tabpanel = this.getMainview ().down ('#content_tab');

		Earsip.acl = b.acl;

		var c = tabpanel.getComponent (b.itemId);
		if (c == undefined) {
			tabpanel.add ({
				xtype	: b.itemId
			});
		}
		tabpanel.setActiveTab (b.itemId);
	}

,	list_itemdblclick : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}

		Earsip.berkas.id	= r.get ("id");
		Earsip.berkas.pid	= r.get ("pid");

		var berkastree	= this.getBerkastree ();
		var node		= berkastree.getRootNode ().findChild ('id', Earsip.berkas.id, true);

		berkastree.expandAll ();
		berkastree.getSelectionModel ().select (node);
	}

,	list_selectionchange : function (model, records)
	{
		var berkaslist = this.getBerkaslist ();

		if (records.length > 0) {
			this.getMainview ().down ('#berkas_form').loadRecord (records[0]);
			berkaslist.record	= records[0];
			Earsip.berkas.id	= records[0].get ('id');
			Earsip.berkas.pid	= records[0].get ('pid');
		}

		berkaslist.down ('#del').setDisabled (! records.length);
		berkaslist.down ('#share').setDisabled (! records.length);
	}

,	do_mkdir : function (b)
	{
		if (Earsip.berkas.tree.id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih tempat untuk direktori baru terlebih dahulu!');
			return;
		}
		var berkaslist	= this.getBerkaslist ();
		var tgl_dibuat	= berkaslist.win.down ('#tgl_dibuat');

		tgl_dibuat.setValue (new Date ());

		berkaslist.win.show ();
	}

,	do_upload : function (b)
	{
		if (Earsip.berkas.tree.id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih direktori penyimpanan terlebih dahulu!');
			return;
		}

		var winupload = Ext.create ('Earsip.view.WinUpload');
		winupload.show ();
	}

,	list_refresh : function (b)
	{
		this.getBerkaslist ().do_load_list (Earsip.berkas.tree.id);
	}

,	do_dirup : function (b)
	{
		if (Earsip.berkas.tree.pid == 0) {
			return;
		}

		var berkastree	= this.getBerkastree ();
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

,	do_share : function (b)
	{
		var berkaslist = this.getBerkaslist ();

		Earsip.acl = 4;
		berkaslist.win_share.load (berkaslist.record);
		berkaslist.win_share.show ();
	}

,	do_delete : function (b)
	{
		var form			= this.getMainview ().down ('#berkas_form');
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
			,	success	: function (form, action)
				{
					if (action.result.success == true) {
						this.getBerkaslist ().do_load_list (Earsip.berkas.tree.id);
						Ext.Msg.alert ('Informasi', action.result.info);
					} else {
						Ext.Msg.alert ('Kesalahan', action.result.info);
					}
				}
			,	failure	: function (form, action)
				{
					Ext.Msg.alert ('Kesalahan', action.result.info);
				}
			});
		}
		, this);
	}

,	do_mkdir_submit : function (button)
	{
		var win		= button.up ('#mkdirwin');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.Msg.alert ('Kesalahan', 'Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		form.submit ({
			scope	: this
		,	params	: {
				berkas_id	: Earsip.berkas.tree.id
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					this.getBerkastree ().do_load_tree ();
					win.hide ();
				} else {
					Ext.Msg.alert ('Kesalahan', action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.Msg.alert ('Kesalahan', action.result.info);
			}
		});
	}
});
