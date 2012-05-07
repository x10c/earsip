Ext.Loader.setConfig ({ enabled: true });

Ext.define ('Earsip', {
	singleton		: true
,	acl				: 0
,	berkas_id		: 0
,	dir_id			: 0
,	tree_path		: ''
});

Ext.define ('Earsip.plugin.RowEditor', {
	extend				: 'Ext.grid.plugin.RowEditing'
,	action				: 'none'	/* none, add, edit */
,	alias				: 'widget.roweditor'
,	pluginId			: 'roweditor'
,	saveText			: 'Simpan'
,	cancelText			: 'Batal'
,	clicksToEdit		: 2
,	clicksToMoveEditor	: 1
,	listeners			: {
		beforeedit			: function (ed, e)
		{
			if (Earsip.acl < 3) {
				return false;
			}
			return true;
		}
	,	edit				: function (editor, e)
		{
			editor.action = 'none';
			editor.grid.store.sync ({
				params	: editor.grid.params
			});
		}
	,	canceledit			: function (editor)
		{
			if (editor.action == 'add') {
				editor.grid.store.removeAt (0);
				editor.grid.getSelectionModel ().select (0);
			}
		}
	}
});

function combo_renderer (v, col)
{
	var combo = col.getEditor ();
	var i = combo.store.find (combo.valueField, v);
	if (i < 0) {
		return v;
	}
	var rec = combo.store.getAt (i);
	return rec ? rec.get(combo.displayField) : "";
}

function store_renderer (valueField, displayField, store)
{
	return function (v) {
		var i = store.find (valueField, v);
		if (i < 0) {
			return v;
		}
		var rec = store.getAt (i);
		return rec ? rec.get (displayField) : "";
	}
}

Ext.application ({
	name		: 'Earsip'
,	appFolder	: 'app'
,	models		: [
		'Berkas'
	,	'SharedList'
	,	'User'
	,	'Grup'
	,	'MenuAccess'
	,	'UnitKerja'
	,	'Pegawai'
	,	'Jabatan'
	,	'MetodaPemusnahan'
	,	'KlasArsip'
	,	'TipeArsip'
	,	'IndeksRelatif'
	]
,	stores		: [
		'Berkas'
	,	'SharedList'
	,	'User'
	,	'Grup'
	,	'MenuAccess'
	,	'UnitKerja'
	,	'Pegawai'
	,	'Jabatan'
	,	'MetodaPemusnahan'
	,	'KlasArsip'
	,	'TipeArsip'
	,	'IndeksRelatif'
	]
,	views		: [
		'Main'
	,	'MainToolbar'
	,	'DirTree'
	,	'DirList'
	,	'WinUpload'
	,	'SharedList'
	,	'AdmSistem'

	,	'AdmHakAksesMenu'
	,	'Grup'
	,	'AdmHakAkses'
	,	'Pegawai'
	,	'PegawaiWin'

	,	'KlasArsip'
	,	'TipeArsip'
	,	'RefIndeksRelatif'
	,	'MetodaPemusnahan'
	]
,	controllers	: [
		'Login'
	,	'MainToolbar'
	,	'AdmHakAkses'
	,	'DirTree'
	,	'DirList'
	,	'WinUpload'
	,	'Grup'
	,	'Pegawai'
	,	'KlasArsip'
	,	'TipeArsip'
	,	'MetodaPemusnahan'
	]
,	launch		: function () {
		var win			= Ext.create ('Earsip.view.LoginWindow', {});
		var mainview	= Ext.create ('Earsip.view.Main', {});
		var viewport	= Ext.create ('Ext.container.Viewport', {
			layout	: 'fit'
		,	items	: [ mainview ]
		});

		viewport.show ();

		if (is_login) {
			win.hide ();
			mainview.getLayout ().setActiveItem ('main');

			var comp	= mainview.getLayout ().getActiveItem ();
			var tb		= comp.down ('#maintoolbar');
			var tree	= comp.down ('#dirtree');

			tb.do_load_menu ();
			tree.do_load_tree ();
		} else {
			win.show ();
		}
	}
});
