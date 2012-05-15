Ext.require ([
	'Earsip.view.MainToolbar'
,	'Earsip.view.Berkas'
,	'Earsip.view.BerkasBerbagi'
]);

Ext.define ('Earsip.view.Main', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.mainview'
,	layout		: 'card'
,	defaults	: {
		border		: false
	}
,	activeItem	: 0
,	items		: [{
		id		: 'login'
	,	html	: ''
	},{
		id		: 'main'
	,	xtype	: 'panel'
	,	tbar	: Ext.create ('Earsip.view.MainToolbar')
	,	layout	: 'fit'
	,	items	: [{
			xtype	: 'tabpanel'
		,	itemId	: 'content_tab'
		,	items	: [{
				xtype	: 'berkas'
			},{
				xtype	: 'berkasberbagi'
			}]
		}]
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
