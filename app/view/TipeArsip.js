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
	}
});
