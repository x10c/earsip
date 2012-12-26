Ext.define('Earsip.view.WinIndeksRelatif',{
	extend : 'Ext.Window'
,	title	: 'Cari Indeks Relatif'
,	alias	: 'widget.win_indeks_relatif'
,	itemid	: 'win_indeks_relatif'
,	modal	: true
,	width	: 400
,	height	: 300
,	closeAction : 'destroy'
,	layout	: 'fit'
,	items	: [{
		xtype 	: 'grid'
	,	itemId	: 'grid_ir'
	,	store	: Ext.getStore ('IndeksRelatif')
	,	columns	: [{
			xtype	: 'rownumberer'
		},{
			text		: 'Klasifikasi'
		,	dataIndex	: 'berkas_klas_id'
		,	renderer	: store_renderer ('id', 'nama', Ext.getStore ('KlasArsip'))
		,	flex		: 1
		},{
			text		: 'Indeks Relatif'
		,	dataIndex	: 'keterangan'
		,	flex		: 1
		}]
	},{
		xtype	: 'form'
	,	hidden	: true
	,	itemId	: 'form_ir'
	,	defaults : {
			xtype 	: 'textfield'
		}
	,	items	: [{
			itemId 	: 'berkas_klas_id'
		,	name	: 'berkas_klas_id'
		},{
			itemId	: 'keterangan'
		,	name	: 'keterangan'
		}]
	}]
,	buttons : [{
		text	: 'Ambil'
	,	iconCls	: 'save'
	,	itemId	: 'ambil'
	}]
,	listeners	: {
		activate : function ()
		{
			this.down ('#grid_ir').getStore ().load ();
		}
	}
});
