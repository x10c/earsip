Ext.require ([
	'Earsip.store.BerkasMusnah'
,	'Earsip.store.PemusnahanRinci'
,   'Earsip.store.TimPemusnahan'
,	'Earsip.store.Jabatan'
]);

Ext.define('Earsip.view.PemusnahanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pemusnahan_win'
,	id			: 'pemusnahan_win'
,	title		: 'Pemusnahan'
,	itemId		: 'pemusnahan_win'
,   width		: 800
,	autoHeight	: true
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype	: 'panel'
	,	layout	: 'anchor'
	,	defaults: {
			autoScroll	: true
		}
	,	items	: [{
			xtype	: 'panel'
		,	layout	: 'anchor'
		,	frame	: true
		,	items	: [{
				xtype		: 'form'
			,	url			: 'data/pemusnahan_submit.jsp'
			,	plain		: true
			,	frame		: true
			,	border		: 0
			,	bodyPadding	: 5	
			,	layout		: 'anchor'
			,	region		: 'center'
			,	defaults	: {
					xtype		: 'textfield'
				,	anchor		: '100%'
				,	labelWidth	: 200
				,	labelAlign	: 'right'
				}
			,	items		: [{
					hidden			: true
				,	itemId			: 'id'
				,	name			: 'id'
				},{
					xtype			: 'combo'
				,	fieldLabel		: 'Metoda Pemusnahan'
				,	itemId			: 'metoda_id'
				,	name			: 'metoda_id'
				,	store			: 'MetodaPemusnahan'
				,	displayField	: 'nama'
				,	valueField		: 'id'
				,	editable		: false
				,	allowBlank		: false
				},{
					fieldLabel		: 'Nama Petugas'
				,	itemId			: 'nama_petugas'
				,	name			: 'nama_petugas'
				,	allowBlank		: false
				,	disabled		: true
				},{
					xtype			: 'datefield'
				,	fieldLabel		: 'Tanggal Pemusnahan'
				,	itemId			: 'tgl'
				,	name			: 'tgl'
				,	format			: 'Y-m-d'
				,	allowBlank		: false
				,	editable		: false
				,	value			: new Date ()
				},{
					fieldLabel		: 'PJ. Unit Kerja'
				,	itemId			: 'pj_unit_kerja'
				,	name			: 'pj_unit_kerja'
				,	allowBlank		: false
				},{
					fieldLabel		: 'PJ. Pusat Berkas/Arsip'
				,	itemId			: 'pj_berkas_arsip'
				,	name			: 'pj_berkas_arsip'
				,	allowBlank		: false
				}]
			}]
		},{
			xtype	: 'tabpanel'
		,	region	: 'south'
		,	flex	: 1
		,	items	: [{
				xtype	: 'grid'
			,	itemId	: 'tim_pemusnah_grid'
			,	alias	: 'widget.tim_pemusnah_grid'
			,	title	: 'Tim Pemusnah'
			,	height	: 200
			,	store	: 'TimPemusnahan'
			,	plugins	: 
				[
					Ext.create ('Earsip.plugin.RowEditor')
				]
			,	columns	: [{
					xtype	: 'rownumberer'
				},{
					text	 : 'Nama'
				,	dataIndex: 'nama'
				,	flex	 : 1
				,	editor	 : {
						xtype : 'textfield'
					,	allowBlank: false
					}
				},{	
					text	 	: 'Jabatan'
				,	dataIndex	: 'jabatan'
				,	flex	 	: 1
				,	editor		: {
						xtype			: 'combobox'
					,	store			: 'Jabatan'
					,	valueField		: 'nama'
					,	displayField	: 'nama'
					,	allowBlank		: false
					,	autoSelect		: true
					,	triggerAction	: 'all'
					}
				,	renderer	: function (v, md, r, rowidx, colidx)
					{
						return combo_renderer (v, this.columns[colidx]);
					}
				}]
			,	dockedItems	: [{
					xtype		: 'toolbar'
				,	pos			: 'top'
				,	items		: [{
						text		: 'Tambah'
					,	itemId		: 'add'
					,	iconCls		: 'add'
					,	action		: 'add'
					},'-',{
						text		: 'Hapus'
					,	itemId		: 'del'
					,	iconCls		: 'del'
					,	action		: 'del'
					}]
				}]
			},{
				xtype	: 'grid'
			,	itemId	: 'berkas_musnah_grid'
			,	alias	: 'widget.berkas_musnah_grid'
			,	title	: 'Daftar Berkas'
			,	height	: 200
			,	store	: 'PemusnahanRinci'
			,	plugins	: [
					Ext.create ('Earsip.plugin.RowEditor')
				]
			,	columns	: [{
					xtype	: 'rownumberer'
				},{
					text	 	: 'Berkas'
				,	dataIndex	: 'berkas_id'
				,	flex	 	: 1
				,	editor		: {
						xtype			: 'combobox'
					,	store			: 'BerkasMusnah'
					,	valueField		: 'id'
					,	displayField	: 'nama'
					,	allowBlank		: false
					,	autoSelect		: true
					,	triggerAction	: 'all'
					}
				,	renderer	: function (v, md, r, rowidx, colidx)
					{
						return combo_renderer (v, this.columns[colidx]);
					}
				},{
					text	 	: 'Keterangan'
				,	dataIndex	: 'keterangan'
				,	flex	 	: 2
				,	editor		: {
						xtype : 'textfield'
					}
				},{
					text	 	: 'Jumlah Lembar'
				,	dataIndex	: 'jml_lembar'
				,	width	 	: 110
				,	editor		: {
						xtype : 'numberfield'
					,	allowBlank: false
					}
				},{	
					text	 	: 'Jumlah Set'
				,	dataIndex	: 'jml_set'
				,	width	 	: 80
				,	allowBlank	: false
				,	editor		: {
						xtype : 'numberfield'
					,	allowBlank: false
					}
				},{	
					text	 	: 'Jumlah Berkas'
				,	dataIndex	: 'jml_berkas'
				,	width	 	: 100
				,	allowBlank	: false
				,	editor		: {
						xtype : 'numberfield'
					,	allowBlank: false
					}
				}]
			,	dockedItems	: [{
					xtype		: 'toolbar'
				,	pos			: 'top'
				,	items		: [{
						text		: 'Tambah'
					,	itemId		: 'add'
					,	iconCls		: 'add'
					,	action		: 'add'
					},'-',{
						text		: 'Hapus'
					,	itemId		: 'del'
					,	iconCls		: 'del'
					,	action		: 'del'
					}]
				}]
			}]
		}]
	}]
,	buttons			: [{
		text			: 'Simpan'
	,	type			: 'submit'
	,	action			: 'submit'
	,	iconCls			: 'save'
	,	formBind		: true
	}]
,	load : function (record)
	{
		var grid_berkas = this.down ('#berkas_musnah_grid');
		var grid_tim = this.down ('#tim_pemusnah_grid');
		var form = this.down ('form');
		Ext.data.StoreManager.lookup ('BerkasMusnah').load ({
			scope	: this
		,	callback: function (r, op, success)
			{
				if (success) {
					form.loadRecord (record);
					grid_berkas.getStore ().load ({
						params	: {
							pemusnahan_id  : record.get ('id')
						}
					});
					grid_tim.getStore ().load ({
						params	: {
							pemusnahan_id  : record.get ('id')
						}
					});
				}
			}
		});
		Ext.data.StoreManager.lookup ('BerkasMusnah').clearFilter ();
	}
});
