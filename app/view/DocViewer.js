Ext.define ('Earsip.view.DocViewer', {
	extend		: 'Ext.window.Window'
,	alias		: 'widget.docviewer'
,	itemId		: 'docviewer'
,	title		: 'Berkas'
,	width		: 700
,	height		: 500
,	resizable	: true
,	closeable	: true
,	closeAction	: 'hide'
,	layout		: 'fit'
,	tbar		: [{
		xtype		: 'button'
	,	text		: 'Unduh'
	,	itemId		: 'download'
	,	iconCls		: 'save'
	},'-','->','-',
	{
		xtype		: 'button'
	,	text		: '<'
	,	itemId		: 'prev'
	,	iconCls		: 'prev'
	},'-',{
		xtype		: 'button'
	,	text		: '>'
	,	itemId		: 'next'
	,	iconCls		: 'next'
	},'-',{
		xtype		: 'button'
	,	text		: 'Perkecil'
	,	itemId		: 'zoomout'
	,	iconCls		: 'zoomout'
	},'-',{
		xtype		: 'button'
	,	text		: 'Perbesar'
	,	itemId		: 'zoomin'
	,	iconCls		: 'zoomin'
	}]
,	items		: [{
		xtype		: 'container'
	,	autoScroll	: true
	,	itemId		: 'content'
	}]

,	target	: ''
,	berkas	: {}
,	src		: ''
,	mime	: ''
,	seq		: 0

,	do_open : function (berkas)
	{
		var	b = this.down ('#download');
		var c = this.down ('#content');

		this.berkas		= berkas;
		this.src		= 'repository/'+ berkas.get ('pegawai_id') +'/'+ berkas.get ('sha');
		this.target		= 'repository/'+ berkas.get ('pegawai_id') +'/'+ berkas.get ('sha');
		this.mime		= berkas.get ('mime');
		this.seq		= 0;

		if (this.mime == 'application/pdf') {
			this.target += '_'+ this.seq +'.png';
		}

		c.removeAll ();

		c.add ({
			xtype	: 'image'
		,	mode	: 'image'
		,	itemId	: 'content-img'
		,	src		: this.target
		});

		this.setTitle ('Berkas :: '+ berkas.get ('nama'));
		this.show ();
	}
});
