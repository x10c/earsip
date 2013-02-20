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
		text		: 'Nama'
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

			console.log (data[0]);

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
});
