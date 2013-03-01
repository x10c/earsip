Ext.require ([
	'Earsip.store.BerkasPinjam'
,	'Earsip.store.PeminjamanRinci'
]);

Ext.define('Earsip.view.PengembalianWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.pengembalian_win'
,	id			: 'pengembalian_win'
,	title		: 'Pengembalian'
,	itemId		: 'pengembalian_win'
,   width		: 400
,	closable	: true
,	resizable	: false
,	draggable	: false
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	closeAction	: 'destroy'
,	items		: [{
		xtype		: 'form'
	,	url			: 'data/pengembalian_submit.jsp'
	,	plain		: true
	,	frame		: true
	,	autoScroll	: true
	,	border		: 0
	,	bodyPadding	: 5	
	,	defaults	: {
			xtype	: 'field'
		,	anchor	: '100%'
	}
	,	fieldDefaults: {
            labelAlign: 'top'
	}
	,	items		: [{
			hidden			: true
		,	itemId			: 'id'
		,	name			: 'id'
		},{
			xtype		:'fieldset'
		,	title		: 'Data Peminjam'
		,   collapsible	: true
		,	collapsed	: true
		,   defaultType	: 'field'
		,   defaults	: {
				xtype	: 'field'
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
			,	disabled		: true
			},{
				fieldLabel		: 'Nama Pimpinan'
			,	itemId			: 'nama_pimpinan_peminjam'
			,	name			: 'nama_pimpinan_peminjam'
			,	disabled		: true

			},{
				fieldLabel		: 'Nama Peminjam'
			,	itemId			: 'nama_peminjam'
			,	name			: 'nama_peminjam'
			,	disabled		: true

			}]
		},{
			xtype		:'fieldset'
		,	title		: 'Data Pengembalian'
		,   collapsible	: true
		,	items	: [{
				xtype			: 'datefield'
			,	fieldLabel		: 'Tanggal Pengembalian'
			,	itemId			: 'tgl_kembali'
			,	name			: 'tgl_kembali'
			,	anchor			: '100%'
			,	allowBlank		: false
			}]
		},{
			xtype			: 'grid'
		,	itemId			: 'peminjaman_rinci'
		,	title			: 'Rincian Peminjaman'
		,	height			: 200
		,	store			: 'PeminjamanRinci'
		,	plugins			: [
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
				}
			,	renderer	: function (v, md, r, rowidx, colidx)
				{
					return combo_renderer (v, this.columns[colidx]);
				}
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
		var form = this.down ('form');
		
		Ext.data.StoreManager.lookup ('BerkasPinjam').load ({
			scope	: this
		,	callback: function (r, op, success)
			{
				if (success) {
					form.loadRecord (record);
					grid.getStore ().load ({
						params	: {
							peminjaman_id  : form.getRecord ().get ('id')
						}
					});
				}
			}
		});
		Ext.data.StoreManager.lookup ('BerkasPinjam').clearFilter ();
	}
});
