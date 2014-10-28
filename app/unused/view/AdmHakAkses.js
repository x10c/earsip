Ext.require ([
	'Earsip.view.Grup'
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
		xtype			: 'grup'
	,	region			: 'center'
	,	flex			: 0.5
	,	minWidth		: 200
	},{
		xtype			: 'adm_hak_akses_menu'
	,	region			: 'east'
	,	flex			: 0.5
	,	minWidth		: 200
	}]
,	listeners		: {
		activate		: function (comp)
		{
			var grup = this.down ('#grup');
			grup.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}
});
