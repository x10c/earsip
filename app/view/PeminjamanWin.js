Ext.require ('Earsip.store.BerkasPinjam');

Ext.define('Earsip.view.PeminjamanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.peminjaman_win'
,	title		: 'Peminjaman'
,	itemId		: 'peminjaman_win'
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
	,	url			: 'data/peminjaman_submit.jsp'
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
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		},{
			xtype		:'fieldset'
		,	title		: 'Data Petugas'
        ,   collapsible	: true
        ,   layout		: 'anchor'
        ,   defaults	: {
				xtype	: 'textfield'
			,	anchor	: '100%'
			}
		,	items	: [{
				fieldLabel		: 'Nama'
			,	itemId			: 'nama_petugas'
			,	name			: 'nama_petugas'
			,	value			: new String (Earsip.username)
			//,	disabled 		: true
			},{
				fieldLabel		: 'Nama Pimpinan'
			,	itemId			: 'nama_pimpinan_petugas'
			,	name			: 'nama_pimpinan_petugas'
			,	allowBlank		: false
			}]
		},{
			xtype		:'fieldset'
		,	title		: 'Data Peminjam'
        ,   collapsible	: true
        ,   defaultType	: 'textfield'
        ,   layout		: 'anchor'
        ,   defaults	: {
				xtype	: 'textfield'
			,	anchor	: '100%'
			}
		,	items	: [{
				xtype			: 'combo'
			,	fieldLabel		: 'Unit Kerja'
			,	itemId			: 'unit_kerja_peminjam_id'
			,	name			: 'unit_kerja_peminjam_id'
			,	store			: 'UnitKerja'
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	editable		: false
			,	allowBlank		: false
			},{
				fieldLabel		: 'Nama Pimpinan'
			,	itemId			: 'nama_pimpinan_peminjam'
			,	name			: 'nama_pimpinan_peminjam'
			,	allowBlank		: false
			},{
				fieldLabel		: 'Nama'
			,	itemId			: 'nama_peminjam'
			,	name			: 'nama_peminjam'
			,	allowBlank		: false
			}]
		},{
			xtype		:'fieldset'
		,	title		: 'Data Pengembalian'
        ,   collapsible	: true
        ,   layout		: 'anchor'
        ,   defaults	: {
                xtype	: 'textfield'
			,	anchor	: '100%'
			}
		,	items	: [{
				xtype			: 'datefield'
			,	fieldLabel		: 'Tanggal Peminjaman'
			,	itemId			: 'tgl_pinjam'
			,	name			: 'tgl_pinjam'
			,	format			: 'Y-m-d'
			,	value			: new Date ()
			,	editable		: false
			
			},{
				xtype			: 'datefield'
			,	fieldLabel		: 'Tanggal Batas Pengembalian'
			,	itemId			: 'tgl_batas_kembali'
			,	name			: 'tgl_batas_kembali'
			,	format			: 'Y-m-d'
			,	allowblank		: false
			,	editable		: false
			,	value			: new Date ()
			
			},{
				xtype			: 'datefield'
			,	itemId			: 'tgl_kembali'
			,	name			: 'tgl_kembali'
			,	format			: 'Y-m-d'
			, 	value			: 'null'
			,	hidden			: true
			
			}]
		},{
			xtype			: 'textarea'
		, 	fieldLabel		: 'Keterangan'
		,	itemId			: 'keterangan'
		,	name			: 'keterangan'
		
		},{
			xtype			: 'grid'
		,	itemId			: 'peminjaman_rinci'
		,	title			: 'Rincian Peminjaman'
		,	minHeight		: 200
		,	store			: 'PeminjamanRinci'
		,	disabled		: true
		,	plugins			:
		[
			Ext.create ('Earsip.plugin.RowEditor')
		]
		,	columns			: [{
				text			: 'ID'
			,	dataIndex		: 'peminjaman_id'
			,	hidden			: true
			,	hideable		: false
			},{
				text		: 'Berkas'
			,	dataIndex	: 'berkas_id'
			,	allowBlank	: false
			,	flex		: 0.5
			,	editor		: {
					xtype			: 'combo'
				,	store			: Ext.create ('Earsip.store.BerkasPinjam', {
						autoLoad		: true
					})
				,	displayField	: 'nama'
				,	valueField		: 'id'
				,	mode			: 'local'
				,	editable		: false
				,	triggerAction	: 'all'
				,	lazyRender		: true
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
				,	disabled	: true
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
		var grid = this.down ('#peminjaman_rinci');

		Ext.data.StoreManager.lookup ('BerkasPinjam').load ({
			scope	: this
		,	callback: function (r, op, success)
			{
				if (success) {
					this.down ('form').getForm ().loadRecord (record);

					grid.params = {
						peminjaman_id  : record ().get ('id')
					}
					grid.getStore ().load ({
						params	: grid.params
					});
				}
			}
		});
	}
});