Ext.require ([
	'Earsip.view.BerkasJRAList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.BerkasJRA', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.berkas_jra'
,	itemId		: 'berkas_jra'
,	title		: 'Notifikasi Berkas JRA'
,	layout		: 'border'
,	items		: [{
		xtype		: 'berkas_jra_list'
	,	region		: 'center'
	},{
		xtype		: 'berkasform'
	,	itemId		: 'berkas_jra_form'
	,	region		: 'east'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	,	width		: 400
	,	defaults	: {
			readOnly	: true
		}
	}]
,	listeners : {
		activate	:function (c)
		{
			c.down ('#berkas_jra_list').do_refresh ();
		}
	,	beforerender: function (comp)
		{
			this.down ('#berkas_jra_form').down ('#indeks_relatif').hide ();
		}
	}

,	do_refresh	:function ()
	{
		this.down ('#berkas_jra_list').do_refresh ();
	}
});
