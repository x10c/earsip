Ext.require ([
	'Earsip.store.LapBerkasJRA'
]);

Ext.define ('Earsip.view.LapBerkasJRA', {
	extend 	: 'Ext.grid.Panel'
,	alias	: 'widget.lap_berkas_jra'
,	itemId	: 'lap_berkas_jra'
,	title	: 'Laporan Berkas JRA'
,	closable: true
,	title			: 'Daftar Berkas JRA'
,	store			: 'LapBerkasJRA'
,	columns			: [{
		xtype		: 'rownumberer'
	},{
		text		: 'Nama Berkas'
	,	dataIndex	: 'nama'
	,	width		: 300
	},{
		text			: 'Usia'
	,	columns	:	[{
			text		: 'Tahun'
		,	dataIndex	: 'tahun'
		,	width		: 75
		},{
			text		: 'Bulan'
		,	dataIndex	: 'bulan'
		,	width		: 75
		},{
			text		: 'Hari'
		,	dataIndex	: 'hari'
		,	width		: 75
		}]
	},{
		text			: 'JRA (Tahun)'
	,	dataIndex		: 'jra'
	//,	flex			: 1
	},{
		text			: 'Lokasi'
	,	dataIndex		: 'lokasi'
	,	flex			: 1
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	pos			: 'top'
	,	items		: [{
			text		: 'Print'
		,	itemId		: 'print'
		,	iconCls		: 'print'
		,	action		: 'print'
		}]
	}]
	
,	listeners	: {
		activate : function (comp)
		{
			this.getStore ().load ();
		}
	}


});
