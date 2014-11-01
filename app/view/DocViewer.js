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

,	do_download : function (b)
	{
		var dv = this;

		try {
			Ext.destroy (Ext.get('downloadIframe'));
		}
		catch(e) {}

		Ext.DomHelper.append (document.body, {
			tag			: 'iframe'
		,	id			: 'downloadIframe'
		,	frameBorder	: 0
		,	width		: 0
		,	height		: 0
		,	css			: 'display:none;visibility:hidden;height:0px;'
		,	src			: 'Download?berkas='+ dv.berkas.get('sha')
						+'&nama='+ dv.berkas.get ('nama')
		});
	}

,	do_zoomin : function (b)
	{
		var dv	= this;
		var c	= dv.down ('#content-img');
		var sz	= c.getSize ();

		var w	= sz.width + 100;
		var h	= sz.height + 100;

		c.setSize (w, h);
	}

,	do_zoomout : function (b)
	{
		var dv	= this;
		var c	= dv.down ('#content-img');
		var sz	= c.getSize ();

		var w	= sz.width - 100;
		var h	= sz.height - 100;

		if (w > 0 && h > 0) {
			c.setSize (w, h);
		}
	}

,	do_view_prev : function (b)
	{
		var dv	= this;
		var c	= dv.down ('#content');
		var	p	= dv.down ('#pages');
		var ci	= dv.down ('#content-img');
		var sz	= ci.getSize ();

		if (dv.mime == 'application/pdf') {
			if (dv.seq > 0) {
				dv.seq		= dv.seq - 1;
				dv.target	= dv.src +'_'+ dv.seq +'.png'

				c.removeAll ();
				c.add ({
					xtype	: 'image'
				,	mode	: 'image'
				,	itemId	: 'content-img'
				,	src		: dv.target
				,	width	: sz.width
				});

				dv.set_page_number (dv.seq + 1);
			}
		}
	}

,	do_view_next : function (b)
	{
		var dv	= this;
		var c	= dv.down ('#content');
		var	p	= dv.down ('#pages');
		var ci	= dv.down ('#content-img');
		var sz	= ci.getSize ();

		if (dv.mime == 'application/pdf') {
			if (dv.seq >= (dv.n_image - 1)) {
				return;
			}
			dv.seq		= dv.seq + 1;
			dv.target	= dv.src +'_'+ dv.seq +'.png'
		}

		c.removeAll ();
		c.add ({
			xtype	: 'image'
		,	mode	: 'image'
		,	itemId	: 'content-img'
		,	src		: dv.target
		,	width	: sz.width
		});

		dv.set_page_number (dv.seq + 1);
	}

,	initComponent : function (opt)
	{
		this.callParent (opt);

		this.down ("#download").on ("click", this.do_download, this);
		this.down ("#zoomin").on ("click", this.do_zoomin, this);
		this.down ("#zoomout").on ("click", this.do_zoomout, this);
		this.down ("#next").on ("click", this.do_view_next, this);
		this.down ("#prev").on ("click", this.do_view_prev, this);
	}
});
