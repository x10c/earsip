Ext.require ('Earsip.view.DocViewer');

Ext.define ('Earsip.controller.DocViewer', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		: 'docviewer'
	,	selector: 'docviewer'
	}]
,	init	: function ()
	{
		this.control ({
			'docviewer button[itemId=download]': {
				click		: this.do_download
			}
		,	'docviewer button[itemId=zoomin]': {
				click		: this.do_zoomin
			}
		,	'docviewer button[itemId=zoomout]': {
				click		: this.do_zoomout
			}
		});
	}

,	do_download : function (b)
	{
		var dv = this.getDocviewer ();

		try {
			Ext.destroy(Ext.get('downloadIframe'));
		}
		catch(e) {}

		Ext.DomHelper.append (document.body, {
			tag			: 'iframe'
		,	id			: 'downloadIframe'
		,	frameBorder	: 0
		,	width		: 0
		,	height		: 0
		,	css			: 'display:none;visibility:hidden;height:0px;'
		,	src			: 'data/download.jsp?berkas='+ dv.berkas.get('sha')
						+'&nama='+ dv.berkas.get ('nama')
		});
	}

,	do_zoomin : function (b)
	{
		var dv	= this.getDocviewer ();
		var c	= dv.down ('#content-img');
		var sz	= c.getSize ();

		var w	= sz.width + 100;
		var h	= sz.height + 100;

		c.setSize (w, h);
	}

,	do_zoomout : function (b)
	{
		var dv	= this.getDocviewer ();
		var c	= dv.down ('#content-img');
		var sz	= c.getSize ();

		var w	= sz.width - 100;
		var h	= sz.height - 100;

		if (w > 0 && h > 0) {
			c.setSize (w, h);
		}
	}
});
