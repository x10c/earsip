Ext.define ('Earsip.controller.Pegawai', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'mas_pegawai'
	,	selector: 'mas_pegawai'
	}]
,	init	: function ()
	{
		this.control ({
			'mas_pegawai': {
				selectionchange : this.do_select
			}
		,	'mas_pegawai button[action=add]': {
				click : this.do_add
			}
		,	'mas_pegawai button[action=edit]': {
				click : this.do_edit
			}
		,	'mas_pegawai button[action=refresh]': {
				click : this.do_refresh
			}
		,	'mas_pegawai button[action=del]': {
				click : this.do_del
			}
		});
	}

,	do_select : function (model, records)
	{
		var peg		= this.getMas_pegawai ();
		var b_edit	= peg.down ('#edit');
		var b_del	= peg.down ('#del');
		b_edit.setDisabled (! records.length);
		b_del.setDisabled (! records.length);
	}

,	do_add : function (b)
	{
	}

,	do_edit : function (b)
	{
	}

,	do_refresh : function (b)
	{
		this.getPegawai ().getStore ().load ();
	}

,	do_del : function (b)
	{
		/* set status to non-aktif */
	}
});
