Ext.define('Earsip.view.WinIndeksRelatif',{
	extend : 'Ext.Window'
,	title	: 'Cari Indeks Relatif'
,	alias	: 'widget.win_indeks_relatif'
,	itemid	: 'win_indeks_relatif'
,	modal	: true
,	width	: 400
,	height	: 300
,	closeAction : 'hide'
,	layout	: 'fit'
,	modal		: true
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
	}]
,	buttons : [{
		text	: 'Ambil'
	,	iconCls	: 'save'
	,	itemId	: 'ambil'
	}]
,	listeners	: {
		activate : function ()
		{
			Ext.getStore ("KlasArsip").clearFilter ();
			this.down ('#grid_ir').getStore ().load ();
		}
	}
});
