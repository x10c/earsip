Ext.require ('Earsip.view.TipeArsipGridPanel');

Ext.define ('Earsip.view.TipeArsip', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.ref_berkas_tipe'
,	title		: 'Referensi Tipe Berkas'
,	itemId		: 'ref_berkas_tipe'
,	closable		: true
,	plain			: true
,	layout			: 'border'
,	defaults		: {
		split			: true
	,	autoScroll		: true
	}
,	items			: [{
		xtype			: 'tipe_arsip_grid'
	,	region			: 'center'
	,	flex			: 1
	,	minWidth		: 450
	}]
,	listeners		: {
		activate		: function (comp)
		{
			var tipearsip = this.down ('#tipe_arsip_grid');
			tipearsip.getStore ().load ();
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}

});
