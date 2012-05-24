Ext.define('Earsip.view.PemindahanRinciWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pemindahanrinci_win'
,	title		: 'Tambah Berkas'
,	itemId		: 'pemindahanrinci_win'
,   width		: 500
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'anchor'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/pemindahanrinci_submit.jsp'
	,	plain		: true
	,	frame		: true
	,	border		: 0
	,	bodyPadding	: 5	
	,	layout		: 'anchor'
	,	defaults	: {
			xtype	: 'textfield'	
		,	anchor	: '100%'
	}
	,	items		: [{	
			itemId			: 'pemindahan_id'
		,	name			: 'pemindahan_id'
		,	allowBlank		: false
		, 	hidden			: true
		},{
			xtype			: 'combo'
		,	fieldLabel		: 'Berkas'
		,	itemId			: 'berkas_id'
		,	name			: 'berkas_id'
		,	store			: Ext.create ('Earsip.store.BerkasPindah',{
				autoLoad	: true
			,	autoSync	: true
		})
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	editable		: false
		,	allowBlank		: false
		},{
			itemId			: 'status'
		,	name			: 'status'
		, 	hidden			: true
		},{
			itemId			: 'arsip_status_id'
		,	name			: 'arsip_status_id'
		, 	hidden			: true
		},{
			itemId			: 'kode_folder'
		,	name			: 'kode_folder'
		, 	hidden			: true
		},{
			itemId			: 'kode_rak'
		,	name			: 'kode_rak'
		, 	hidden			: true
		},{
			itemId			: 'kode_box'
		,	name			: 'kode_box'
		, 	hidden			: true
		}]
	}]
,	buttons			: [{
		text			: 'Simpan'
	,	type			: 'submit'
	,	action			: 'submit'
	,	iconCls			: 'save'
	,	formBind		: true
	}]
,	listeners	: {
		activate	: function (comp)
		{
			this.down ('#berkas_id').getStore ().load ()
		}
	}
});