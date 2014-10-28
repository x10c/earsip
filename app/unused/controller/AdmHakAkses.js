Ext.define ('Earsip.controller.AdmHakAkses', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'grup'
	,	selector: 'grup'
	},{
		ref		: 'adm_hak_akses_menu'
	,	selector: 'adm_hak_akses_menu'
	}]

,	init	: function ()
	{
		this.control ({
			'grup': {
				selectionchange : this.user_select
			}
		});
	}

,	user_select : function (grid, records)
	{
		if (records.length > 0) {
			var menus = this.getAdm_hak_akses_menu ();

			menus.params = {
				grup_id : records[0].get('id')
			}
			menus.getStore ().load ({
				params	: menus.params
			});
		}
	}
});
