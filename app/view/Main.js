Ext.require ('Earsip.view.MainToolbar');
Ext.require ('Earsip.view.DirTree');
Ext.require ('Earsip.view.Content');

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
	,	tbar	: [
			Ext.create('Earsip.view.MainToolbar')
		]
	,	layout	: 'border'
	,	items	: [{
			xtype	: 'dirtree'
		},{
			xtype	: 'content'
		}]
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
