Ext.require ([
	'Earsip.view.NotifPemindahanWin'
,	'Earsip.store.Pemindahan'
,	'Earsip.store.PemindahanRinci'
,	'Earsip.store.UnitKerja'
]);

Ext.define ('Earsip.view.NotifPemindahan', {
	extend 	: 'Ext.panel.Panel'
,	alias	: 'widget.notif_pemindahan'
,	itemId	: 'notif_pemindahan'
,	title	: 'Notifikasi Pemindahan'
,	plain	: true
,	layout	: 'border'
,	idc		: -1
,	defaults: {
		split		: true
	,	autoScroll	: true
	}
,	items	:[{
		xtype			: 'grid'
	,	alias			: 'widget.pemindahan_grid'
	,	itemId			: 'pemindahan_grid'
	,	title			: 'Notifikasi Pemindahan'
	,	store			: 'Pemindahan'
	,	region			: 'center'
	,	flex			: 1
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
			text		: 'Unit Kerja'
		,	dataIndex	: 'unit_kerja_id'
		,	flex		: 0.5
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.getStore ('UnitKerja')
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
			text			: 'No Reg / No Surat'
		,	dataIndex		: 'kode'
		,	flex			: 0.5
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text			: 'Tanggal'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		,	hidden			: true
		,	hideable		: false
		,	editor		: {
				xtype		: 'textfield'
			}

		},{
			text			: 'Penanggung Jawab Pusat Berkas'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		,	editable		: false
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text			: 'Penanggung Jawab Pusat Arsip'
		,	dataIndex		: 'pj_unit_arsip'
		,	flex			: 0.5
		,	editor		: {
				xtype		: 'textfield'

			}
		,	renderer	: function (v)
			{
				if (v == null || v == 'null')
					return Ext.String.format( '<span style="color: red">{0}</span>', 'Harap diisi');
				else {
					return v;
				}
			}
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		,	width		: 80
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
				text		: 'Refresh'
			,	itemId		: 'refresh'
			,	iconCls		: 'refresh'
			,	action		: 'refresh'
			},{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
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
	,	plugins			:[
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'Pemindahan_id'
		,	dataIndex	: 'pemindahan_id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'ID'
		,	dataIndex	: 'berkas_id'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			text		: 'Nama Berkas'
		,	dataIndex	: 'nama'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	disabled	: false
			}
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			dataIndex	: 'arsip_status_id'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			text		: 'Status'
		,	dataIndex	: 'status'
		, 	hidden		: true
		, 	hideable	: false
		,	editor		: {
				xtype		: 'textfield'
			}
		},{
			text		: 'Kode Rak'
		,	dataIndex	: 'kode_rak'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text		: 'Kode Box'
		,	dataIndex	: 'kode_box'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}
		},{
			text		: 'Kode Folder'
		,	dataIndex	: 'kode_folder'
		,	flex		: 1
		,	editor		: {
				xtype		: 'textfield'
			,	allowBlank	: false
			}

		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Refresh'
			,	itemId		: 'refresh'
			,	iconCls		: 'refresh'
			,	action		: 'refresh'
			}]
		}]
	}]
,	listeners		: {
		activate		: function (comp)
		{
			var grid = this.down ('#pemindahan_grid');
			grid.getStore ().load ();
			grid = this.down ('#berkas_pindah_grid');
			grid.getStore ().load ();
		}
	}

,	unlock	: function (field)
	{
		if ((field.itemId == 'pj_unit_arsip' || field.itemId == 'status'
		|| field.xtype == 'button')) {
			return;
		}
		field.setDisabled (false);
	}

,	lock	: function (field)
	{
		if ((field.itemId == 'pj_unit_arsip' || field.itemId == 'status'
		|| field.xtype == 'button')) {
			return;
		}
		field.setDisabled (true);
	}

,	do_refresh	:function ()
	{
		this.down ('#pemindahan_grid').getStore ().load ();
		this.down ('#berkas_pindah_grid').getStore ().load ();
	}

,	master_on_itemdblclick : function (v, r, item, idx)
	{
		this.down ('#pemindahan_grid').getPlugin ('roweditor').cancelEdit ();
		this.win.down ('form').getForm ().loadRecord (r);

		this.win.down ('#nama_petugas').setValue (Earsip.username);
		this.win.action = 'update';
		this.win.show ();
	}

,	master_on_selectionchange : function (m, r)
	{
		var grid = this.down ('#pemindahan_grid');
		var grid_rinci = this.down ('#berkas_pindah_grid');

		if (r.length > 0) {
			this.idc = r[0].get ('id');

			this.win_pindah.down ('form').loadRecord (r[0]);

			grid_rinci.params = {
				pemindahan_id : r[0].get ('id')
			};

			grid_rinci.getStore ().load ({
				params	: grid_rinci.params
			});
		}
	}

,	master_do_refresh : function (b)
	{
		this.down ('#pemindahan_grid').getStore ().load ();
		this.down ('#berkas_pindah_grid').getStore ().load ();
	}

,	master_do_print : function (b)
	{
		var grid = this.down ('#pemindahan_grid');
		var data = grid.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		var url = 'data/bapemindahanreport_submit.jsp?pemindahan_id=' + data[0].get ('id') ;
		window.open (url);
	}

,	detail_on_itemdblclick : function (v, r, item, idx)
	{
		this.down ('#berkas_pindah_grid').getPlugin ('roweditor').cancelEdit ();
		this.win_rinci.down ('form').getForm ().loadRecord (r);
		this.win_rinci.action = 'update';
		this.win_rinci.show ();
	}

,	detail_do_refresh : function (b)
	{
		if (this.idc < 1) {
			return;
		}

		var grid = b.up ('#berkas_pindah_grid');

		grid.params = {
			pemindahan_id : this.idc
		};
		grid.getStore ().load ({
			params	: grid.params
		});
	}

,	win_do_submit : function (b)
	{
		var grid	= this.down ('#pemindahan_grid');
		var form	= this.win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu');
			return;
		}

		this.win.down ('form').items.each (this.unlock);

		form.submit ({
			scope	: this
		,	params	: {
				action	: this.win.action
			}
		,	success	: function (form, action)
			{
				this.win.down('form').items.each (this.lock);

				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					this.win.hide ();
					form.reset ();
					grid.getStore ().load ();
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				this.win.down('form').items.each (this.lock);
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

					grid.params = {
						pemindahan_id : this.idc
					};

					grid.getStore ().load ({
						params	: grid.params
					});

					this.win_rinci.hide ();
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

,	initComponent : function ()
	{
		this.callParent (arguments);

		if (this.win == undefined) {
			this.win = Ext.create ('Earsip.view.NotifPemindahanWin', {});
		}
		if (this.win_pindah == undefined) {
			this.win_pindah = Ext.create ('Earsip.view.PemindahanWin', {});
		}
		if (this.win_rinci == undefined) {
			this.win_rinci = Ext.create ('Earsip.view.NotifPemindahanRinciWin', {});
		}

		this.down ("#pemindahan_grid").on ("itemdblclick", this.master_on_itemdblclick, this);
		this.down ("#pemindahan_grid").on ("selectionchange", this.master_on_selectionchange, this);
		this.down ("#pemindahan_grid").down ("#refresh").on ("click", this.master_do_refresh, this);
		this.down ("#pemindahan_grid").down ("#print").on ("click", this.master_do_print, this);

		this.down ("#berkas_pindah_grid").on ("itemdblclick", this.detail_on_itemdblclick, this);
		this.down ("#berkas_pindah_grid").down ("#refresh").on ("click", this.detail_do_refresh, this);

		this.win.down ("#save").on ("click", this.win_do_submit, this);

		this.win_rinci.down ("#save").on ("click", this.win_rinci_do_submit, this);
	}
});
