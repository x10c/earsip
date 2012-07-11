Ext.require ([
	'Earsip.store.LapBerkasMusnah'
]);

Ext.define ('Earsip.view.LapBerkasMusnah', {
	extend 	: 'Ext.container.Container'
,	alias	: 'widget.lap_berkas_musnah'
,	itemId	: 'lap_berkas_musnah'
,	title	: 'Laporan Berkas Musnah'
,	layout	: 'border'
,	closable: true
,	items	: [{
		xtype	: 'form'
	,	region	: 'center'
	,	split		: true
	,	collapsible	: true
	,	header		: false
	,	frame		: true
	,	padding		: 5
	,	itemId		: 'form_berkas_musnah'
	,	layout		: 'anchor'
	,	defaults	: {
			xtype			: 'textfield'
		,	selectOnFocus	: true
		,	labelAlign		: 'right'
		}
	,	items		: [{
			xtype	: 'fieldset'
		,	title	: 'Filter Tanggal Pemusnahan'
		,	layout	: 'anchor'
		,	anchor	: '30%'
		,	defaults	: {
				xtype : 'datefield'
			,	anchor: '100%'
			}
		,	items	: [{
				fieldLabel	: 'Setelah Tanggal'
			,	itemId		: 'setelah_tgl'
			,	name		: 'setelah_tgl'
			,	format		: 'Y-m-d'
			,	editable	: false
			,	allowBlank	: false
			,	value		: new Date ()
			},{
				fieldLabel	: 'Sebelum Tanggal'
			,	itemId		: 'sebelum_tgl'
			,	name		: 'sebelum_tgl'
			,	format		: 'Y-m-d'
			,	editable	: false
			,	allowBlank	: false
			,	value		: new Date ()
			},{
				xtype			: 'button'
			,	text			: 'Filter'
			,	type			: 'filter'
			,	action			: 'filter'
			,	iconCls			: 'upload'
			}]
		}]
	},{
		xtype		: 'grid'
	,	region		: 'south'
	,	flex		: 3
	,	itemId		: 'grid_berkas_musnah'
	,	title		: 'Daftar Berkas Musnah'
	,	store		: 'LapBerkasMusnah'
	,	columns		: [{
			xtype		: 'rownumberer'
		},{
			text		: 'Nama Berkas'
		,	dataIndex	: 'nama'
		,	flex		: 1
		},{
			text		: 'Kode'
		,	dataIndex	: 'kode'
		,	flex		: 1
		},{
			text		: 'Judul'
		,	dataIndex	: 'judul'
		,	flex		: 1
		},{
			text		: 'Musnah Tanggal'
		,	dataIndex	: 'tgl'
		,	flex		: 1
		},{
			text		: 'Keterangan'
		,	dataIndex	: 'keterangan'
		,	flex		: 1
		}]
	,	dockedItems	: [{
			xtype		: 'toolbar'
		,	pos			: 'top'
		,	items		: [{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
			}]
		}]
	}]
,	listeners	: {
		activate : function (comp)
		{
		
			this.down ('#grid_berkas_musnah').getStore ().load ({
				params	: {
					setelah_tgl : this.down ('#setelah_tgl').getValue ()
				,	sebelum_tgl	: this.down ('#sebelum_tgl').getValue ()
				}
			});
		}
	}

});
