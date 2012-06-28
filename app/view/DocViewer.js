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

,	do_open : function (berkas)
	{
		var	b = this.down ('#download');
		var c = this.down ('#content');

		this.berkas		= berkas;
		this.target		= 'repository/'+ berkas.get ('sha');

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
