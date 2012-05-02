Ext.Loader.setConfig ({ enabled: true });

Ext.define ('Earsip', {
	singleton		: true
,	acl				: 0
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
			editor.grid.store.sync ();
			editor.grid.store.load ({
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
		'DirList'
	,	'SharedList'
	,	'User'
	,	'Grup'
	,	'MenuAccess'
	]
,	stores		: [
		'DirList'
	,	'SharedList'
	,	'User'
	,	'Grup'
	,	'MenuAccess'
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
	]
,	controllers	: [
		'Login'
	,	'MainToolbar'
	,	'AdmHakAkses'
	,	'DirTree'
	,	'DirList'
	,	'WinUpload'
	,	'Grup'
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
