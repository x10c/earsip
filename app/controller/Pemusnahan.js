Ext.require ([
	'Earsip.store.PemusnahanRinci'
,	'Earsip.store.TimPemusnahan'
,	'Earsip.store.BerkasMusnah'
]);

Ext.define ('Earsip.controller.Pemusnahan', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'trans_pemusnahan'
	,	selector: 'trans_pemusnahan'
	}]

,	init	: function ()
	{
		this.control ({
			'trans_pemusnahan #pemusnahan_grid': {
				selectionchange : this.user_select
			}
		,	'trans_pemusnahan grid': {
				beforeedit		: this.do_select
			}
		,	'trans_pemusnahan #pemusnahan_grid button[action=add]': {
				click : this.do_add_pemusnahan
			}
		,	'trans_pemusnahan #pemusnahan_grid button[action=edit]': {
				click : this.do_edit_pemusnahan
			}
		,	'trans_pemusnahan #pemusnahan_grid button[action=refresh]': {
				click : this.do_refresh
			}
		,	'trans_pemusnahan #pemusnahan_grid button[action=print]': {
				click : this.do_print_pemusnahan
			}
		,	'trans_pemusnahan #pemusnahan_grid button[action=del]': {
				click : this.do_delete_pemusnahan
			}
		,	'trans_pemusnahan #pemusnahan_grid button[itemId=search]': {
				click : this.do_open_win_cari
			}
		,	'pemusnahan_win  textfield': {
				change: this.do_activate_grid
			}
		,	'pemusnahan_win grid': {
				itemdblclick: this.do_deactivate_editor
			}
		,	'pemusnahan_win #berkas_musnah_grid button[action=add]': {
				click : this.do_add_berkas
			}
		,	'pemusnahan_win #berkas_musnah_grid button[action=del]': {
				click : this.do_delete_berkas
			}
		,	'pemusnahan_win #tim_pemusnah_grid button[action=add]': {
				click : this.do_add_tim
			}
		,	'pemusnahan_win #tim_pemusnah_grid button[action=del]': {
				click : this.do_delete_tim
			}
		,	'pemusnahan_win button[action=submit]': {
				click : this.do_pemusnahan_submit
			}
		,	'caripemusnahanwin button[itemId=cari]' : {
				click	: this.do_cari
			}
		});

		var form = this
	}

,	user_select : function (sm, records)
	{
		var panel = this.getTrans_pemusnahan ();
		var grid = panel.down ('#pemusnahan_grid');
		var b_edit		= grid.down ('#edit');
		var b_del		= grid.down ('#del');
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);

		if (records.length > 0) {
			if (panel.win == undefined) {
				panel.win = Ext.create ('Earsip.view.PemusnahanWin', {});
			}
			panel.win.load (records[0]);
		}
	}
	
,	do_select	: function (editor, o)
	{
		return false;
	}

,	do_add_pemusnahan: function (button)
	{
		var panel = this.getTrans_pemusnahan ();
		var grid  = panel.down ('#pemusnahan_grid');
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemusnahanWin', {});
		}

		var grid_berkas = panel.win.down ('#berkas_musnah_grid');
		var grid_tim = panel.win.down ('#tim_pemusnah_grid');
		var form = panel.win.down ('form').getForm ();
		grid.getSelectionModel (). deselectAll ();
		form.reset ();
		panel.win.down ('#nama_petugas').setValue (Earsip.username);
		grid_berkas.getStore ().load();
		grid_tim.getStore ().load();
		panel.win.show ();
		panel.win.action = 'create';
		
	}

,	do_refresh : function (button)
	{
		this.getTrans_pemusnahan ().down ('#pemusnahan_grid').getStore ().load ();
		this.getTrans_pemusnahan ().down ('#tim_pemusnah_grid').getStore ().load ();
		this.getTrans_pemusnahan ().down ('#berkas_musnah_grid').getStore ().load ();
		
	}
	
,	do_edit_pemusnahan: function (button)
	{
		var panel = this.getTrans_pemusnahan ();
		if (panel.win == undefined) {
			panel.win = Ext.create ('Earsip.view.PemusnahanWin', {});
		}
		panel.win.show ();
		panel.win.action = 'update';
	}

,	do_print_pemusnahan: function (button)
	{
		var grid = button.up ('#pemusnahan_grid');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}
		
		new Ext.Window({
			title	: 'Report Pemusnahan'
		,	height 	: 600
		, 	width	: 700 
		,	movable	: true
		,	modal	: true,
			items: [{
				xtype : 'component'
			,	autoEl : {
					tag		: 'iframe'
				,	src		: 'data/bapemusnahanreport_submit.jsp?pemusnahan_id=' + data[0].get ('id')
				,	height 	: '100%'
				,	width	: '100%'
				, 	style: 'border: 0 none'
				}
			}]
		}).show();
	}
	
	
, 	do_delete_pemusnahan	: function (button)
	{	
		var grid = button.up ('#pemusnahan_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}

,	do_open_win_cari	: function (button)
	{
		var panel	= this.getTrans_pemusnahan ();
		if (Ext.getCmp ('caripemusnahanwin') == undefined)
		{
			panel.win_cari = Ext.create ('Earsip.view.CariPemusnahanWin', {});	
		}
		panel.win_cari.show ();
		
	}

,	do_activate_grid : function (textfield)
	{	
		var win	 = textfield.up ('#pemusnahan_win');
		var form = win.down ('form').getForm ();
		var grid_tim = win.down ('#tim_pemusnah_grid');
		var grid_berkas = win.down ('#berkas_musnah_grid');
		grid_tim.setDisabled (!form.isValid ()); 
		grid_berkas.setDisabled (!form.isValid ()); 
	}

,	do_deactivate_editor : function (v, record, item,index, e)
	{
		var editor	= v.up ('grid').getPlugin ('roweditor');
		editor.cancelEdit ();
	}
	
, 	do_add_berkas	: function (button)
	{	
		
		var grid	= button.up ('#berkas_musnah_grid');
		var editor	= grid.getPlugin ('roweditor');
		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.PemusnahanRinci', {});
		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
		Ext.data.StoreManager.lookup ('BerkasMusnah').filter ('arsip_status_id',0);
		
	}

, 	do_add_tim	: function (button)
	{	
		
		var grid	= button.up ('#tim_pemusnah_grid');
		var editor	= grid.getPlugin ('roweditor');
		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.TimPemusnahan', {});
		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
	}
	

, 	do_delete_berkas	: function (button)
	{	
		var grid = button.up ('#berkas_musnah_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

, 	do_delete_tim	: function (button)
	{	
		var grid = button.up ('#tim_pemusnah_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}


,	do_pemusnahan_submit	: function (button)
	{
		var grid	= this.getTrans_pemusnahan ().down ('#pemusnahan_grid');
		var win		= button.up ('#pemusnahan_win');
		var form	= win.down ('form').getForm ();
		var grid_berkas 	= win.down ('#berkas_musnah_grid');
		var grid_tim	 	= win.down ('#tim_pemusnah_grid');
		var records_berkas = grid_berkas.getStore ().getRange ();
		var records_tim = grid_tim.getStore ().getRange ();

		if ((! form.isValid ())) {
			Ext.msg.error('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}
		
		if (records_tim.length <= 0){
			Ext.msg.error('Silahkan isi tabel Tim Pemusnah');
			return;
		}
		if (records_berkas.length <= 0){
			Ext.msg.error ('Silahkan isi  tabel Berkas');
			return;
		}
		
		
		form.submit ({
			scope	: this
		,	params	: {
				action		: win.action
			,	nama_petugas: Earsip.username
			,	berkas		: Ext.encode(Ext.pluck(records_berkas, 'data'))
			,	tims		: Ext.encode(Ext.pluck(records_tim, 'data'))
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					win.close ();
					Ext.StoreManager.lookup ('BerkasMusnah').load ();
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error (action.result.info);
			}
		});
	}

,	do_cari	: function (button)
	{
		var form 	= button.up ('#caripemusnahanwin').down ('form').getForm ();
		var grid 	= this.getTrans_pemusnahan ().down ('#pemusnahan_grid');
		var store	= grid.getStore ();
		var proxy	= store.getProxy ();
		var org_url = proxy.api.read;
		
		proxy.api.read	= 'data/caripemusnahan.jsp';
		
		store.load ({
			params	:	form.getValues ()
		});
		
		proxy.api.read	= org_url;
	}
});
