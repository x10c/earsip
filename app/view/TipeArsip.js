Ext.require ('Earsip.store.TipeArsip');

Ext.define ('Earsip.view.TipeArsip', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_tipe_arsip'
,	itemId		: 'ref_tipe_arsip'
,	title		: 'Referensi Tipe Berkas'
,	store		: 'TipeArsip'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		xtype		: 'rownumberer'
	},{
		text		: 'Nama Tipe Arsip'
	,	dataIndex	: 'nama'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
	,	flex		: 2
	,	editor		: {
			xtype		: 'textfield'
		}
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		: 'Tambah'
		,	itemId		: 'add'
		,	action		: 'add'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		},'->',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	action		: 'del'
		,	iconCls		: 'del'
		,	disabled	: true
		}]
	}]

,	listeners	: {
		activate	: function (comp)
		{
			this.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	,	selectionchange : function (model, records)
		{
			var bdel = this.down('#del');
			bdel.setDisabled (! records.length);
		}
	}

,	do_add : function (b)
	{
		var editor	= this.getPlugin ('roweditor');

		editor.action = 'add';
		editor.cancelEdit ();

		var r = Ext.create ('Earsip.model.TipeArsip', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		this.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_refresh : function (button)
	{
		this.getStore ().load ();
	}

,	do_delete : function (button)
	{
		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus data Tipe Berkas?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}
			var data = this.getSelectionModel ().getSelection ();

			if (data.length <= 0) {
			return;
			}

			var store = this.getStore ();
			store.remove (data);
			store.sync ();
		}
		, this);
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#add").on ("click", this.do_add, this);
		this.down ("#refresh").on ("click", this.do_refresh, this);
		this.down ("#del").on ("click", this.do_delete, this);
	}
});
