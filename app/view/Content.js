Ext.require ('Earsip.view.DirList');
Ext.require ('Earsip.view.SharedList');

Ext.define ('Earsip.view.Content', {
	extend		: 'Ext.tab.Panel'
,	alias		: 'widget.content'
,	region		: 'center'
,	margins		: '5 5 0 0'
,	items		: [{
		xtype	: 'dirlist'
	},{
		xtype	: 'sharedlist'
	}]
});
