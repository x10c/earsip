Ext.require ('Earsip.view.Main');

Ext.define ('Earsip.view.Viewport', {
	extend	: 'Ext.container.Viewport'
,	layout	: 'fit'
,	items	: [{
		xtype: 'mainview'
	}]
});
