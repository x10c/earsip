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
			'dirlist button[action=mkdir]': {
				click : this.do_mkdir
			}
		});
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
});
