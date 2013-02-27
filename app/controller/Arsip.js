Ext.define ('Earsip.controller.Arsip', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		:'mas_arsip'
	,	selector:'mas_arsip'
	},{
		ref		:'arsiplist'
	,	selector:'arsiplist'
	},{
		ref		:'arsipform'
	,	selector:'arsipform'
	},{
		ref		:'arsipcariwin'
	,	selector:'arsipcariwin'
	}]
,	init	: function ()
	{
		this.control ({
			'mas_arsip button[itemId=save]' : {
				click : this.do_save
			}
		,	'arsiplist': {
				selectionchange : this.list_selectionchange
			}
		,	'arsipcariwin button[itemId=search]' : {
				click : this.do_search
			}
		});
	}

,	do_save : function (b)
	{
		var form = this.getArsipform ().getForm ();

		if (! form.isValid ()) {
			return;
		}

		form.submit ({
			scope	: this
		,	params	:{
				action	:'update'
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
				} else {
					Ext.msg.error ('Gagal menyimpan data arsip!<br/><hr/>'+ action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error ('Gagal menyimpan data arsip!<br/><hr/>'+ action.result.info);
			}
		});
	}

,	list_selectionchange : function (model, records)
	{
		var arsip	= this.getMas_arsip ();
		var klas_id	= false;
		var list = this.getArsiplist ();
		var form = this.getMas_arsip ().down ('#arsip_form');

		list.down ('#cetak_label').setDisabled (! records.length > 0);

		if (records.length > 0) {
			form.loadRecord (records[0]);
			list.record			= records[0];
			Earsip.arsip.id		= records[0].get ('id');
			Earsip.arsip.pid	= records[0].get ('pid');
			klas_id				= records[0].get ('berkas_klas_id') != '' ? true : false;
		}
	}

,	do_search : function (b)
	{
		var cariform	= this.getArsipcariwin ().down ('form').getForm ();
		var list		= this.getArsiplist ();
		var list_store	= list.getStore ();
		var list_proxy	= list_store.getProxy ();
		var org_url		= list_proxy.url;

		list_proxy.url = 'data/arsip_cari.jsp'

		list_store.load ({
			params	: cariform.getValues ()
		});

		list_proxy.url = org_url;
	}
});
