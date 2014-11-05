Ext.require ([
	'Earsip.store.Pegawai'
,	'Earsip.store.UnitKerja'
,	'Earsip.store.Jabatan'
,	'Earsip.view.PegawaiWin'
]);

Ext.define ('Earsip.view.Pegawai', {
	extend		: 'Ext.grid.Panel'
,	id			: 'mas_pegawai'
,	alias		: 'widget.mas_pegawai'
,	itemId		: 'mas_pegawai'
,	store		: 'Pegawai'
,	title		: 'Data Pegawai'
,	closable	: true
,	plugins		: [
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Nama Pegawai'
	,	dataIndex	: 'nama'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'NIP'
	,	dataIndex	: 'nip'
	,	width		: 120
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Unit Kerja'
	,	dataIndex	: 'unit_kerja_id'
	,	width		: 150
	,	editor		: {
			xtype			: 'combo'
		,	store			: Ext.create ('Earsip.store.UnitKerja', {
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
		text		: 'Jabatan'
	,	dataIndex	: 'jabatan_id'
	,	width		: 150
	,	editor		: {
			xtype			: 'combo'
		,	store			: Ext.create ('Earsip.store.Jabatan', {
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
		text		: 'Status'
	,	dataIndex	: 'status'
	,	width		: 80
	,	editor		: {
			xtype			: 'checkbox'
		,	inputValue		: 1
		,	uncheckedValue	: 0
		}
	,	renderer	: function (v)
		{
			if (v == 1) {
				return 'Aktif';
			} else {
				return 'Non Aktif';
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

,	listeners	:
	{
		activate	: function (comp)
		{
			this.getStore ().load ();
		}
	,	selectionchange : function (m, r)
		{
			var b_edit	= this.down ('#edit');
			var b_del	= this.down ('#del');

			b_edit.setDisabled (! r.length);
			b_del.setDisabled (! r.length);

			if (r.length > 0) {
				this.win.down ('form').loadRecord (r[0]);
			}
		}
	}

,	do_add : function (b)
	{
		this.win.down ('form').getForm ().reset ();
		this.win.down ('#password').allowBlank = false;
		this.win.show ();
		this.win.action = 'create';
	}

,	do_edit : function (b)
	{
		var data = this.getSelectionModel ().getSelection ();

		if (data.length <= 0) {
			return;
		}

		this.win.down ('#password').allowBlank = true;
		this.win.down ('form').loadRecord (data[0]);
		this.win.show ();
		this.win.action = 'update';
	}

,	do_refresh : function (b)
	{
		this.getStore ().load ();
	}

,	do_delete : function (b)
	{
		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus pegawai?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}
			var data = this.getSelectionModel ().getSelection ();

			if (data.length <= 0) {
				return;
			}

			this.win.down ('#password').allowBlank = true;
			this.win.action = 'destroy';

			this.do_submit (b);
		}
		, this);
	}

,	do_submit : function (b)
	{
		var form = this.win.down ('form').getForm ();

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
					this.getStore ().load ();
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

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#add").on ("click", this.do_add, this);
		this.down ("#edit").on ("click", this.do_edit, this);
		this.down ("#del").on ("click", this.do_delete, this);
		this.down ("#refresh").on ("click", this.do_refresh, this);

		if (this.win == undefined) {
			this.win = Ext.create ('Earsip.view.PegawaiWin', {});

			this.win.down ("#submit").on ("click", this.do_submit, this);
		}
	}
});
