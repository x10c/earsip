Ext.define ('Earsip.controller.ShareWin', {
	extend		: 'Ext.app.Controller'
,	refs		: [{
		ref			: 'sharewin'
	,	selector	: 'sharewin'
	},{
		ref			: 'berkaslist'
	,	selector	: 'berkaslist'
	}]
,	init		: function ()
	{
		this.control ({
			'sharewin button[itemId=add]' : {
				click : this.do_add_pegawai
			}
		,	'sharewin button[itemId=del]' : {
				click : this.do_del_pegawai
			}
		,	'sharewin button[itemId=save]' : {
				click : this.do_submit
			}
		,	'sharewin combo[itemId=akses_berbagi_id]' : {
				select : this.do_akses_change
			}
		,	'sharewin > sharewin_grid > combo[itemId=pegawai]' : {
				select : this.do_pegawai_selected
			}
		});
	}

,	do_add_pegawai : function (b)
	{
		var grid	= b.up ('#sharewin_grid');
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
		var grid = b.up ('#sharewin_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

,	do_submit : function (b)
	{
		var win		= b.up ('#sharewin');
		var grid	= b.up ('form').down ('#sharewin_grid');
		var records	= grid.getStore ().getRange ();
		var pegs	= [];

		if ((Earsip.share.hak_akses_id == 1
		|| Earsip.share.hak_akses_id == 2)
		&&  records.length <= 0) {
			Ext.Msg.alert ('Kesalahan', 'Data pegawai kosong!');
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
					this.getBerkaslist ().do_load_list (Earsip.berkas.id);
					win.hide ();
				} else {
					Ext.Msg.alert ('Kesalahan', o.info);
				}
			}
		,	failure		: function (resp)
			{
				Ext.Msg.alert ('Kesalahan', 'Tidak dapat membagi berkas. Hubungan ke server bermasalah.');
			}
		});
	}

,	do_akses_change : function (cb, r)
	{
		if (r.length <= 0) {
			return;
		}

		var form	= cb.up ('#sharewin_form');
		var id		= r[0].get ('id');

		Earsip.share.hak_akses_id = id;

		if (id == 1 || id == 2) {
			form.down ('#sharewin_grid').setDisabled (false);
		} else {
			form.down ('grid').setDisabled (true);
		}
	}

,	do_pegawai_selected : function (cb, r)
	{
		/* filter data pegawai, minus selected data */
	}
});
