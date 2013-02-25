Ext.require ([
	'Earsip.store.Label'
]);

Ext.define ('Earsip.view.Label', {
	extend 	: 'Ext.container.Container'
,	alias	: 'widget.lap_label'
,	itemId	: 'lap_label'
,	title	: 'Cetak Label'
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
		,	layout	: 'anchor'
		,	anchor	: '30%'
		,	defaults	: {
				xtype : 'textfield'
			,	anchor: '100%'
			}
		,	items	: [{
				xtype		: combo
			,	fieldLabel	: 'Divisi'
			,	itemId		: 'divisi_id'
			,	name		: 'divisi_id'
			,	store		: Ext.getStore ('UnitKerja')
			,	displayField	: 'nama'
			,	valueField		: 'id'
			,	triggerAction	: 'all'
			},{
				fieldLabel	: 'Kode Rak'
			,	itemId		: 'kode_rak'
			,	name		: 'kode_rak'
			,	allowBlank	: false
			},{
				fieldLabel	: 'Kode Box'
			,	itemId		: 'kode_bok'
			,	name		: 'kode_bok'
			,	allowBlank	: false
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
		,	renderer	: function(v)
			{return date_renderer (v);}
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
