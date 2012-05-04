Ext.require ('Earsip.view.MetodaPemusnahanGridPanel');

Ext.define ('Earsip.view.MetodaPemusnahan', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.ref_metoda_pemusnahan'
,	title		: 'Referensi Metoda Pemusnahan'
,	itemId		: 'ref_metoda_pemusnahan'
,	closable		: true
,	plain			: true
,	layout			: 'border'
,	defaults		: {
		split			: true
	,	autoScroll		: true
	}
,	items			: [{
		xtype			: 'metoda_pemusnahan_grid'
	,	region			: 'center'
	,	flex			: 1
	,	minWidth		: 450
	}]
,	listeners		: {
		activate		: function (comp)
		{
			var metodapemusnahan = this.down ('#metoda_pemusnahan_grid');
			metodapemusnahan.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}

});
