Ext.require ([
	'Earsip.store.BerkasPinjam'
,	'Earsip.store.PeminjamanRinci'
]);

Ext.define('Earsip.view.PeminjamanWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.peminjaman_win'
,	title		: 'Peminjaman'
,	itemId		: 'peminjaman_win'
,   width		: 800
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	closeAction	: 'hide'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/peminjaman_submit.jsp'
	,	itemId		: 'peminjaman_win_form'
	,	plain		: true
	,	frame		: true
	,	autoScroll	: true
	,	border		: 0
	,	bodyPadding	: 5	
	,	defaults	: {
			xtype	: 'textfield'
		,	anchor	: '100%'
	}
	,	fieldDefaults: {
            labelAlign: 'top'
    }
	,	items		: [{
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		,	xtype			: 'textfield'
		},{
			xtype			: 'container'
		,	plain			: true
		,	layout			: 'column'
		,	items	: [{
				xtype		: 'container'
			,	columnWidth	: .5
			,	layout		: 'anchor'
			, 	defaults	: {
						anchor		: '96%'
				}
			,	items		: [{
					xtype		: 'fieldset'
				,	title		: 'Data Petugas'
				,	layout		: 'anchor'
				,	defaults	: {
						xtype	: 'textfield'
					,	anchor	: '100%'
					}
				,	items	: [{
						fieldLabel		: 'Nama Petugas'
					,	itemId			: 'nama_petugas'
					,	name			: 'nama_petugas'
					,	disabled 		: true
					},{
						fieldLabel		: 'Nama Pimpinan'
					,	itemId			: 'nama_pimpinan_petugas'
					,	name			: 'nama_pimpinan_petugas'
					,	allowBlank		: false
					}]
				},{
					xtype		:'fieldset'
				,	title		: 'Data Pengembalian'
				,   layout		: 'anchor'
				,   defaults	: {
						xtype	: 'datefield'
					,	anchor	: '100%'
					}
				,	items	: [{
						xtype			: 'datefield'
					,	fieldLabel		: 'Tanggal Peminjaman'
					,	itemId			: 'tgl_pinjam'
					,	name			: 'tgl_pinjam'
					,	value			: new Date ()
					,	editable		: false
					},{
						xtype			: 'datefield'
					,	fieldLabel		: 'Tanggal Batas Pengembalian'
					,	itemId			: 'tgl_batas_kembali'
					,	name			: 'tgl_batas_kembali'
					,	allowblank		: false
					,	editable		: false
					,	value			: new Date ()
					},{
						xtype			: 'datefield'
					,	itemId			: 'tgl_kembali'
					,	name			: 'tgl_kembali'
					//,	format			: 'Y-m-d'
					, 	value			: 'null'
					,	hidden			: true
					}]
				}]
			},{
				xtype		: 'container'
			,	columnWidth	: .5
			,	layout		: 'anchor'
			,	items		: [{
					xtype		:'fieldset'
				,	title		: 'Data Peminjam'
				,   defaultType	: 'textfield'
				,	layout		: 'anchor'
				,	anchor		: '100%'
				,   defaults	: {
						anchor	: '100%'
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
						fieldLabel		: 'Nama Peminjam'
					,	itemId			: 'nama_peminjam'
					,	name			: 'nama_peminjam'
					,	allowBlank		: false
					}]
				},{
					xtype			: 'textarea'
				,	anchor			: '100%'
				, 	fieldLabel		: 'Keterangan'
				,	itemId			: 'keterangan'
				,	name			: 'keterangan'
				}]
			}]
		},{
			xtype			: 'grid'
		,	itemId			: 'peminjaman_rinci'
		,	title			: 'Rincian Peminjaman'
		,	height			: 200
		,	store			: 'PeminjamanRinci'
		,	disabled		: true
		,	plugins			:
		[
			Ext.create ('Earsip.plugin.RowEditor')
		]
		,	columns			: [{
				text		: 'Berkas'
			,	dataIndex	: 'berkas_id'
			,	flex		: 1
			,	editor		: {
					xtype			: 'combobox'
				,	store			: 'BerkasPinjam'
				,	valueField		: 'id'
				,	displayField	: 'nama'
				,	allowBlank		: false
				,	autoSelect		: true
				,	triggerAction	: 'all'
				,	pageSize		:Earsip.pageSize
				,	typeAhead		:true
				,	forceSelection	:true
				}
			,	renderer	: function (v, md, r, rowidx, colidx)
				{
					var n = combo_renderer (v, this.columns[colidx]);
					if (n == v) {
						return r.get ('nama');
					}

					return n;
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
,	buttons			: [{
		text			: 'Simpan'
	,	type			: 'submit'
	,	action			: 'submit'
	,	iconCls			: 'save'
	,	formBind		: true
	}]
	
,	do_load : function (record)
	{
		var grid	= this.down ('#peminjaman_rinci');
		var form	= this.down ('form');
		var store	= Ext.data.StoreManager.lookup ('BerkasPinjam');

		form.loadRecord (record);
		store.clearFilter ();
		store.load ();
		
	}
,	listeners : {
		hide	: function (comp){
			var store	= Ext.data.StoreManager.lookup ('BerkasPinjam');
			store.clearFilter ();
			store.load ();
		}
	}
});
