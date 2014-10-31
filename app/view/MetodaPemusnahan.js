Ext.require ('Earsip.store.MetodaPemusnahan');

Ext.define ('Earsip.view.MetodaPemusnahan', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_metoda_pemusnahan'
,	itemId		: 'ref_metoda_pemusnahan'
,	store		: 'MetodaPemusnahan'
,	title		: 'Metode Pemusnahan'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		xtype		: 'rownumberer'
	},{
		text		: 'Nama Metode'
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

,	listeners	:
	{
		activate	: function (comp)
		{
			this.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	,	selectionchange : function (m, r)
		{
			var bdel = this.down('#del');
			bdel.setDisabled (! r.length);
		}
	}

,	do_add : function (b)
	{
		var editor = this.getPlugin ('roweditor');

		editor.action = 'add';
		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.MetodaPemusnahan', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		this.getStore ().insert (0, r);
		editor.startEdit (0, 0);
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

,	do_refresh : function (b)
	{
		this.getStore ().load ();
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#add").on ("click", this.do_add, this);
		this.down ("#del").on ("click", this.do_delete, this);
		this.down ("#refresh").on ("click", this.do_refresh, this);
	}
});
