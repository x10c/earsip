Ext.require ('Earsip.view.MainToolbar');
Ext.require ('Earsip.view.Trees');
Ext.require ('Earsip.view.Content');

Ext.define ('Earsip.view.Main', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.mainview'
,	layout		: 'card'
,	defaults	: {
		border	:false
	}
,	activeItem	: 0
,	items		: [{
		id		: 'login'
	,	html	: ''
	},{
		id		: 'main'
	,	xtype	: 'panel'
	,	tbar	: [{
			xtype	: 'maintoolbar'
		}]
	,	layout	: 'border'
	,	items	: [{
			xtype	: 'trees'
		},{
			xtype	: 'content'
		}]
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
