Ext.require ([
	'Earsip.view.AdmHakAksesUser'
,	'Earsip.view.AdmHakAksesMenu'
]);

Ext.define ('Earsip.view.AdmHakAkses', {
	extend			: 'Ext.panel.Panel'
,	alias			: 'widget.adm_hak_akses'
,	itemId			: 'adm_hak_akses'
,	title			: 'Administrasi Hak Akses'
,	closable		: true
,	plain			: true
,	layout			: 'border'
,	defaults		: {
		split			: true
	,	autoScroll		: true
	}
,	items			: [{
		xtype			: 'adm_hak_akses_user'
	,	region			: 'center'
	,	flex			: 0.5
	,	minWidth		: 450
	},{
		xtype			: 'adm_hak_akses_menu'
	,	region			: 'east'
	,	flex			: 0.5
	,	minWidth		: 450
	}]
,	listeners		: {
		activate		: function (comp)
		{
			var user = this.down ('#adm_hak_akses_user');
			user.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}
});
