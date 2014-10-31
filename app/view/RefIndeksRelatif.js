Ext.require ([
	'Earsip.store.KlasArsip'
,	'Earsip.store.IndeksRelatif'
,	'Earsip.view.RefIndeksRelatifWin'
]);

Ext.define ('Earsip.view.RefIndeksRelatif', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_indeks_relatif'
,	itemId		: 'ref_indeks_relatif'
,	store		: 'IndeksRelatif'
,	title		: 'Referensi Indeks Relatif'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Klasifikasi Berkas ID'
	,	dataIndex	: 'berkas_klas_id'
	,	flex		: 1
	,	editor		: {
			xtype			: 'combo'
		,	store			: Ext.create ('Earsip.store.KlasArsip', {
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
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
	,	flex		: 4
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
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

,	listeners:
	{
		activate: function (comp)
		{
			this.getStore ().load ();
		}
	,	removed: function (comp)
		{
			this.destroy ();
		}
	,	selectionchange: function (m, r)
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
		this.win.show ();
		this.win.action = 'create';
	}

,	do_edit : function (b)
	{
		this.win.show ();
		this.win.action = 'update';
	}

,	do_refresh : function (b)
	{
		this.getStore ().load ();
	}

,	do_delete : function (b)
	{
		var d = this.getSelectionModel ().getSelection ();

		if (d.length <= 0) {
			return;
		}

		var s = this.getStore ();
		s.remove (d);
		s.sync ();
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
					form.reset ();
					this.win.hide ();
					this.getStore ().load ();
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

,	win_on_beforeclose : function (c)
	{
		this.getSelectionModel ().deselectAll ();
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#add").on ("click", this.do_add, this);
		this.down ("#edit").on ("click", this.do_edit, this);
		this.down ("#del").on ("click", this.do_delete, this);
		this.down ("#refresh").on ("click", this.do_refresh, this);

		delete this.win;
		this.win = undefined;
		Ext.destroy (this.win);

		if (this.win == undefined) {
			this.win = Ext.create ('Earsip.view.RefIndeksRelatifWin', {});

			this.win.down ("#save").on ("click", this.do_submit, this);
			this.win.on ("beforeclose", this.win_on_beforeclose, this);
		}
	}
});
