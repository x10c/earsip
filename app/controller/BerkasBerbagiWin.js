Ext.define ('Earsip.controller.BerkasBerbagiWin', {
	extend		: 'Ext.app.Controller'
,	refs		: [{
		ref			: 'berkasberbagi_win'
	,	selector	: 'berkasberbagi_win'
	},{
		ref			: 'berkaslist'
	,	selector	: 'berkaslist'
	}]
,	init		: function ()
	{
		this.control ({
			'berkasberbagi_win button[itemId=add]' : {
				click : this.do_add_pegawai
			}
		,	'berkasberbagi_win button[itemId=del]' : {
				click : this.do_del_pegawai
			}
		,	'berkasberbagi_win button[itemId=save]' : {
				click : this.do_submit
			}
		,	'berkasberbagi_win combo[itemId=akses_berbagi_id]' : {
				select : this.do_akses_change
			}
		,	'berkasberbagi_win > berkasberbagi_win_grid > combo[itemId=pegawai]' : {
				select : this.do_pegawai_selected
			}
		});
	}

,	do_add_pegawai : function (b)
	{
		var grid	= b.up ('#berkasberbagi_win_grid');
		var editor	= grid.getPlugin ('roweditor');

		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.BerkasBerbagi', {
				id				: 0
			,	berkas_id		: Earsip.berkas.id
			,	bagi_ke_peg_id	: 0
			,	hak_akses_id	: Earsip.share.hak_akses_id
			});

		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
	}

,	do_del_pegawai : function (b)
	{
		var grid = b.up ('#berkasberbagi_win_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

,	do_submit : function (b)
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
					this.getBerkaslist ().do_load_list (Earsip.berkas.tree.id);
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

,	do_akses_change : function (cb, r)
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

,	do_pegawai_selected : function (cb, r)
	{
		/* filter data pegawai, minus selected data */
	}
});
