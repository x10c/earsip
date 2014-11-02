Ext.require ([
	'Earsip.store.LapBerkasJRA'
]);

Ext.define ('Earsip.view.LapBerkasJRA', {
	extend 		: 'Ext.grid.Panel'
,	alias		: 'widget.lap_berkas_jra'
,	itemId		: 'lap_berkas_jra'
,	title		: 'Laporan Berkas JRA'
,	closable	: true
,	title		: 'Daftar Berkas JRA'
,	store		: 'LapBerkasJRA'
,	columns		: [{
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
		},{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		}]
	}]
	
,	listeners	: {
		activate : function (comp)
		{
			this.getStore ().load ();
		}
	}

,	do_print : function (b)
	{
		var r = this.getStore ().getRange ();
		if (r.length <= 0) {
			return;
		}
		window.open ('data/lapberkasjrareport_submit.jsp');
	}

,	do_refresh : function (b)
	{
		this.getStore ().load ();
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#print").on ("click", this.do_print, this);
		this.down ("#refresh").on ("click", this.do_refresh, this);
	}
});
