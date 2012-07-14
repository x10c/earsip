Ext.require ([
	'Earsip.store.BerkasJRA'
]);

Ext.define ('Earsip.view.BerkasJRAList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.berkas_jra_list'
,	store		: 'BerkasJRA'
,	columns		: [{
		text		: 'Nama'
	,	flex		: 1
	,	hideable	: false
	,	dataIndex	: 'nama'
	,	renderer	: function (v, md, r)
		{
			if (r.get ('tipe_file') == 0) {
				return "<span class='dir'>"+ v +"</span>";
			} else {
				return "<a class='doc' target='_blank'"
					+" href='data/download.jsp"
					+"?berkas="+ r.get('sha') +"&nama="+ v +"'>"
					+ v +"</a>";
			}
		}
	},{
		text		: 'Tanggal JRA'
	,	width		: 100
	,	dataIndex	: 'tgl_jra'
	,	renderer	: function(v)
		{return Ext.util.Format.date(v,'Y-m-d');}
	},{
		text		: 'Usia'
	,	width		: 150
	,	dataIndex	: 'usia'
	},{
		text		: 'Lokasi'
	,	flex		: 1
	,	dataIndex	: 'lokasi'
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		,	handler		: function ()
			{
				var grid = this.up ('grid');
				grid.getStore ().load ({});
			}
		},'-'
		]
	}]
});
