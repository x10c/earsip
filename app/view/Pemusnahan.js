Ext.require ([
	'Earsip.store.MetodaPemusnahan'
,	'Earsip.store.Pemusnahan'
,	'Earsip.view.PemusnahanWin'
]);

Ext.define ('Earsip.view.Pemusnahan', {
	extend	: 'Ext.panel.Panel'
,	alias	: 'widget.trans_pemusnahan'
,	itemId	: 'trans_pemusnahan'
,	title	: 'Pemusnahan'
,	plain	: true
,	layout	: 'border'
,	closable : true
, 	defaults	: {
		split	: true
	,	autoScroll : true
	}
,	items	: [{
		xtype			: 'grid'
	,	itemId			: 'pemusnahan_grid'
	,	alias			: 'widget.pemusnahan_grid'
	,	title			: 'Daftar Pemusnahan'
	,	region			: 'center'
	,	flex			: 0.5
	,	store			: 'Pemusnahan'
	,	plugins		: [
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Metode Pemusnahan'
		,	dataIndex	: 'metoda_id'
		,	flex		: 0.5
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.create ('Earsip.store.MetodaPemusnahan', {
					autoLoad		: true
				})
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	mode			: 'local'
			,	typeAhead		: false
			,	triggerAction	: 'all'
			,	lazyRender		: true
			}
		,	renderer	: function (v, md, r, rowidx, colidx)
			{
				return combo_renderer (v, this.columns[colidx]);
			}
		},{
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		},{
			text			: 'Tanggal Pemusnahan'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'Penanggung Jawab Unit Kerja'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		},{
			text			: 'Penanggung Jawab Pusat Berkas/Arsip'
		,	dataIndex		: 'pj_berkas_arsip'
		,	flex			: 0.5
		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Tambah'
			,	itemId		: 'add'
			,	iconCls		: 'add'
			,	action		: 'add'
			},'-',{
				text		: 'Ubah'
			,	itemId		: 'edit'
			,	iconCls		: 'edit'
			,	action		: 'edit'
			,	disabled	: true
			},'-',{
				text		: 'Refresh'
			,	itemId		: 'refresh'
			,	iconCls		: 'refresh'
			,	action		: 'refresh'
			},'-','->','-',{
				text		: 'Cari'
			,	itemId		: 'search'
			,	iconCls		: 'search'
			},'-',{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
			},'-',{
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			}]
		}]
	},{
		xtype	: 'tabpanel'
	,	region	: 'south'
	,	flex	: 0.5
	,	items	: [{
			xtype	: 'grid'
		,	itemId	: 'tim_pemusnah_grid'
		,	alias	: 'widget.tim_pemusnah_grid'
		,	title	: 'Tim Pemusnah'
		,	store	: 'TimPemusnahan'
		,	columns	: [{
				xtype	 : 'rownumberer'
			},{
				text	 : 'Nama Anggota Tim'
			,	dataIndex: 'nama'
			,	flex	 : 1
			},{
				text	 	: 'Jabatan'
			,	dataIndex	: 'jabatan'
			,	flex	 	: 1
			}]
		},{
			xtype	: 'grid'
		,	itemId	: 'berkas_musnah_grid'
		,	alias	: 'widget.berkas_musnah_grid'
		,	title	: 'Daftar Berkas'
		,	store	: 'PemusnahanRinci'
		,	columns	: [{
				xtype	 : 'rownumberer'
			},{
				text	 	: 'Berkas'
			,	dataIndex	: 'nama'
			,	flex	 	: 1
			},{
				text	 	: 'Keterangan'
			,	dataIndex	: 'keterangan'
			,	flex	 	: 2
			},{
				text	 	: 'Jumlah Lembar'
			,	dataIndex	: 'jml_lembar'
			,	width	 	: 110
			},{
				text	 	: 'Jumlah Set'
			,	dataIndex	: 'jml_set'
			,	width	 	: 80
			},{
				text	 	: 'Jumlah Berkas'
			,	dataIndex	: 'jml_berkas'
			,	width	 	: 100
			}]
		}]
	}]

,	listeners		: {
		afterrender : function (comp)
		{
			if (Ext.getCmp ('pemusnahan_win')!= undefined)
				this.win = Ext.getCmp ('pemusnahan_win');

			this.down ('#pemusnahan_grid').getStore ().load ();
			this.down ('#tim_pemusnah_grid').getStore ().load ();
			Ext.StoreManager.lookup ('BerkasMusnah').load ({
				scope	: this
			,	callback: function (r, op, success){
					if (success)
					{
						this.down ('#berkas_musnah_grid').getStore ().load ();
					}
				}
			});
		}
	}

,	grid_on_selectionchange : function (sm, r)
	{
		var grid	= this.down ('#pemusnahan_grid');
		var b_edit	= grid.down ('#edit');
		var b_del	= grid.down ('#del');

		b_edit.setDisabled (! r.length);
		b_del.setDisabled (! r.length);

		if (r.length > 0) {
			this.win.load (r[0]);
		}
	}

,	grid_on_beforeedit: function (editor, o)
	{
		return false;
	}

,	do_add : function (b)
	{
		var grid  = this.down ('#pemusnahan_grid');
		var berkasmusnah_store = Ext.StoreManager.lookup ('BerkasMusnah');

		var grid_berkas = this.win.down ('#berkas_musnah_grid');
		var grid_tim = this.win.down ('#tim_pemusnah_grid');
		var form = this.win.down ('form').getForm ();

		grid.getSelectionModel (). deselectAll ();
		form.reset ();

		this.win.down ('#nama_petugas').setValue (Earsip.username);

		berkasmusnah_store.filter ('arsip_status_id',0);
		berkasmusnah_store.load ();

		grid_berkas.getStore ().load();
		grid_tim.getStore ().load();

		this.win.show ();
		this.win.action = 'create';
	}

,	do_refresh : function (b)
	{
		this.down ('#pemusnahan_grid').getStore ().load ();
		this.down ('#tim_pemusnah_grid').getStore ().load ();
		this.down ('#berkas_musnah_grid').getStore ().load ();
	}

,	do_edit : function (b)
	{
		this.win.show ();
		this.win.action = 'update';
	}

,	do_print : function (b)
	{
		var grid = b.up ('#pemusnahan_grid');
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}
		var url = 'data/bapemusnahanreport_submit.jsp?pemusnahan_id=' + data[0].get ('id');
		window.open (url);
	}

, 	do_delete : function (b)
	{
		var grid = b.up ('#pemusnahan_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus berkas?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}
			var store = grid.getStore ();
			store.remove (data);
			store.sync ();
		},this);
	}

,	do_open_win_search	: function (button)
	{
		this.win_cari.show ();
	}

,	win_on_validitychange : function (form, valid)
	{
		this.win.down ('#tim_pemusnah_grid').setDisabled (! valid);
		this.win.down ('#berkas_musnah_grid').setDisabled (! valid);
	}

,	win_on_itemdblclick : function (v, r, item, idx)
	{
		var editor = v.up ('grid').getPlugin ('roweditor');
		editor.cancelEdit ();
	}

, 	win_berkas_do_add : function (b)
	{	
		var grid	= b.up ('#berkas_musnah_grid');
		var editor	= grid.getPlugin ('roweditor');
		var r		= Ext.create ('Earsip.model.PemusnahanRinci', {});

		editor.cancelEdit ();

		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
		Ext.data.StoreManager.lookup ('BerkasMusnah').filter ('arsip_status_id',0);
	}

, 	win_berkas_do_delete : function (b)
	{	
		var grid = b.up ('#berkas_musnah_grid');
		var data = grid.getSelectionModel ().getSelection ();
		var store = grid.getStore ();

		if (data.length <= 0) {
			return;
		}

		store.remove (data);
	}

, 	win_tim_do_add : function (b)
	{	
		
		var grid	= b.up ('#tim_pemusnah_grid');
		var editor	= grid.getPlugin ('roweditor');
		var r		= Ext.create ('Earsip.model.TimPemusnahan', {});

		editor.cancelEdit ();
		grid.getStore ().insert (0, r);
		editor.action = 'add';
		editor.startEdit (0, 0);
	}

, 	win_tim_do_delete : function (b)
	{	
		var grid = b.up ('#tim_pemusnah_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
	}

,	win_do_submit : function (b)
	{
		var grid			= this.down ('#pemusnahan_grid');
		var form			= this.win.down ('form').getForm ();
		var grid_berkas		= this.win.down ('#berkas_musnah_grid');
		var grid_tim		= this.win.down ('#tim_pemusnah_grid');
		var records_berkas	= grid_berkas.getStore ().getRange ();
		var records_tim		= grid_tim.getStore ().getRange ();

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
				action		: this.win.action
			,	nama_petugas: Earsip.username
			,	berkas		: Ext.encode(Ext.pluck(records_berkas, 'data'))
			,	tims		: Ext.encode(Ext.pluck(records_tim, 'data'))
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					this.win.close ();
					Ext.StoreManager.lookup ('BerkasMusnah').load ();
					Ext.getStore ('Pemusnahan').load ();
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

,	win_cari_do_search : function (b)
	{
		var form 	= this.win_cari.down ('form').getForm ();
		var grid 	= this.down ('#pemusnahan_grid');
		var store	= grid.getStore ();
		var proxy	= store.getProxy ();
		var org_url = proxy.api.read;

		proxy.api.read	= 'data/caripemusnahan.jsp';

		store.load ({
			params	:	form.getValues ()
		});

		proxy.api.read	= org_url;
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		if (this.win == undefined) {
			this.win = Ext.create ('Earsip.view.PemusnahanWin', {});
		}

		if (this.win_cari == undefined) {
			this.win_cari = Ext.create ('Earsip.view.CariPemusnahanWin', {});
		}

		this.down ("#pemusnahan_grid").on ("selectionchange", this.grid_on_selectionchange, this);
		this.down ("#pemusnahan_grid").on ("beforeedit", this.grid_on_beforeedit, this);

		this.down ("#add").on ("click", this.do_add, this);
		this.down ("#refresh").on ("click", this.do_refresh, this);
		this.down ("#edit").on ("click", this.do_edit, this);
		this.down ("#print").on ("click", this.do_print, this);
		this.down ("#del").on ("click", this.do_delete, this);
		this.down ("#search").on ("click", this.do_open_win_search, this);

		this.win.down ("#pemusnahan_win_form").on ("validitychange", this.win_on_validitychange, this);
		this.win.down ("grid").on ("itemdblclick", this.win_on_itemdblclick, this);

		this.win.down ("#berkas_musnah_grid").down ("#add").on ("click", this.win_berkas_do_add, this);
		this.win.down ("#berkas_musnah_grid").down ("#del").on ("click", this.win_berkas_do_delete, this);

		this.win.down ("#tim_pemusnah_grid").down ("#add").on ("click", this.win_tim_do_add, this);
		this.win.down ("#tim_pemusnah_grid").down ("#del").on ("click", this.win_tim_do_delete, this);

		this.win.down ("#save").on ("click", this.win_do_submit, this);

		this.win_cari.down ("#cari").on ("click", this.win_cari_do_search, this);
	}
});
