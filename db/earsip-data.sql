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
