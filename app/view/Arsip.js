Ext.require ([
	'Earsip.store.Arsip.UnitKerja'
,	'Earsip.store.Arsip.Rak'
,	'Earsip.store.Arsip.Box'
,	'Earsip.store.Arsip.Folder'
,	'Earsip.view.ArsipTree'
,	'Earsip.view.ArsipList'
,	'Earsip.view.ArsipForm'
]);

Ext.define ('Earsip.view.Arsip', {
	extend		: 'Ext.container.Container'
,	alias		: 'widget.mas_arsip'
,	itemId		: 'mas_arsip'
,	title		: 'Arsip'
,	layout		: 'border'
,	closable	: true
,	items		: [{
		xtype		:'panel'
	,	region		:'center'
	,	layout		:'border'
	,	items		: [{
			xtype		:'grid'
		,	itemId		:'arsip_uk'
		,	store		:'Arsip.UnitKerja'
		,	region		:'west'
		,	split		: true
		,	width		:200
		,	columns		:[{
				header		:'Unit Kerja'
			,	dataIndex	:'nama'
			,	flex		:1
			}]
		,	tbar		:[{
				iconCls		:'refresh'
			,	handler		:function (b)
				{
					b.up ('grid').do_refresh ();
				}
			}]
		,	listeners	:{
				selectionchange	:function (m, d)
				{
					var m = this.up ('#mas_arsip');

					m.down ('#arsip_rak').clearData ();
					m.down ('#arsip_box').clearData ();
					m.down ('#arsip_folder').clearData ();
					m.down ('#arsiplist').clearData ();

					Earsip.arsip.tree.type			= "";
					Earsip.arsip.tree.unit_kerja_id	= "0";
					Earsip.arsip.tree.kode_rak		= "0";
					Earsip.arsip.tree.kode_box		= "0";
					Earsip.arsip.tree.kode_folder	= "0";

					if (d.length > 0) {
						Earsip.arsip.tree.type			= d[0].get ('type');
						Earsip.arsip.tree.unit_kerja_id = d[0].get ('id');
						m.down ('#arsip_rak').do_refresh ();
					}
				}
			}
		,	do_refresh	:function ()
			{
				var m = this.up ('#mas_arsip');

				this.getStore ().load ();

				m.down ('#arsip_rak').clearData ();
				m.down ('#arsip_box').clearData ();
				m.down ('#arsip_folder').clearData ();
			}
		},{
			xtype		:'grid'
		,	itemId		:'arsip_rak'
		,	store		:'Arsip.Rak'
		,	split		: true
		,	region		:'west'
		,	width		:120
		,	columns		:[{
				header		:'Rak'
			,	dataIndex	:'kode_rak'
			,	flex		:1
			}]
		,	tbar		:[{
				iconCls		:'refresh'
			,	handler		:function (b)
				{
					b.up ('grid').do_refresh ();
				}
			}]
		,	listeners	:{
				selectionchange	:function (m, d)
				{
					var m = this.up ('#mas_arsip');

					m.down ('#arsip_box').clearData ();
					m.down ('#arsip_folder').clearData ();
					m.down ('#arsiplist').clearData ();
					m.down ('#arsiplist').down ('#cetak_label').setDisabled (! d.length > 0);

					Earsip.arsip.tree.type			= "";
					Earsip.arsip.tree.kode_rak		= "0";
					Earsip.arsip.tree.kode_box		= "0";
					Earsip.arsip.tree.kode_folder	= "0";

					if (d.length > 0) {
						Earsip.arsip.tree.type			= d[0].get ('type');
						Earsip.arsip.tree.kode_rak		= d[0].get ('kode_rak');
						m.down ('#arsip_box').do_refresh ();
					}
				}
			}
		,	do_refresh	:function ()
			{
				var id = Earsip.arsip.tree.unit_kerja_id;

				if (id == null || id == undefined || id <= 0) {
					this.clearData ();
				} else {
					this.getStore ().load ({
						params	:{
							id		:id
						}
					});
				}
			}
		},{
			xtype		:'grid'
		,	itemId		:'arsip_box'
		,	store		:'Arsip.Box'
		,	split		:true
		,	region		:'west'
		,	width		:120
		,	columns		:[{
				header		:'Box'
			,	dataIndex	:'kode_box'
			,	flex		:1
			}]
		,	tbar		:[{
				iconCls		:'refresh'
			,	handler		:function (b)
				{
					b.up ('grid').do_refresh ();
				}
			}]
		,	listeners	:{
				selectionchange	:function (v, d)
				{
					var m = this.up ('#mas_arsip');

					m.down ('#arsip_folder').clearData ();
					m.down ('#arsiplist').clearData ();

					Earsip.arsip.tree.type			= "";
					Earsip.arsip.tree.kode_box		= "0";
					Earsip.arsip.tree.kode_folder	= "0";

					if (d.length > 0) {
						Earsip.arsip.tree.type		= d[0].get ('type');
						Earsip.arsip.tree.kode_box	= d[0].get ('kode_box');
						m.down ('#arsip_folder').do_refresh ();
					}
				}
			}
		,	do_refresh	:function ()
			{
				var id			= Earsip.arsip.tree.unit_kerja_id;
				var kode_rak	= Earsip.arsip.tree.kode_rak;

				if (id == null || id == undefined || id <= 0) {
					this.clearData ();
				} else {
					this.getStore ().load ({
						params	:{
							id			:id
						,	kode_rak	:kode_rak
						}
					});
				}
			}
		},{
			xtype		:'grid'
		,	itemId		:'arsip_folder'
		,	store		:'Arsip.Folder'
		,	split		:true
		,	region		:'west'
		,	width		:120
		,	columns		:[{
				header		:'Folder'
			,	dataIndex	:'kode_folder'
			,	flex		:1
			}]
		,	tbar		:[{
				iconCls		:'refresh'
			,	handler		:function (b)
				{
					b.up ('grid').do_refresh ();
				}
			}]
		,	listeners	:{
				selectionchange	:function (m, d)
				{
					var m = this.up ('#mas_arsip');

					m.down ('#arsiplist').clearData ();

					Earsip.arsip.tree.type			= "";
					Earsip.arsip.tree.kode_folder	= "0";

					if (d.length > 0) {
						Earsip.arsip.tree.type			= d[0].get ('type');
						Earsip.arsip.tree.kode_folder	= d[0].get ('kode_folder');
						m.down ('#arsiplist').do_refresh ();
					}
				}
			}
		,	do_refresh	:function ()
			{
				var id			= Earsip.arsip.tree.unit_kerja_id;
				var kode_rak	= Earsip.arsip.tree.kode_rak;
				var kode_box	= Earsip.arsip.tree.kode_box;

				if (id == null || id == undefined || id <= 0) {
					this.clearData ();
				} else {
					this.getStore ().load ({
						params	:{
							id			:id
						,	kode_rak	:kode_rak
						,	kode_box	:kode_box
						}
					});
				}
			}

		},{
			xtype		:'arsiplist'
		,	width		:200
		,	region		:'center'
		}]
	},{
		xtype		: 'arsipform'
	,	region		: 'south'
	,	header		: false
	,	split		: true
	,	collapsible	: true
	}]

,	do_refresh:	function ()
	{
		this.down ('#arsip_uk').do_refresh ();
	}

,	arsip_baru_onclick: function ()
	{
		var arsip_form	= this.down ('#arsip_form');
		var f			= arsip_form.getForm ();

		if (! f.isValid ()) {
			Ext.msg.error ('Silahkan isi semua kolom yang bertanda "*" atau berwarna merah terlebih dahulu!');
			return;
		}

		f.submit ({
			scope	:this
		,	url		:'data/arsip_submit.jsp'
		,	params	:{
				action			:'create'
			,	unit_kerja_id	:arsip_form.down ('#unit_kerja_id').getValue ()
			}
		,	success	:function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
				} else {
					Ext.msg.error ('Gagal membuat arsip baru!<br/><hr/>'+ action.result.info);
				}
			}
		,	failure	:function (form, action)
			{
				Ext.msg.error ('Gagal membuat arsip baru!<br/><hr/>'+ action.result.info);
			}
		});
	}
});
