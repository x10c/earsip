Ext.define ('Earsip.model.MenuAccess', {
	extend		: 'Ext.data.Model'
,	fields		: [ 'menu_id', 'menu_parent_id', 'menu_name', 'menu_index', 'user_id', 'access_level' ]
,	idProperty	: 'menu_id'
});
