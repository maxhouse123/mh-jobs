begin;
-- 相关表是否存在
select table_name from information_schema.tables
 where table_schema='public'
   and table_name in ('documents','review_verdicts','school_documents','partner_documents','reviewer_assignments')
 order by table_name;
-- documents 列
select 'documents' t, column_name, data_type from information_schema.columns
 where table_schema='public' and table_name='documents' order by ordinal_position;
-- review_verdicts 列
select 'review_verdicts' t, column_name, data_type from information_schema.columns
 where table_schema='public' and table_name='review_verdicts' order by ordinal_position;
-- school_documents 列
select 'school_documents' t, column_name, data_type from information_schema.columns
 where table_schema='public' and table_name='school_documents' order by ordinal_position;
-- partner_documents 列
select 'partner_documents' t, column_name, data_type from information_schema.columns
 where table_schema='public' and table_name='partner_documents' order by ordinal_position;
commit;
