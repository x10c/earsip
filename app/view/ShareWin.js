Ext.require ([
	'Earsip.store.Pegawai'
,	'Earsip.store.BerkasBerbagi'
]);

var s_acl = Ext.create ('Ext.data.Store', {
	fields	: ['id','nama']
,	data	: [
		{id: 0	, nama:'Tidak berbagi'}
	,	{id: 1	, nama:'Lihat (pegawai tertentu)'}
	,	{id: 3	, nama:'Lihat (semua pegawai)'}
	]
});

Ext.define ('Earsip.view.ShareWin', {
	extend		: 'Ext.Window'
,	alias		: 'widget.sharewin'
,	itemId		: 'sharewin'
,	title		: 'Berbagi berkas'
,	width		: 400
,	closable	: true
,	closeAction	: 'hide'
,	autoHeight	: true
,	layout		: 'fit'
,	border		: false
,	items		: [{
		xtype		: 'form'
	,	itemId		: 'sharewin_form'
	,	plain		: true
	,	frame		: true
	,	autoScroll	: true
	,	layout		: 'anchor'
	,	defaults	: {
			xtype			: 'textfield'
		,	anchor			: '100%'
		,	selectOnFocus	: true
		,	labelAlign		: 'right'
		}
	,	items		: [{
			itemId		: 'id'
		,	name		: 'id'
		,	hidden		: true
		},{
			fieldLabel	: 'Nama'
		,	itemId		: 'nama'
		,	name		: 'nama'
		,	disabled	: true
		},{
			xtype		: 'combo'
		,	fieldLabel	: 'Hak akses'
		,	itemId		: 'akses_berbagi_id'
		,	name		: 'akses_berbagi_id'
		,	store		: s_acl
		,	valueField	: 'id'
		,	displayField: 'nama'
		,	allowBlank	: false
		,	autoSelect	: true
		,	autoScroll	: true
		,	editable	: false
		},{
			xtype		: 'grid'
		,	itemId		: 'sharewin_grid'
		,	name		: 'bagi_ke_peg_id'
		,	title		: 'Bagi ke pegawai'
		,	store		: 'BerkasBerbagi'
		,	height		: 400
		,	disabled	: true
		,	plugins		:
			[
				Ext.create ('Earsip.plugin.RowEditor')
			]
		,	columns		: [{
				text		: 'Pegawai'
			,	dataIndex	: 'bagi_ke_peg_id'
			,	flex		: 1
			,	editor		: {
					xtype			: 'combobox'
				,	itemId			: 'pegawai'
				,	store			: 'Pegawai'
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
		,	dockedItems	: [{
				xtype		: 'toolbar'
			,	dock		: 'top'
			,	flex		: 1
			,	items		: [{
					itemId		: 'add'
				,	iconCls		: 'add'
				},'-',{
					itemId		: 'del'
				,	iconCls		: 'del'
				}]
			}]
		}]
	,	buttons		: [{
			text		: 'Bagi'
		,	iconCls		: 'save'
		,	itemId		: 'save'
		}]
	}]

,	load : function (record)
	{
		var grid = this.down ('#sharewin_grid');

		Ext.data.StoreManager.lookup ('Pegawai').load ({
			scope	: this
		,	callback: function (r, op, success)
			{
				if (success) {
					this.down ('#sharewin_form').loadRecord (record);

					grid.getStore ().load ({
						params	: {
							berkas_id : record.get ('id')
						}
					});

					var hak_akses_id = record.get ('akses_berbagi_id');
					if (hak_akses_id == 1 || hak_akses_id == 2) {
						grid.setDisabled (false);
					}
				}
			}
		});
	}
});
