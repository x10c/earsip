Ext.require ([
	'Earsip.view.ArsipTree'
,	'Earsip.view.ArsipList'
,	'Earsip.view.BerkasForm'
]);

Ext.define ('Earsip.view.Arsip', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.mas_arsip'
,	itemId		: 'mas_arsip'
,	title		: 'Arsip'
,	layout		: 'border'
,	closable	: true
,	items		: [{
		xtype		: 'arsiptree'
	,	region		: 'west'
	},{
		xtype		: 'container'
	,	region		: 'center'
	,	layout		: 'border'
	,	items		: [{
			xtype		: 'arsiplist'
		,	region		: 'center'
		},{
			xtype		: 'berkasform'
		,	itemId		: 'arsip_form'
		,	region		: 'south'
		,	split		: true
		,	collapsible	: true
		,	header		: false
		}]
	}]
,	listeners	: {
		activate	: function (comp)
		{
			var tree = this.down ('arsiptree');
			tree.do_load_tree ();
		}
	}
});
