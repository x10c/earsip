Ext.require ([
	'Earsip.store.MetodaPemusnahan'
,	'Earsip.store.Pemusnahan'
,	'Earsip.view.PemusnahanWin'
]);

Ext.define ('Earsip.view.Pemusnahan', {
	extend	: 'Ext.panel.Panel'
,	alias	: 'widget.trans_pemusnahan'
,	itemId	: 'trans_pemusnahan'
,	title	: 'Pemusnahan'
,	plain	: true
,	layout	: 'border'
,	closable : true
, 	defaults	: {
		split	: true
	,	autoScroll : true
	}
,	items	: [{
		xtype			: 'grid'
	,	itemId			: 'pemusnahan_grid'
	,	alias			: 'widget.pemusnahan_grid'
	,	title			: 'Daftar Pemusnahan'
	,	region			: 'center'
	,	flex			: 0.5
	,	store			: 'Pemusnahan'
	,	plugins		: [
			Ext.create ('Earsip.plugin.RowEditor')
		]
	,	columns			: [{
			xtype		: 'rownumberer'
		},{
			text		: 'ID'
		,	dataIndex	: 'id'
		, 	hidden		: true
		, 	hideable	: false
		},{
			text		: 'Metode Pemusnahan'
		,	dataIndex	: 'metoda_id'
		,	flex		: 0.5
		,	editor		: {
				xtype			: 'combo'
			,	store			: Ext.create ('Earsip.store.MetodaPemusnahan', {
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
			text			: 'Nama Petugas'
		,	dataIndex		: 'nama_petugas'
		,	flex			: 0.5
		},{
			text			: 'Tanggal Pemusnahan'
		,	dataIndex		: 'tgl'
		,	flex			: 0.5
		,	renderer	: function(v)
			{return date_renderer (v);}
		},{
			text			: 'Penanggung Jawab Unit Kerja'
		,	dataIndex		: 'pj_unit_kerja'
		,	flex			: 0.5
		},{
			text			: 'Penanggung Jawab Pusat Berkas/Arsip'
		,	dataIndex		: 'pj_berkas_arsip'
		,	flex			: 0.5
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
				text		: 'Cari'
			,	itemId		: 'search'
			,	iconCls		: 'search'
			},'-',{
				text		: 'Print'
			,	itemId		: 'print'
			,	iconCls		: 'print'
			,	action		: 'print'
			},'-',{
				text		: 'Hapus'
			,	itemId		: 'del'
			,	iconCls		: 'del'
			,	action		: 'del'
			,	disabled	: true
			}]
		}]
	},{
		xtype	: 'tabpanel'
	,	region	: 'south'
	,	flex	: 0.5
	,	items	: [{
			xtype	: 'grid'
		,	itemId	: 'tim_pemusnah_grid'
		,	alias	: 'widget.tim_pemusnah_grid'
		,	title	: 'Tim Pemusnah'
		,	store	: 'TimPemusnahan'
		,	columns	: [{
				xtype	 : 'rownumberer'
			},{
				text	 : 'Nama Anggota Tim'
			,	dataIndex: 'nama'
			,	flex	 : 1
			},{	
				text	 	: 'Jabatan'
			,	dataIndex	: 'jabatan'
			,	flex	 	: 1
			}]
		},{
			xtype	: 'grid'
		,	itemId	: 'berkas_musnah_grid'
		,	alias	: 'widget.berkas_musnah_grid'
		,	title	: 'Daftar Berkas'
		,	store	: 'PemusnahanRinci'
		,	columns	: [{
				xtype	 : 'rownumberer'
			},{	
				text	 	: 'Berkas'
			,	dataIndex	: 'nama'
			,	flex	 	: 1
			},{
				text	 	: 'Keterangan'
			,	dataIndex	: 'keterangan'
			,	flex	 	: 2
			},{
				text	 	: 'Jumlah Lembar'
			,	dataIndex	: 'jml_lembar'
			,	width	 	: 110
			},{	
				text	 	: 'Jumlah Set'
			,	dataIndex	: 'jml_set'
			,	width	 	: 80
			},{	
				text	 	: 'Jumlah Berkas'
			,	dataIndex	: 'jml_berkas'
			,	width	 	: 100
			}]
		}]
	}]

,	listeners		: {
		afterrender : function (comp)
		{
			if (Ext.getCmp ('pemusnahan_win')!= undefined)
				this.win = Ext.getCmp ('pemusnahan_win');
			
			this.down ('#pemusnahan_grid').getStore ().load ();
			this.down ('#tim_pemusnah_grid').getStore ().load ();
			Ext.StoreManager.lookup ('BerkasMusnah').load ({
				scope	: this
			,	callback: function (r, op, success){
					if (success)
					{
						this.down ('#berkas_musnah_grid').getStore ().load ();
					}
				}
			});
		}
	}
});
