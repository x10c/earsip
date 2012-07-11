Ext.define ('Earsip.controller.LapBerkasJRA', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'lap_berkas_jra'
	,	selector: 'lap_berkas_jra'
	}]
,	init	: function ()
	{
		this.control ({
				'lap_berkas_jra button[action=print]': {
				click : this.do_print_berkas_jra
			}
		})
	}

,	do_print_berkas_jra : function (button)
	{
		var grid =this.getLap_berkas_jra ();
		var data = grid.getSelectionModel ().getSelection ();
		if (data.length <= 0) {
			return;
		}
		new Ext.Window({
			title	: 'Report Berkas JRA'
		,	height 	: 600
		, 	width	: 700 
		,	movable	: true
		,	modal	: true,
			items: [{
				xtype : 'component'
			,	autoEl : {
					tag		: 'iframe'
				,	src		: 'data/lapberkasjrareport_submit.jsp'
				,	height 	: '100%'
				,	width	: '100%'
				, 	style: 'border: 0 none'
				}
			}]
		}).show();
	}
});
