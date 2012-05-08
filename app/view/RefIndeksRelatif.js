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
,	listeners		: {
		activate		: function (comp)
		{
			this.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}	
});
