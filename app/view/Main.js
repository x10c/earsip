Ext.require ([
	'Earsip.view.MainToolbar'
,	'Earsip.view.DirTree'
,	'Earsip.view.Berkas'
,	'Earsip.view.SharedList'
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
	,	tbar	: Ext.create('Earsip.view.MainToolbar')
	,	layout	: 'border'
	,	items	: [{
			xtype		: 'dirtree'
		},{
			xtype		: 'tabpanel'
		,	itemId		: 'content_tab'
		,	region		: 'center'
		,	margins		: '5 5 0 0'
		,	items		: [{
				xtype	: 'berkas'
			},{
				xtype	: 'sharedlist'
			}]
		}]
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
