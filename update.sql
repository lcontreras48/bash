update s_repository set name='Siebel Repository OLD' where name='Siebel Repository';
update s_repository set name='Siebel Repository' where name='Migrated Repository';
commit;
truncate table s_lov_rel;
