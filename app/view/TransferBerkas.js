Ext.require ([
	'Earsip.store.Pegawai'
]);

Ext.define ('Earsip.view.TransferBerkas', {
	extend		: 'Ext.Window'
,	alias		: 'widget.trans_transfer_berkas'
,	itemId		: 'trans_transfer_berkas'
,	title		: 'Transfer berkas antar pegawai'
,	closable	: true
,	autoHeight	: true
,	resizable	: false
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'transferberkas_form'
	,	url			: 'data/transfer_berkas.jsp'
	,	plain		: true
	,	border		: 0
	,	bodyPadding	: 5
	,	width		: 400
	,	defaults	: {
			labelAlign		: 'right'
		,	allowBlank		: false
		,	anchor			: '100%'
		,	forceSelection	: true
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	emptyText		: '-'
		}
	,	items		: [{
			xtype			: 'combo'
		,	itemId			: 'from_peg'
		,	name			: 'from_peg'
		,	fieldLabel		: 'Dari Pegawai'
		,	store			: Ext.create ('Earsip.store.Pegawai')
		},{
			xtype			: 'combo'
		,	itemId			: 'to_peg'
		,	name			: 'to_peg'
		,	fieldLabel		: 'Ke Pegawai'
		,	store			: Ext.create ('Earsip.store.Pegawai')
		}]
	,	buttons			: [{
			text	: 'Transfer'
		,	itemId	: "submit"
		,	type	: 'submit'
		,	action	: 'submit'
		,	iconCls	: 'save'
		,	formBind: true
		}]
	}]

,	from_peg_on_select : function (cb, records)
	{
		var to_peg	= this.down ('#to_peg');
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
		var form	= this.down ('form').getForm ();

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
					this.destroy();
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

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#from_peg").on ("select", this.from_peg_on_select, this);
		this.down ("#submit").on ("click", this.do_submit, this);
	}
});
