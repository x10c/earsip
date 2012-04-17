Ext.Loader.setConfig ({ enabled: true });

Ext.application ({
	name		: 'Earsip'
,	appFolder	: 'app'
,	models		: [
		'DirList'
	]
,	stores		: [
		'DirList'
	]
,	views		: [
		'Main', 'Trees', 'DirList', 'SharedList'
	]
,	controllers	: [
		'Login'
	]
,	launch		: function () {
		Ext.create ('Earsip.view.LoginWindow', {}).show();
		Ext.create ('Ext.container.Viewport', {
			layout	: 'fit'
		,	items	: [{
				xtype: 'mainview'
			}]
		});
	}
});
