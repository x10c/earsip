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
			,	editable	: false
			,	allowBlank	: false
			,	value		: new Date ()
			},{
				fieldLabel	: 'Sebelum Tanggal'
			,	itemId		: 'sebelum_tgl'
			,	name		: 'sebelum_tgl'
			,	editable	: false
			,	allowBlank	: false
			,	value		: new Date ()
			},{
				xtype			: 'button'
			,	text			: 'Filter'
			,	type			: 'filter'
			,	action			: 'filter'
			,	iconCls			: 'upload'
			,	itemId			: "filter"
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
			text		: 'Perihal'
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
			,	itemId		: "print"
			}]
		}]
	}]

,	listeners	:
	{
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

,	do_filter : function (b)
	{
		var setelah_tgl_str = this.down ('#setelah_tgl').getValue ();
		var sebelum_tgl_str = this.down ('#sebelum_tgl').getValue ();

		var grid = this.down ('#grid_berkas_musnah');

		grid.getStore ().load ({
			params	: {
				setelah_tgl : setelah_tgl_str
			,	sebelum_tgl	: sebelum_tgl_str
			}
		});
	}

,	do_print : function (b)
	{
		var setelah_tgl_str = this.down ('#setelah_tgl').getSubmitValue ();
		var sebelum_tgl_str = this.down ('#sebelum_tgl').getSubmitValue ();

		var grid = this.down ('#grid_berkas_musnah');
		var r = grid.getStore ().getRange ();

		if (r.length <= 0) {
			return;
		}

		window.open ('data/lapberkasmusnahreport_submit.jsp'
					+'?setelah_tgl='+ setelah_tgl_str
					+'&sebelum_tgl='+ sebelum_tgl_str);
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#filter").on ("click", this.do_filter, this);
		this.down ("#print").on ("click", this.do_print, this);
	}
});
