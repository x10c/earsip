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
