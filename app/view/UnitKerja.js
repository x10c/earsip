Ext.require ('Earsip.store.UnitKerja');

Ext.define ('Earsip.view.UnitKerja', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.mas_unit_kerja'
,	title		: 'Data Unit Kerja'
,	itemId		: 'mas_unit_kerja'
,	store		: 'UnitKerja'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Kode'
	,	dataIndex	: 'kode'
	,	width		: 100
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Nama Unit Kerja'
	,	dataIndex	: 'nama'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Pimpinan'
	,	dataIndex	: 'nama_pimpinan'
	,	width		: 200
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
	,	width		: 300
	,	editor		: {
			xtype		: 'textfield'
		}
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		:'Urut Naik'
		,	itemId		:'urut_naik'
		,	iconCls		:'up'
		,	disabled	:true
		,	handler		:function (b)
			{
				var g = b.up ('grid');
				var d = g.getSelectionModel ().getSelection ();

				Ext.Ajax.request ({
					url		:'data/unit_kerja/reorder.jsp'
				,	params	:{
						id		:d[0].get ('id')
					,	urutan	:d[0].get ('urutan')
					,	value	:1
					}
				,	success	: function (response)
					{
						g.do_refresh ();
					}
				});
			}
		},'-',{
			text		:'Urut Turun'
		,	itemId		:'urut_turun'
		,	iconCls		:'down'
		,	disabled	:true
		,	handler		:function (b)
			{
				var g = b.up ('grid');
				var d = g.getSelectionModel ().getSelection ();

				Ext.Ajax.request ({
					url		:'data/unit_kerja/reorder.jsp'
				,	params	:{
						id		:d[0].get ('id')
					,	urutan	:d[0].get ('urutan')
					,	value	:-1
					}
				,	success	: function (response)
					{
						g.do_refresh ();
					}
				});
			}
		},'-',{
			text		: 'Tambah'
		,	itemId		: 'add'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		,	handler		:function (b)
			{
				b.up ('grid').do_refresh ();
			}
		},'->',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	iconCls		: 'del'
		,	disabled	:true
		}]
	}]

,	listeners	:{
		selectionchange	:function (model, data, e)
		{
			var s = ! (data.length > 0);

			this.down ('#urut_naik').setDisabled (s);
			this.down ('#urut_turun').setDisabled (s);
			this.down ('#del').setDisabled (s);

			if (s) {
				return;
			}

			if (data[0].index == 0) {
				this.down ('#urut_naik').setDisabled (true);
			} else if (data[0].index == (data[0].store.totalCount - 1)) {
				this.down ('#urut_turun').setDisabled (true);
			}
		}
	}

,	do_refresh	:function ()
	{
		this.getStore ().load ();
	}

,	do_add : function (b)
	{
		var editor = this.getPlugin ('roweditor');

		editor.cancelEdit ();
		editor.action = 'add';
		var r = Ext.create ('Earsip.model.UnitKerja', {
				id				: 0
			,	kode			: ''
			,	nama			: ''
			,	nama_pimpinan	: ''
			,	keterangan		: ''
			});

		this.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_delete : function (b)
	{
		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus unit kerja?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}
			var data	= this.getSelectionModel ().getSelection ();
			var store	= this.getStore ();

			if (data.length <= 0) {
				return;
			}

			store.remove (data);
			store.sync ();
		}
		, this);
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#add").on ("click", this.do_add, this);
		this.down ("#del").on ("click", this.do_delete, this);
	}
});
