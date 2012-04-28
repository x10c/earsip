--
-- m_sysconf
--
insert into m_sysconfig (repository_root) values ('/repository');

--
-- m_divisi
--
insert into m_divisi (div_kode, div_name, div_leader) values ('IT', 'Divisi IT', '');

--
-- m_subdiv
--
insert into m_subdiv (div_id, subdiv_code, subdiv_name, subdiv_leader)
values (1, 'IT', 'Subdivisi IT', '');

--
-- m_user
--
insert into m_user (subdiv_id, user_nip, user_name, user_psw)
values (1, '1', 'Administrator', 'earsip');

--
-- m_menu
--
insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (1, 0, 'Administrasi', 'adm');
insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (2, 1, 'Sistem'		, 'adm_sistem');
insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (3, 1, 'Hak Akses'	, 'adm_hak_akses');

insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (4, 0, 'Referensi'			, 'ref');
insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (5, 4, 'Divisi - Subdivisi'	, 'ref_divsub');
insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (6, 4, 'User'				, 'ref_user');
insert into m_menu (menu_id, menu_parent_id, menu_name, menu_index) values (7, 4, 'Tipe Arsip'			, 'ref_arsip_tipe');

--
-- menu_access
-- 0 : no view
-- 1 : view only
-- 2 : insert
-- 3 : update
-- 4 : delete
insert into menu_access (user_id, menu_id, access_level) values (1, 1, 4);
insert into menu_access (user_id, menu_id, access_level) values (1, 2, 4);
insert into menu_access (user_id, menu_id, access_level) values (1, 3, 4);
insert into menu_access (user_id, menu_id, access_level) values (1, 4, 4);
insert into menu_access (user_id, menu_id, access_level) values (1, 5, 4);
insert into menu_access (user_id, menu_id, access_level) values (1, 6, 4);
insert into menu_access (user_id, menu_id, access_level) values (1, 7, 4);
