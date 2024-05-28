

-- Test jp
set pages 0 linesize 32767 trimspool on trim on long 1000000 longchunksize 10000000
accept v_sqlid prompt 'Enter SQLID:'


column currdate new_value sysdt noprint
select 'sqlmon_sqlid_' || '&v_sqlid' || '.html' currdate from dual;

spool &sysdt

select dbms_sql_monitor.report_sql_monitor(
sql_id=>'&v_sqlid',
type=>'HTML',
report_level => 'ALL'
) as report 
from dual;

 
spool off





