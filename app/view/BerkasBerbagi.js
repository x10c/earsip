Ext.require ([
	'Earsip.view.BerkasBerbagiTree'
,	'Earsip.view.BerkasBerbagiList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.BerkasBerbagi', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.berkasberbagi'
,	itemId		: 'berkasberbagi'
,	title		: 'Berkas berbagi'
,	layout		: 'border'
,	items		: [{
		xtype		: 'berkasberbagitree'
	,	region		: 'west'
	},{
		xtype		: 'container'
	,	region		: 'center'
	,	layout		: 'border'
	,	items		: [{
			xtype		: 'berkasberbagilist'
		,	region		: 'center'
		},{
			xtype		: 'berkasform'
		,	itemId		: 'berkasberbagi_form'
		,	region		: 'south'
		,	split		: true
		,	collapsible	: true
		,	header		: false
		}]
	}]
	
,	listeners : {
		beforerender : function (comp)
		{
			this.down ('#berkasberbagi_form').down ('#indeks_relatif').hide ();
		}
	}
});
