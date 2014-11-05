Ext.require ('Earsip.store.Jabatan');

Ext.define ('Earsip.view.Jabatan', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.ref_jabatan'
,	itemId		: 'ref_jabatan'
,	title		: 'Referensi Jabatan'
,	store		: 'Jabatan'
,	closable	: true
,	plugins		:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Nama Jabatan'
	,	dataIndex	: 'nama'
	,	width		: 100
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Keterangan'
	,	dataIndex	: 'keterangan'
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
			text		:'Urut Naik'
		,	itemId		:'urut_naik'
		,	iconCls		:'up'
		,	disabled	:true
		,	handler		:function (b)
			{
				var g = b.up ('grid');
				var d = g.getSelectionModel ().getSelection ();

				Ext.Ajax.request ({
					url		:'data/jabatan/reorder.jsp'
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
					url		:'data/jabatan/reorder.jsp'
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
		,	itemId		: "add"
		,	action		: 'add'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		,	handler		:function (b)
			{
				b.up ('grid').do_refresh ();
			}
		},'-','->','-',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	action		: 'del'
		,	iconCls		: 'del'
		,	disabled	: true
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

		editor.action = 'add';
		editor.cancelEdit ();
		var r = Ext.create ('Earsip.model.Jabatan', {
				id			: 0
			,	nama		: ''
			,	keterangan	: ''
			});

		this.getStore ().insert (0, r);
		editor.startEdit (0, 0);
	}

,	do_delete : function (b)
	{
		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau menghapus data jabatan?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}
			var data = this.getSelectionModel ().getSelection ();

			if (data.length <= 0) {
				return;
			}

			var s = this.getStore ();
			s.remove (data);
			s.sync ();
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
