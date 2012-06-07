Ext.require ([
	'Earsip.view.MainToolbar'
,	'Earsip.view.Berkas'
,	'Earsip.view.BerkasBerbagi'
]);

Ext.define ('Earsip.view.Main', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.mainview'
,	layout		: 'card'
,	bodyStyle	: {
		background	: '#CCDDEE'
	}
,	defaults	: {
		border		: false
	}
,	activeItem	: 0
,	items		: [{
		id		: 'login'
	,	bodyCls	: 'panel-bg'
	,	html	:
			'<div class="footer">'+
			'&copy;2012 Bank Pembangunan Daerah Jawa Tengah'+
			'</div>'
	},{
		id		: 'main'
	,	xtype	: 'panel'
	,	bodyCls	: 'panel-bg'
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

,	open_view_main : function ()
	{
		var layout	= this.getLayout ();
		var login_v	= this.getComponent (0);
		var main_v	= this.getComponent (1);

		login_v.getEl ().slideOut ('l', {
			callback: function()
			{
				layout.setActiveItem (main_v);
				main_v.getEl ().slideIn ('r');
			}
		});
	}

,	open_view_login : function (login_win)
	{
		var layout	= this.getLayout ();
		var login_v	= this.getComponent (0);
		var main_v	= this.getComponent (1);

		main_v.getEl ().slideOut ('r', {
			callback: function()
			{
				layout.setActiveItem (login_v);
				login_v.getEl ().slideIn ('l', {
					callback: function ()
					{
						login_win.down ('form').getForm ().reset ();
						login_win.show ();
					}
				});
			}
		});
	}
});
