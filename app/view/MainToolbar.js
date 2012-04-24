Ext.define ('Earsip.view.MainToolbar', {
	extend	: 'Ext.toolbar.Toolbar'
,	alias	: 'widget.maintoolbar'
,	flex	: 1
,	items	: [{
		text	: 'My Menu'
	,	menu	: {
			xtype	: 'menu'
		,	plain	: true
		,	items	: [{
				text	: 'Menu 1'
			,	handler	: function () {
					console.log ('Menu 1');
				}
			},{
				text	: 'Menu 2'
			}]
		}
	},{
		text	: 'Administrasi'
	,	scope	: this
	,	handler	: function () {
			console.log ('Administrasi');
		}
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}
});
