Ext.require ('Earsip.view.WinUpload');

Ext.define ('Earsip.controller.DirList', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'dirtree'
	,	selector: 'dirtree'
	},{
		ref		: 'dirlist'
	,	selector: 'dirlist'
	}]
,	init	: function ()
	{
		this.control ({
			'dirlist' : {
				itemdblclick : this.row_clicked
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
		});
	}

,	row_clicked : function (v, r, idx)
	{
		var t = r.get ("node_type");
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
		Ext.Msg.prompt ('Buat direktori baru', 'Nama direktori:', function (btn, text) {
			if (btn == 'cancel') {
				return;
			}
			if (btn == 'ok' && text == '') {
				return;
			}

			Ext.Ajax.request ({
				url		: 'data/mkdir.jsp'
			,	scope	: this
			,	params	: {
					pid		: Earsip.dir_id
				,	name	: text
				,	path	: Earsip.tree_path
				}
			,	success	: function (response) {
					var o = Ext.decode(response.responseText);
					if (o.success == true) {
						this.getDirtree ().do_load_tree ();
						this.getDirtree ().expandAll ();
						this.getDirlist ().do_load_list (Earsip.dir_id);
					} else {
						Ext.Msg.alert ('Kesalahan', o.info);
					}
				}
			,	failure	: function (response) {
					Ext.Msg.alert ('Kesalahan', 'Server error: data menu tidak dapat diambil!');
				}
			});
		}
		, this);
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
});
