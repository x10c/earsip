Ext.require ('Earsip.store.User');

Ext.define ('Earsip.view.AdmHakAksesUser', {
	extend			: 'Ext.grid.Panel'
,	alias			: 'widget.adm_hak_akses_user'
,	itemId			: 'adm_hak_akses_user'
,	title			: 'Daftar User'
,	store			: 'User'
,	columns			: [{
		text			: 'NIP'
	,	dataIndex		: 'user_nip'
	},{
		text			: 'Nama'
	,	dataIndex		: 'user_name'
	,	flex			: 1
	}]
,	dockedItems		: [{
		xtype			: 'toolbar'
	,	dock			: 'top'
	,	flex			: 1
	,	items			: [{
			text			: 'Refresh'
		,	handler			: function (button)
			{
				var grid = button.up ('#adm_hak_akses_user');

				grid.getStore ().load ();
			}
		}]
	}]
,	listeners		: {
		rendered : function (comp)
		{
			this.getStore ().load ();
		}
	}
});
