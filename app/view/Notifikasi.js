Ext.require ([
	'Earsip.view.BerkasJRA'
,	'Earsip.view.NotifPemindahan'
,	'Earsip.view.NotifPeminjaman'
]);


Ext.define ('Earsip.view.Notifikasi', {
	extend		: 'Ext.panel.Panel'
,	alias		: 'widget.notifikasi'
,	itemId		: 'notifikasi'
,	title		: 'Notifikasi'
,	layout		: 'accordion'
,	defaults: {
        // applied to each contained panel
        bodyStyle: 'padding:15px'
    }
,	layoutConfig: {
        // layout-specific configs go here
        titleCollapse: false
	,	animate: true
	,	activeOnTop: true
    }
,	do_load_items : function(){
		this.suspendLayout = true;
		this.removeAll (true);
		this.add ({
			xtype	: 'berkas_jra'
		});
		if (Earsip.is_p_arsip){
			this.add ([{
				xtype	: 'notif_pemindahan'
			},{
				xtype	: 'notif_peminjaman'
			}]);
		}
		
		this.suspendLayout = false;
		this.doLayout ();
	}
});
