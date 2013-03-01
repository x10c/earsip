Ext.require ('Earsip.store.MenuAccess');

var s_acl = Ext.create ('Ext.data.Store', {
	fields	: ['id','name']
,	data	: [
		{id: 0	, name:'Tanpa Akses'}
	,	{id: 1	, name:'View'}
	,	{id: 2	, name:'Insert'}
	,	{id: 3	, name:'Update'}
	,	{id: 4	, name:'Delete'}
	]
});

Ext.define ('Earsip.view.AdmHakAksesMenu', {
	extend			: 'Ext.grid.Panel'
,	alias			: 'widget.adm_hak_akses_menu'
,	itemId			: 'adm_hak_akses_menu'
,	title			: 'Daftar Menu'
,	store			: 'MenuAccess'
,	plugins			:
	[
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns			: [{
		text			: 'ID'
	,	dataIndex		: 'id'
	,	width			: 50
	},{
		text			: 'Parent ID'
	,	dataIndex		: 'pid'
	,	width			: 80
	},{
		text			: 'Nama Menu'
	,	dataIndex		: 'nama'
	,	flex			: 1
	},{
		text			: 'Akses'
	,	dataIndex		: 'hak_akses_id'
	,	renderer		: store_renderer ('id', 'name', s_acl)
	,	editor			: {
			xtype			: 'combo'
		,	store			: s_acl
		,	valueField		: 'id'
		,	displayField	: 'name'
		,	allowBlank		: false
		,	autoSelect		: true
		,	editable		: false
		}
	}]
,	dockedItems		: [{
		xtype			: 'toolbar'
	,	dock			: 'top'
	,	flex			: 1
	,	items			: [{
			text			: 'Refresh'
		,	iconCls			: 'refresh'
		,	handler			: function (button)
			{
				var grid = button.up ('#adm_hak_akses_menu');

				grid.getStore ().load ({
					params	: grid.params
				});
			}
		},'-']
	}]
});
