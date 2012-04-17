Ext.define ('Earsip.controller.Login', {
	extend	: 'Ext.app.Controller'
,	init	: function() {
		this.control ({
			'loginwindow': {
				render: this.onPanelRendered
			}
		,	'loginwindow button[action=login]': {
				click: this.login
			}
		,	'loginwindow textfield': {
				specialkey: this.keyenter
			}
		,	'mainview button[action=logout]': {
				click: this.logout
			}
        });
    }
,	refs	: [{
		ref		: 'mainview'
	,	selector: 'mainview'
	},{
		ref		: 'loginwindow'
,		selector: 'loginwindow'
	}]
,	views		: [
		'Main'
	]
,	onPanelRendered	: function (panel) {
	}
,	login			: function (button) {
		var win		= button.up('window');
		var form	= win.down('form');
		var values	= form.getValues();
	        
		if (values.userName == "admin") {
			var lay = this.getMainview().getLayout();
			lay.setActiveItem (1);
			win.hide();	
		}
	}
,	keyenter		: function() {
    }
,	logout			: function(button) {
		var lay = this.getMainview().getLayout();
		lay.setActiveItem(0);
		var win = this.getLoginwindow();
		win.show();
    }
});
