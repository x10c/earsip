Ext.define ('Earsip.model.MenuAccess', {
	extend		: 'Ext.data.Model'
,	fields		: [ 'menu_id', 'menu_pid', 'menu_name', 'menu_ref', 'user_id', 'hak_akses' ]
,	idProperty	: 'menu_id'
});
