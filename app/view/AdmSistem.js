Ext.define ('Earsip.view.AdmSistem', {
	extend			: 'Ext.form.Panel'
,	alias			: 'widget.adm_sistem'
,	itemId			: 'adm_sistem'
,	title			: 'Administrasi Sistem'
,	closable		: true
,	plain			: true
,	bodyPadding		: 10
,	layout			: 'anchor'
,	defaultType		: 'textfield'
,	reader			: {
		type		: 'json'
	,	root		: 'data'
	}
,	defaults		: {
		anchor			: '100%'
	,	allowBlank		: false
	,	labelAlign		: 'right'
	,	labelWidth		: 120
	}
,	items			: [{
		fieldLabel		: 'Root Repository'
	,	name			: 'repository_root'
	}]
,	dockedItems		: [{
		xtype			: 'toolbar'
	,	dock			: 'top'
	,	flex			: 1
	,	items			: [{
			text			: 'Simpan'
		,	itemId			: 'save'
		,	scope			: this
		,	handler			: function (button, event)
			{
				var panel = button.up ('#adm_sistem');
				panel.getForm ().submit ({
					url		: 'data/sistem_submit.jsp'
				,	waitMsg	: 'Menyimpan ...'
				});
			}
		}]
	}]

,	listeners		: {
		activate		: function (comp)
		{
			this.do_load ();

			var b_save = this.down ('#save');

			if (Earsip.acl < 3) {
				b_save.setDisabled (true);
			} else {
				b_save.setDisabled (false);
			}
		}
	,	removed			: function (comp)
		{
			this.destroy ();
		}
	}

,	do_load : function ()
	{
		this.getForm ().load ({
			url		: 'data/sistem.jsp'
		,	waitMsg	: 'Memuat ...'
		});
	}
});
