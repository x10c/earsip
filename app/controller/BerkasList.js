Ext.require ([
	'Earsip.view.WinUpload'
]);

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
		,	'berkaslist button[itemId=mkdir]': {
				click : this.do_mkdir
			}
		,	'berkaslist button[itemId=upload]': {
				click : this.do_upload
			}
		,	'berkaslist button[itemId=refresh]': {
				click : this.do_refresh
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

,	row_dbl_clicked : function (v, r, idx)
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

,	do_selectionchange : function (model, records)
	{
		var berkaslist = this.getBerkaslist ();

		if (records.length > 0) {
			this.getMainview ().down ('#berkas_form').loadRecord (records[0]);
			berkaslist.record	= records[0];
			Earsip.berkas.id	= records[0].get ('id');
		}

		berkaslist.down ('#del').setDisabled (! records.length);
		berkaslist.down ('#share').setDisabled (! records.length);
	}

,	do_mkdir : function (b)
	{
		if (Earsip.berkas.id <= 0) {
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
		if (Earsip.berkas.id <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Pilih direktori penyimpanan terlebih dahulu!');
			return;
		}

		var winupload = Ext.create ('Earsip.view.WinUpload');
		winupload.show ();
	}

,	do_refresh : function (b)
	{
		this.getBerkaslist ().do_load_list (Earsip.berkas.id);
	}

,	do_dirup : function (b)
	{
		if (Earsip.berkas.pid == null) {
			return;
		}

		var berkastree	= this.getBerkastree ();
		var root		= berkastree.getRootNode ();
		var node		= null;

		if (root.get ('id') == Earsip.berkas.pid) {
			node = root;
		} else {
			node = root.findChild ('id', Earsip.berkas.pid, true);
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
						this.getBerkaslist ().do_load_list (Earsip.berkas.id);
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
				berkas_id	: Earsip.berkas.id
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					this.getBerkaslist ().do_load_list (Earsip.berkas.id);
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
