Ext.define ('Earsip.view.DocViewer', {
	extend		: 'Ext.window.Window'
,	alias		: 'widget.docviewer'
,	itemId		: 'docviewer'
,	title		: 'Berkas'
,	maximized	: true
,	resizable	: true
,	closeable	: true
,	maximizable	: true
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
	,	text		: ''
	,	itemId		: 'prev'
	,	iconCls		: 'prev'
	},'-',{
		xtype		: 'text'
	,	text		: 'Hal. 0 dari 0'
	,	itemId		: 'pages'
	},'-',{
		xtype		: 'button'
	,	text		: ''
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
		this.n_image	= berkas.get ('n_output_images');

		if (this.mime == 'application/pdf') {
			this.target += '_'+ this.seq +'.png';
			this.set_page_number (this.seq + 1);
		} else {
			this.n_image = 1;
			this.set_page_number (1);
		}

		c.removeAll ();

		c.add ({
			xtype	: 'image'
		,	mode	: 'image'
		,	itemId	: 'content-img'
		,	src		: this.target
		,	width	: 800
		});

		this.setTitle ('Berkas :: '+ berkas.get ('nama'));
		this.show ();
	}

,	set_page_number : function (n)
	{
		var p = this.down ('#pages');

		p.setText ('Hal. '+ n +' dari '+ this.n_image);
	}
});
