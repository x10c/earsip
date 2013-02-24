Ext.require ([
	'Earsip.view.TransferBerkas'
]);

Ext.define ('Earsip.controller.TransferBerkas', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'trans_transfer_berkas'
	,	selector: 'trans_transfer_berkas'
	}]
,	init	: function ()
	{
		this.control ({
			'trans_transfer_berkas combo[itemId=from_peg]': {
				select		: this.on_select_from_peg
			}
		,	'trans_transfer_berkas button[action=submit]': {
				click		: this.do_submit
			}
		});
	}

,	on_select_from_peg : function (cb, records)
	{
		var to_peg	= this.getTrans_transfer_berkas ().down ('#to_peg');
		var store	= to_peg.getStore ();
		var id		= records[0].get ('id');

		store.clearFilter ();
		store.filter ([{
			filterFn : function (item) {
				return !(item.get ('id') == id);
			}
		}]);
	}

,	do_submit : function (b)
	{
		var win		= b.up ('#trans_transfer_berkas');
		var form	= win.down ('form').getForm ();

		if (! form.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang kosong terlebih dahulu.');
			return;
		}
		form.submit ({
			scope	: this
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					win.destroy();
				} else {
					Ext.msg.error (action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error ('Gagal melakukan koneksi ke server!');
			}
		});
	}
});
