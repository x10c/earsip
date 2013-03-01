Ext.require ([
	'Earsip.store.BerkasJRA'
]);

Ext.define ('Earsip.view.BerkasJRAList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.berkas_jra_list'
,	id			:'berkas_jra_list'
,	store		: 'BerkasJRA'
,	columns		: [{
		text		: 'Nama Berkas'
	,	flex		: 1
	,	hideable	: false
	,	dataIndex	: 'nama'
	,	renderer	: function (v, md, r)
		{
			if (r.get ('tipe_file') == 0) {
				return "<span class='dir'>"+ v +"</span>";
			} else {
				return "<span class='doc'>"+ v +"</span>";
			}
		}
	},{
		text		: 'Tanggal JRA'
	,	width		: 100
	,	dataIndex	: 'tgl_jra'
	,	renderer	: function(v)
		{return date_renderer (v);}
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
		text		: 'Refresh'
	,	itemId		: 'refresh'
	,	iconCls		: 'refresh'
	,	handler		: function ()
		{
			var grid = this.up ('grid');
			grid.getStore ().load ({});
		}
	}]

,	do_refresh	:function ()
	{
		this.getStore ().load ();
	}
});
