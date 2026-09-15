begin;
-- ① documents 里 .doc/.docx 总数(含/不含软删)
select
  count(*) filter (where deleted_at is null) as live_docdocx,
  count(*) filter (where deleted_at is not null) as deleted_docdocx,
  count(*) as total_docdocx,
  count(distinct student_id) as distinct_students,
  min(uploaded_at) as first_upload,
  max(uploaded_at) as last_upload
from documents
where lower(file_name) like '%.doc' or lower(file_name) like '%.docx';

-- ①b .doc vs .docx 各几个(仅未软删)
select
  case when lower(file_name) like '%.docx' then '.docx' else '.doc' end as ext,
  count(*) as n
from documents
where deleted_at is null and (lower(file_name) like '%.doc' or lower(file_name) like '%.docx')
group by 1 order by 1;

-- ① 按 doc_type 分(未软删)
select doc_type, count(*) as n
from documents
where deleted_at is null and (lower(file_name) like '%.doc' or lower(file_name) like '%.docx')
group by doc_type order by n desc;

-- ② review_verdicts status 值域(全表, 了解口径)
select status, count(*) from review_verdicts group by status order by 2 desc;

-- ② 这些 doc/docx 的裁决: 已批/已退/无裁决(未软删的活文件)
with dd as (
  select doc_id from documents
  where deleted_at is null and (lower(file_name) like '%.doc' or lower(file_name) like '%.docx')
)
select
  count(*) as live_docdocx,
  count(*) filter (where rv.status is null) as no_verdict,
  count(*) filter (where rv.status in ('approved','approve','ok')) as approved,
  count(*) filter (where rv.status in ('rejected','reject','returned')) as rejected,
  count(*) filter (where rv.status is not null
                    and rv.status not in ('approved','approve','ok','rejected','reject','returned')) as other_status
from dd
left join review_verdicts rv on rv.doc_id = dd.doc_id;

-- ③ school_documents / partner_documents 里 doc/docx
select 'school_documents' t, count(*) n from school_documents
 where lower(file_name) like '%.doc' or lower(file_name) like '%.docx'
union all
select 'partner_documents' t, count(*) n from partner_documents
 where lower(file_name) like '%.doc' or lower(file_name) like '%.docx';

-- 参照: documents 全表按扩展名 top(未软删), 看 doc/docx 占比
select
  lower(regexp_replace(file_name, '^.*\.', '')) as ext,
  count(*) as n
from documents
where deleted_at is null and file_name like '%.%'
group by 1 order by n desc limit 15;
commit;
