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
		'Main'
	,	'MainToolbar'
	,	'Trees'
	,	'DirList'
	,	'SharedList'
	]
,	controllers	: [
		'Login'
	,	'MainToolbar'
	]
,	launch		: function () {
		var win			= Ext.create ('Earsip.view.LoginWindow', {});
		var mainview	= Ext.create ('Earsip.view.Main', {});
		var viewport	= Ext.create ('Ext.container.Viewport', {
			layout	: 'fit'
		,	items	: [ mainview ]
		});

		viewport.show ();

		if (is_login) {
			win.hide ();
			mainview.getLayout ().setActiveItem ('main');
		} else {
			win.show ();
		}
	}
});
