Ext.Loader.setConfig ({ enabled: true });

Ext.define ('Earsip', {
	singleton		: true
,	username		: ''
,	repo_path		: ''
,	acl				: 0
,	berkas			: {
		id				: 0
	,	pid				: 0
	,	tree			: {
			id				: 0
		,	pid				: 0
		}
	}
,	share			: {
		id				: 0
	,	pid				: 0
	,	peg_id			: 0
	,	hak_akses_id	: 0
	}
,	arsip			: {
		id				: 0
	,	pid				: 0
	,	tree			: {
			id				: 0
		,	pid				: 0
		,	unit_kerja_id	: 0
		,	kode_rak		: ''
		,	kode_box		: ''
		,	kode_folder		: ''
		,	type			: ''
		}
	}
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
	,	'BerkasBerbagi'
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
	, 	'Peminjaman'
	,	'BerkasPinjam'
	,	'PeminjamanRinci'
	,	'Pemindahan'
	,	'PemindahanRinci'
	,	'BerkasPindah'
	,	'Pemusnahan'
	]
,	stores		: [
		'Berkas'
	,	'BerkasBerbagi'
	,	'BerkasBerbagiList'
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
	,	'Trash'
	,	'Peminjaman'
	,	'PeminjamanRinci'
	,	'BerkasPinjam'
	,	'Pemindahan'
	,	'PemindahanRinci'
	,	'BerkasPindah'
	,	'Arsip'
	,	'Pemusnahan'
	]
,	views		: [
		'Main'
	,	'MainToolbar'

	,	'Berkas'
	,	'BerkasTree'
	,	'BerkasList'
	,	'BerkasForm'
	,	'WinUpload'
	,	'BerkasBerbagiWin'

	,	'BerkasBerbagiTree'
	,	'BerkasBerbagiList'
	,	'BerkasBerbagi'

	,	'AdmSistem'
	,	'AdmHakAksesMenu'
	,	'Grup'
	,	'AdmHakAkses'
	,	'UnitKerja'
	,	'Pegawai'
	,	'PegawaiWin'

	,	'TrashList'
	,	'Trash'

	,	'KlasArsip'
	,	'KlasArsipWin'

	,	'TipeArsip'
	,	'TipeARsipWin'

	,	'RefIndeksRelatif'
	,	'RefIndeksRelatifWin'

	,	'MetodaPemusnahan'
	,	'Jabatan'
	
	,	'Peminjaman'
	,	'PeminjamanWin'
	,	'Pemindahan'
	,	'PemindahanWin'
	,	'PemindahanRinciWin'
	,	'Pemusnahan'
	]
,	controllers	: [
		'Login'
	,	'MainToolbar'
	,	'AdmHakAkses'
	,	'WinUpload'
	,	'Grup'
	,	'UnitKerja'
	,	'Pegawai'
	,	'KlasArsip'
	,	'TipeArsip'
	,	'IndeksRelatif'
	,	'MetodaPemusnahan'
	,	'Jabatan'
	,	'GantiPassword'
	,	'Berkas'
	,	'Trash'
	,	'BerkasBerbagi'
	,	'BerkasBerbagiWin'
	,	'Peminjaman'
	,	'Pemindahan'
	,	'Pemusnahan'
	,	'Arsip'
	]
	
,	launch		: function ()
	{
		var win			= Ext.create ('Earsip.view.LoginWindow', {});
		var mainview	= Ext.create ('Earsip.view.Main', {});
		var viewport	= Ext.create ('Ext.container.Viewport', {
			layout	: 'fit'
		,	items	: [ mainview ]
		});

		viewport.show ();

		Earsip.repo_path = _g_repo_path;
		
		if (is_login) {
			win.hide ();
			Earsip.username = _g_username;
			mainview.getLayout ().setActiveItem ('main');

			var main	= mainview.getLayout ().getActiveItem ();
			var tb		= main.getDockedComponent ('maintoolbar');
			var tree	= main.down ('#berkastree');

			tb.do_load_menu ();
			tree.do_load_tree ();
		} else {
			win.show ();
		}
	}
});
