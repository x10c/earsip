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
,	items		:
	[{
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
	,	defaults	:
		{
			readOnly	: true
		}
	}]
,	listeners :
	{
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

,	list_on_itemdblclick : function (v, r, idx)
	{
		if (r.get ("tipe_file") != 0) {
			Earsip.win_viewer.down ('#download').hide ();
			Earsip.win_viewer.do_open (r);
		}
	}

,	list_on_selectionchange : function (m, r)
	{
		var list = this.down ("#berkas_jra_list");

		if (r.length > 0) {
			this.down ('#berkas_jra_form').loadRecord (r[0]);
		}
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#berkas_jra_list").on ("itemdblclick", this.list_on_itemdblclick, this);
		this.down ("#berkas_jra_list").on ("selectionchange", this.list_on_selectionchange, this);
	}
});
