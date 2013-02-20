Ext.define ('Earsip.controller.Arsip', {
	extend	: 'Ext.app.Controller'
,	refs	: [{
		ref		:'mas_arsip'
	,	selector:'mas_arsip'
	},{
		ref		:'arsiptree'
	,	selector:'arsiptree'
	},{
		ref		:'arsiplist'
	,	selector:'arsiplist'
	},{
		ref		:'arsipform'
	,	selector:'arsipform'
	},{
		ref		:'arsipcariwin'
	,	selector:'arsipcariwin'
	}]
,	init	: function ()
	{
		this.control ({
			'mas_arsip button[itemId=save]' : {
				click : this.do_save
			}
		,	'arsiptree': {
				selectionchange : this.tree_selectionchange
			}
		,	'arsiptree button[itemId=refresh]': {
				click : this.tree_do_refresh
			}
		,	'arsiptree button[itemId=label]': {
				click : this.do_print_label
			}
		,	'arsiplist': {
				itemdblclick : this.list_itemdblclick
			,	selectionchange : this.list_selectionchange
			}
		,	'arsiplist button[itemId=dirup]': {
				click : this.list_dirup
			}
		,	'arsiplist button[itemId=search]': {
				click : this.open_search_win
			}
		,	'arsipcariwin button[itemId=search]' : {
				click : this.do_search
			}
		});
	}

,	do_save : function (b)
	{
		var form = this.getArsipform ().getForm ();

		if (! form.isValid ()) {
			return;
		}

		form.submit ({
			scope	: this
		,	params	:{
				action	:'update'
			}
		,	success	: function (form, action)
			{
				if (action.result.success == true) {
					Ext.msg.info (action.result.info);
					this.getArsiptree ().do_load_tree ();
				} else {
					Ext.msg.error ('Gagal menyimpan data arsip!<br/><hr/>'+ action.result.info);
				}
			}
		,	failure	: function (form, action)
			{
				Ext.msg.error ('Gagal menyimpan data arsip!<br/><hr/>'+ action.result.info);
			}
		});
	}

,	tree_do_refresh : function (b)
	{
		this.getArsiptree ().do_load_tree ();
	}

,	do_print_label : function (button)
	{
		var url = 'data/lapcetaklabel_submit.jsp?' +
					'unit_kerja_id=' + Earsip.arsip.tree.unit_kerja_id + '&&' +
					'kode_rak=' + Earsip.arsip.tree.kode_rak + '&&' +
					'kode_box=' + Earsip.arsip.tree.kode_box
		window.open (url);
	}
	
,	tree_selectionchange : function (tree, records)
	{
		var tb = this.getArsiptree ().down ('toolbar');
		if (records.length <= 0) {
			return;
		}

		Earsip.arsip.id					= records[0].get ('id');
		Earsip.arsip.pid				= records[0].get ('parentId');
		Earsip.arsip.tree.id			= records[0].get ('id');
		Earsip.arsip.tree.pid			= records[0].get ('parentId');
		Earsip.arsip.tree.type			= records[0].raw.type;
		Earsip.arsip.tree.unit_kerja_id	= records[0].raw.unit_kerja_id;
		Earsip.arsip.tree.kode_rak		= records[0].raw.kode_rak;
		Earsip.arsip.tree.kode_box		= records[0].raw.kode_box;
		Earsip.arsip.tree.kode_folder	= records[0].raw.kode_folder;

		if (Earsip.arsip.pid == null) {
			Earsip.arsip.pid			= 0;
			Earsip.arsip.tree.pid		= 0;
		}
		
		tb.down ('#label').setDisabled(
			!(Earsip.is_p_arsip 
			&& 
			(Earsip.arsip.tree.type != 'root'
			&&
			Earsip.arsip.tree.type != 'folder'))
		)
		this.getArsiplist ().do_load_list ();
	}

,	list_itemdblclick : function (v, r)
	{
		var t = r.get ("tipe_file");
		if (t != 0) {
			return;
		}

		Earsip.arsip.id		= r.get ("id");
		Earsip.arsip.pid	= r.get ("pid");

		var tree	= this.getArsiptree ();
		var node	= tree.getRootNode ().findChild ('id', Earsip.arsip.id, true);

		tree.expandAll ();
		tree.getSelectionModel ().select (node);
	}

,	list_selectionchange : function (model, records)
	{
		var arsip	= this.getMas_arsip ();
		var klas_id	= false;
		var list = this.getArsiplist ();
		var form = this.getMas_arsip ().down ('#arsip_form');

		if (records.length > 0) {
			form.loadRecord (records[0]);
			list.record			= records[0];
			Earsip.arsip.id		= records[0].get ('id');
			Earsip.arsip.pid	= records[0].get ('pid');
			klas_id				= records[0].get ('berkas_klas_id') != '' ? true : false;
		}
	}

,	list_dirup : function (b)
	{
		var tree	= this.getArsiptree ();
		var root	= tree.getRootNode ();
		var node	= null;

		if (root.get ('id') == Earsip.arsip.tree.pid) {
			node = root;
		} else {
			node = root.findChild ('id', Earsip.arsip.tree.pid, true);
		}

		tree.expandAll ();
		tree.getSelectionModel ().select (node);
	}

,	open_search_win : function (b)
	{
		this.getArsiplist ().win_search.show ();
	}

,	do_search : function (b)
	{
		var cariform	= this.getArsipcariwin ().down ('form').getForm ();
		var list		= this.getArsiplist ();
		var list_store	= list.getStore ();
		var list_proxy	= list_store.getProxy ();
		var org_url		= list_proxy.url;

		list_proxy.url = 'data/arsip_cari.jsp'

		list_store.load ({
			params	: cariform.getValues ()
		});

		list_proxy.url = org_url;
	}
});
