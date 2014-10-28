Ext.define ('Earsip.controller.Trash', {
	extend		: 'Ext.app.Controller'
,	refs		: [{
		ref			: 'trash'
	,	selector	: 'trash'
	},{
		ref			: 'trashlist'
	,	selector	: 'trashlist'
	}]
,	init		: function ()
	{
		this.control ({
			'trashlist' : {
				selectionchange : this.do_selectionchange
			}
		,	'trashlist button[itemId=restore]' : {
				click : this.do_restore
			}
		});
	}

,	do_selectionchange : function (model, records)
	{
		var trash = this.getTrash ();

		if (records.length > 0) {
			trash.down ('#berkasform').loadRecord (records[0]);
		}
		this.getTrashlist ().down ('#restore').setDisabled (! records.length);
	}

,	do_restore : function (b)
	{
		var form			= this.getTrash ().down ('#berkasform');
		var stat_hapus_f	= form.getComponent ('status_hapus');

		Ext.Msg.confirm ('Konfirmasi'
		, 'Apakah anda yakin mau mengembalikan berkas tersebut?'
		, function (b)
		{
			if (b == 'no') {
				return;
			}

			stat_hapus_f.setValue (1);

			form.submit ({
				scope	: this
			,	success	: function (form, action)
				{
					if (action.result.success == true) {
						this.getTrashlist ().do_load_list ();
					} else {
						Ext.msg.error (action.result.info);
					}
				}
			,	failure	: function (form, action)
				{
					Ext.msg.error (action.result.info);
				}
			});
		}
		, this);
	}
});
