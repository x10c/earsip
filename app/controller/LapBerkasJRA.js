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
			,	'lap_berkas_jra button[itemId=refresh]': {
					click : this.do_refresh
				}
		})
	}

,	do_print_berkas_jra : function (button)
	{
		var grid =this.getLap_berkas_jra ();
		var records = grid.getStore ().getRange ();
		if (records.length <= 0) {
			return;
		}
		window.open ('data/lapberkasjrareport_submit.jsp');
	}

,	do_refresh : function (b)
	{
		var p = this.getLap_berkas_jra ();
		p.getStore ().load ();
	}
});
