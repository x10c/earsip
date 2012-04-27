Ext.define ('Earsip.controller.AdmHakAkses', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'adm_hak_akses_user'
	,	selector: 'adm_hak_akses_user'
	},{
		ref		: 'adm_hak_akses_menu'
	,	selector: 'adm_hak_akses_menu'
	}]

,	init	: function ()
	{
		this.control ({
			'adm_hak_akses_user': {
				selectionchange : this.user_select
			}
		});
	}

,	user_select : function (grid, records)
	{
		if (records.length > 0) {
			var menus = this.getAdm_hak_akses_menu ();

			menus.params = {
				user_id : records[0].get('user_id')
			}
			menus.getStore ().load ({
				params	: menus.params
			});
		}
	}
});
