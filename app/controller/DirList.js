Ext.require ('Earsip.view.WinUpload');

Ext.define ('Earsip.controller.DirList', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'dirtree'
	,	selector: 'dirtree'
	},{
		ref		: 'dirlist'
	,	selector: 'dirlist'
	},{
		ref		: 'mkdirwin'
	,	selector: 'mkdirwin'
	}]
,	init	: function ()
	{
		this.control ({
			'dirlist' : {
				itemdblclick : this.row_dbl_clicked
			}
		,	'dirlist button[action=mkdir]': {
				click : this.do_mkdir
			}
		,	'dirlist button[action=upload]': {
				click : this.do_upload
			}
		,	'dirlist button[action=refresh]': {
				click : this.do_refresh
			}
		,	'mkdirwin button[action=submit]' : {
				click : this.do_mkdir_submit
			}
		});
	}

,	row_dbl_clicked : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}
		Earsip.dir_id = r.get ("id");

		var dirtree	= this.getDirtree ();
		var node	= dirtree.getRootNode ().findChild ('id', Earsip.dir_id, true);

		Earsip.repo_path = node.parentNode.getPath ("text");
		dirtree.expandAll ();
		dirtree.getSelectionModel ().select (node);
	}

,	do_mkdir : function (button)
	{
		if (Earsip.dir_id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih tempat untuk direktori baru terlebih dahulu!');
			return;
		}
		var dirlist		= this.getDirlist ();
		var tgl_dibuat	= dirlist.win.down ('#tgl_dibuat');

		tgl_dibuat.setValue (new Date ());

		dirlist.win.show ();
	}

,	do_upload : function (button)
	{
		if (Earsip.dir_id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih direktori penyimpanan terlebih dahulu!');
			return;
		}

		var winupload = Ext.create ('Earsip.view.WinUpload');
		winupload.show ();
	}

,	do_refresh : function (button)
	{
		this.getDirlist ().do_load_list (Earsip.dir_id);
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
				dir_id	: Earsip.dir_id
			,	path	: Earsip.tree_path
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					this.getDirlist ().do_load_list (Earsip.dir_id);
					this.getDirtree ().do_load_tree ();
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
