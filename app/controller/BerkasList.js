Ext.require ('Earsip.view.WinUpload');

Ext.define ('Earsip.controller.BerkasList', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
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
			'berkaslist' : {
				itemdblclick : this.row_dbl_clicked
			,	selectionchange : this.do_selectionchange
			}
		,	'berkaslist button[action=mkdir]': {
				click : this.do_mkdir
			}
		,	'berkaslist button[action=upload]': {
				click : this.do_upload
			}
		,	'berkaslist button[action=refresh]': {
				click : this.do_refresh
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

,	row_dbl_clicked : function (v, r, idx)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}
		Earsip.dir_id = r.get ("id");

		var berkastree	= this.getBerkastree ();
		var node		= berkastree.getRootNode ().findChild ('id', Earsip.dir_id, true);

		Earsip.tree_path = node.parentNode.getPath ("text");

		berkastree.expandAll ();
		berkastree.getSelectionModel ().select (node);
	}

,	do_selectionchange : function (model, records)
	{
		var berkaslist = this.getBerkaslist ();

		if (records.length > 0) {
			this.getMainview ().down ('#berkas_form').loadRecord (records[0]);
			berkaslist.record		= records[0];
			Earsip.berkas.id	= records[0].get ('id');
		} else {
			berkaslist.record		= null;
			Earsip.berkas.id	= 0;
		}
		berkaslist.down ('#del').setDisabled (! records.length);
		berkaslist.down ('#share').setDisabled (! records.length);
	}

,	do_mkdir : function (b)
	{
		if (Earsip.dir_id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih tempat untuk direktori baru terlebih dahulu!');
			return;
		}
		var berkaslist		= this.getBerkaslist ();
		var tgl_dibuat	= berkaslist.win.down ('#tgl_dibuat');

		tgl_dibuat.setValue (new Date ());

		berkaslist.win.show ();
	}

,	do_upload : function (b)
	{
		if (Earsip.dir_id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih direktori penyimpanan terlebih dahulu!');
			return;
		}

		var winupload = Ext.create ('Earsip.view.WinUpload');
		winupload.show ();
	}

,	do_refresh : function (b)
	{
		this.getBerkaslist ().do_load_list (Earsip.dir_id);
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
						this.getBerkaslist ().do_load_list (Earsip.dir_id);
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
				dir_id	: Earsip.dir_id
			,	path	: Earsip.tree_path
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					this.getBerkaslist ().do_load_list (Earsip.dir_id);
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
