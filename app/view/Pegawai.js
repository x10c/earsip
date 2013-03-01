Ext.require ([
	'Earsip.store.Pegawai'
,	'Earsip.store.UnitKerja'
,	'Earsip.store.Jabatan'
,	'Earsip.view.PegawaiWin'
]);

Ext.define ('Earsip.view.Pegawai', {
	extend		: 'Ext.grid.Panel'
,	id			: 'mas_pegawai'
,	alias		: 'widget.mas_pegawai'
,	itemId		: 'mas_pegawai'
,	store		: 'Pegawai'
,	title		: 'Data Pegawai'
,	closable	: true
,	plugins		: [
		Ext.create ('Earsip.plugin.RowEditor')
	]
,	columns		: [{
		text		: 'Nama Pegawai'
	,	dataIndex	: 'nama'
	,	flex		: 1
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'NIP'
	,	dataIndex	: 'nip'
	,	width		: 120
	,	editor		: {
			xtype		: 'textfield'
		,	allowBlank	: false
		}
	},{
		text		: 'Unit Kerja'
	,	dataIndex	: 'unit_kerja_id'
	,	width		: 150
	,	editor		: {
			xtype			: 'combo'
		,	store			: Ext.create ('Earsip.store.UnitKerja', {
				autoLoad		: true
			})
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	mode			: 'local'
		,	typeAhead		: false
		,	triggerAction	: 'all'
		,	lazyRender		: true
		}
	,	renderer	: function (v, md, r, rowidx, colidx)
		{
			return combo_renderer (v, this.columns[colidx]);
		}
	},{
		text		: 'Jabatan'
	,	dataIndex	: 'jabatan_id'
	,	width		: 150
	,	editor		: {
			xtype			: 'combo'
		,	store			: Ext.create ('Earsip.store.Jabatan', {
				autoLoad		: true
			})
		,	displayField	: 'nama'
		,	valueField		: 'id'
		,	mode			: 'local'
		,	typeAhead		: false
		,	triggerAction	: 'all'
		,	lazyRender		: true
		}
	,	renderer	: function (v, md, r, rowidx, colidx)
		{
			return combo_renderer (v, this.columns[colidx]);
		}
	},{
		text		: 'Status'
	,	dataIndex	: 'status'
	,	width		: 80
	,	editor		: {
			xtype			: 'checkbox'
		,	inputValue		: 1
		,	uncheckedValue	: 0
		}
	,	renderer	: function (v)
		{
			if (v == 1) {
				return 'Aktif';
			} else {
				return 'Non Aktif';
			}
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
			text		: 'Ubah'
		,	itemId		: 'edit'
		,	iconCls		: 'edit'
		,	action		: 'edit'
		,	disabled	: true
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	iconCls		: 'refresh'
		,	action		: 'refresh'
		},'-','->','-',{
			text		: 'Hapus'
		,	itemId		: 'del'
		,	iconCls		: 'del'
		,	action		: 'del'
		,	disabled	: true
		}]
	}]
,	listeners	: {
		activate	: function (comp)
		{
			this.getStore ().load ();
		}
	,	afterrender : function (comp)
		{
			this.win = Ext.create ('Earsip.view.PegawaiWin', {});
			this.win.hide ();
		}
	}
});
