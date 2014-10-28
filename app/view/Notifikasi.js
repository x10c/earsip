Ext.require ([
	'Earsip.view.BerkasJRA'
,	'Earsip.view.NotifPemindahan'
,	'Earsip.view.NotifPeminjaman'
]);

Ext.define ('Earsip.view.Notifikasi', {
	extend		: 'Ext.tab.Panel'
,	alias		: 'widget.notifikasi'
,	itemId		: 'notifikasi'
,	title		: 'Notifikasi'
,	layoutConfig: {
        // layout-specific configs go here
        titleCollapse: false
	,	animate: true
	,	activeOnTop: true
    }
,	listeners	:{
		activate	:function (c)
		{
			c.down ('#berkas_jra').do_refresh ();

			if (Earsip.is_p_arsip){
				c.down ('#notif_pemindahan').do_refresh ();
				c.down ('#notif_peminjaman').do_refresh ();
			}
		}
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
