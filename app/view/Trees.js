Ext.define ('Earsip.view.Trees', {
	extend		: 'Ext.tree.Panel'
,	alias		: 'widget.trees'
,	title		: 'Direktori'
,	region		: 'west'
,	width		: 220
,	margins		: '5 0 0 5'
,	split		: true
,	root		: {
		text		: 'E-Arsip'
,		expanded	: true
,		children	: [{
			text	: 'Child 1'
		,	leaf	: true
		},{
			text	: 'Child 2'
		,	leaf	: true
		},{
			text	: 'Child 3'
		,	expanded: true
		,	children: [{
				text	: 'Grandchild'
			,	leaf	: true
			}]
		}]
    }
,	initComponent	: function() {
		this.callParent (arguments);
	}
});
