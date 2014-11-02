Ext.require ([
	'Earsip.view.PemindahanWin'
,	'Earsip.view.PemindahanRinciWin'
,	'Earsip.store.Pemindahan'
,	'Earsip.store.PemindahanRinci'
]);

Ext.define ('Earsip.view.Pemindahan', {
	extend 	: 'Ext.panel.Panel'
,	alias	: 'widget.trans_pemindahan'
,	itemId	: 'trans_pemindahan'
,	title	: 'Pemindahan'
,	closable: true
,	plain	: true
,	layout	: 'border'
,	defaults: {
		split		: true
	,	autoScroll	: true
	}
,	items	:[{
		xtype			: 'grid'
	,	alias			: 'widget.pemindahan_grid'
	,	itemId			: 'pemindahan_grid'
	,	title			: 'Daftar Pemindahan'
	,	store			: 'Pemindahan'
	,	region			: 'center'
	,	flex			: 1
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Unit Kerja'
		,	dataIndex	: 'unit_kerja_id'
		,	flex		: 0.5
		,	hidden		: true
		, 	hideable	: false
		},{
			text			: 'No Reg/ No Surat'
		,	dataIndex		: 'kode'
		,	flex			: 0.5
		},{
			text			: 'Tanggal'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'status'
		,	dataIndex		: 'status'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
		},{
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
		},{
			text			: 'Penanggung Jawab Pusat Berkas'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		},{
			text			: 'Penanggung Jawab Pusat Arsip'
		,	dataIndex		: 'pj_unit_arsip'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: true
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		,	width		: 120
		,	align		:'center'
		,	editor		: {
				xtype		: 'textfield'
			}
		,	renderer	: function (v)
			{
				if (v == 1) {
					return Ext.String.format( '<span style="color: green">{0}</span>', 'Lengkap');
				} else {
					return Ext.String.format( '<span style="color: red">{0}</span>', 'Tidak Lengkap');
				}
			}
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
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			}]
		}]
	},{
		xtype			: 'grid'
	,	alias			: 'widget.berkas_pindah_grid'
	,	itemId			: 'berkas_pindah_grid'
	,	title			: 'Daftar Berkas'
	,	store			: 'PemindahanRinci'
	,	region			: 'south'
	,	flex			: 1
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'pemindahan_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Berkas'
		,	dataIndex	: 'nama'
		,	flex		: 1
		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Tambah'
			,	itemId		: 'add'
			,	iconCls		: 'add'
			,	action		: 'add'
			,	disabled	: true
			},{
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			},{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
			}]
		}]
	}]

,	listeners		:
	{
		activate		: function (comp)
		{
			var grid = this.down ('#pemindahan_grid');
			grid.getStore ().load ();
			grid = this.down ('#berkas_pindah_grid');
			grid.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}

,	master_on_selectionchange : function (sm, r)
	{
		var grid		= this.down ('#pemindahan_grid');
		var grid_rinci	= this.down ('#berkas_pindah_grid');
		var b_edit		= grid.down ('#edit');
		var b_del		= grid.down ('#del');
		var b_add_rinci	= grid_rinci.down ('#add');

		b_edit.setDisabled (! r.length);
		b_del.setDisabled (! r.length);

		if (r.length > 0) {
			b_edit.setDisabled (r[0].get ('status'));
			b_del.setDisabled (r[0].get ('status'));
			b_add_rinci.setDisabled (r[0].get ('status'));

			idc = r[0].get ('id');

			this.win.down ('form').loadRecord (r[0]);

			grid_rinci.params = {
				pemindahan_id : r[0].get ('id')
			}
			grid_rinci.getStore ().load ({
				params	: grid_rinci.params
			});
		}
	}

,	master_do_add : function (b)
	{
		this.win.down ('form').getForm ().reset ();
		this.win.show ();
		this.win.action = 'create';
	}

,	master_do_refresh : function (b)
	{
		this.down ('#berkas_pindah_grid').getStore ().load ();
		this.down ('#pemindahan_grid').getStore ().load ();
	}

,	master_do_edit : function (b)
	{
		this.win.action = 'update';
		this.win.show ();
	}

,	master_do_delete : function (b)
	{
		var grid		= this.down ('#pemindahan_grid');
		var grid_rinci	= this.down ('#berkas_pindah_grid');
		var data		= grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ({
			scope	:this
		,	success	:function ()
			{
				grid_rinci.getStore ().loadData ([], false);
				Ext.msg.info ("Data telah dihapus");
			}
		,	failure	:function ()
			{
				Ext.msg.error ("Gagal menghapus data.");
			}
		});
	}

,	detail_on_selectionchange : function (sm, r)
	{
		var grid_pindah	= this.down ('#pemindahan_grid');
		var grid		= this.down ('#berkas_pindah_grid');
		var b_del		= grid.down ('#del');
		var record		= grid_pindah.getSelectionModel (). getSelection();
		var status		= record[0]!=null?record[0].get('status'):0;

		b_del.setDisabled (!(r.length && !status));
	}

,	detail_do_add : function (b)
	{
		this.win_rinci.down ('form').getForm ().reset ();
		this.win_rinci.down ('#pemindahan_id').setValue (idc);
		this.win_rinci.show ();
		this.win_rinci.action = 'create';
	}

,	detail_do_delete : function (b)
	{
		var grid = b.up ('#berkas_pindah_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var store = grid.getStore ();
		store.remove (data);
		store.sync ();
	}

,	detail_do_print : function (b)
	{
		var grid_pemindahan = this.down ('#pemindahan_grid');
		var grid = b.up ('#berkas_pindah_grid');
		var data = grid_pemindahan.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}
		
		if (grid.getStore ().getRange ().length <=0) {
			return;
		}
		var url = 'data/listberkaspindahreport_submit.jsp?pemindahan_id=' + data[0].get ('id');
		window.open (url);
	}

,	win_do_submit : function (b)
	{
		var grid	= this.down ('#pemindahan_grid');
		var win		= b.up ('#pemindahan_win');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		form.submit ({
			scope	: this
		,	params	: {
				action	: this.win.action
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					form.reset ();
					grid.getStore ().load ();
					this.win.hide ();
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

,	win_rinci_do_submit : function (b)
	{
		var grid	= this.down ('#berkas_pindah_grid');
		var form	= this.win_rinci.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		form.submit ({
			scope	: this
		,	params	: {
				action	: this.win_rinci.action
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					form.reset ();
					this.win_rinci.hide ();
					Ext.getStore ('BerkasPindah').load ();
					this.win_rinci.down ('#pemindahan_id').setValue (idc);

					grid.params = {
						pemindahan_id : idc
					}
					grid.getStore ().load ({
						params	: grid.params
					});
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

,	initComponent : function (opt)
	{
		this.callParent (opt);

		if (this.win == undefined) {
			this.win = Ext.create ('Earsip.view.PemindahanWin', {});
		}

		if (this.win_rinci == undefined) {
			this.win_rinci = Ext.create ('Earsip.view.PemindahanRinciWin', {});
		}

		this.down ("#pemindahan_grid").on ("selectionchange", this.master_on_selectionchange, this);
		this.down ("#pemindahan_grid").down ("#add").on ("click", this.master_do_add, this);
		this.down ("#pemindahan_grid").down ("#edit").on ("click", this.master_do_edit, this);
		this.down ("#pemindahan_grid").down ("#refresh").on ("click", this.master_do_refresh, this);
		this.down ("#pemindahan_grid").down ("#del").on ("click", this.master_do_delete, this);

		this.down ("#berkas_pindah_grid").on ("selectionchange", this.detail_on_selectionchange, this);
		this.down ("#berkas_pindah_grid").down ("#add").on ("click", this.detail_do_add, this);
		this.down ("#berkas_pindah_grid").down ("#del").on ("click", this.detail_do_delete, this);
		this.down ("#berkas_pindah_grid").down ("#print").on ("click", this.detail_do_print, this);

		this.win.down ("#save").on ("click", this.win_do_submit, this);

		this.win_rinci.down ("#save").on ("click", this.win_rinci_do_submit, this);
	}
});
