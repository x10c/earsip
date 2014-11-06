Ext.define ('Earsip.model.BerkasTree', {
	extend		:'Ext.data.Model'
,	idProperty	:'id'
,	fields		:[
		'id'
	,	'pid'
	,	'text'
	,	'shared'
	,	'children'
	]
});

Ext.define ('Earsip.store.BerkasTree', {
	extend		:'Ext.data.TreeStore'
,	storeId		:'BerkasTree'
,	model		:'Earsip.model.BerkasTree'
,	autoSync	:false
,	autoLoad	:false
,	root		:{
		expanded	:true
	}
,	proxy		:{
		type		:'ajax'
	,	api			:{
			read		:'data/berkas_tree.jsp'
		}
	,	reader		:{
			type		:'json'
		}
	}

, 	listeners: {
        append: function( thisNode, newChildNode, index, eOpts ) {
				var newrec = newChildNode.get('shared');
				if (newrec > 0)
					newChildNode.set('iconCls', 'sharedfoldertree');
				else newChildNode.set('iconCls', 'treeicon');
        }
    }
});
