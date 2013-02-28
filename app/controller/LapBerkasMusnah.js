Ext.define ('Earsip.controller.LapBerkasMusnah', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'lap_berkas_musnah'
	,	selector: 'lap_berkas_musnah'
	}]
,	init	: function ()
	{
		this.control ({
			'lap_berkas_musnah #form_berkas_musnah button[action=filter]': {
				click : this.do_filter
			}
		,	'lap_berkas_musnah #grid_berkas_musnah button[action=print]': {
				click : this.do_print_berkas_musnah
			}
		})
	}
,	do_filter : function (button)
	{	
		var setelah_tgl_str = this.getLap_berkas_musnah ().down ('#setelah_tgl').getValue ();
		var sebelum_tgl_str = this.getLap_berkas_musnah ().down ('#sebelum_tgl').getValue ();
		var grid = this.getLap_berkas_musnah ().down ('#grid_berkas_musnah');
			grid.getStore ().load ({
				params	: {
					setelah_tgl : setelah_tgl_str
				,	sebelum_tgl	: sebelum_tgl_str
				}
			});

	}
,	do_print_berkas_musnah : function (button)
	{	
		var setelah_tgl_str = this.getLap_berkas_musnah ().down ('#setelah_tgl').getSubmitValue ();
		var sebelum_tgl_str = this.getLap_berkas_musnah ().down ('#sebelum_tgl').getSubmitValue ();
		var grid =this.getLap_berkas_musnah ().down ('grid');
		var records = grid.getStore ().getRange ();
		if (records.length <= 0) {
			return;
		}
		
		window.open ('data/lapberkasmusnahreport_submit.jsp?setelah_tgl=' + setelah_tgl_str + '&sebelum_tgl=' + sebelum_tgl_str);
	}
});
