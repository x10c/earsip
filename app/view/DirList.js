Ext.require ('Earsip.store.DirList');

Ext.define ('Earsip.view.DirList', {
	extend		: 'Ext.grid.Panel'
,	alias		: 'widget.dirlist'
,	itemId		: 'dirlist'
,	store		: 'DirList' 
,	title		: 'Berkas'
,	columns		: [{
		text		: 'Nama'
	,	flex		: 1
	,	sortable	: false
	,	hideable	: false
	,	dataIndex	: 'name'
	,	renderer	: function (v, md, r)
		{
			if (r.get ('node_type') == 0) {
				return "<span class='dir'>"+ v +"</span>";
			} else {
				return "<span class='doc'>"+ v +"</span>";
			}
		}
	},{
		text		: 'Tanggal Dibuat'
	,	width		: 150
	,	dataIndex	: 'date_created'
	},{
		text		: 'Status'
	,	dataIndex	: 'status'
	}]
,	dockedItems	: [{
		xtype		: 'toolbar'
	,	dock		: 'top'
	,	flex		: 1
	,	items		: [{
			text		: 'Direktori baru'
		,	itemId		: 'mkdir'
		,	action		: 'mkdir'
		,	iconCls		: 'add'
		},'-',{
			text		: 'Upload'
		,	itemId		: 'upload'
		,	action		: 'upload'
		,	iconCls		: 'upload'
		},'-',{
			text		: 'Refresh'
		,	itemId		: 'refresh'
		,	action		: 'refresh'
		,	iconCls		: 'refresh'
		}]
	}]
,	initComponent	: function ()
	{
		this.callParent (arguments);
	}

,	do_load_list : function (arsip_id)
	{
		this.getStore ().load ({
			params	: {
				arsip_id : arsip_id
			}
		});
	}
});
