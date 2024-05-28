--Jp2
set serveroutput on
declare
  tmp number;
begin
  tmp := dbms_spm.load_plans_from_awr(begin_snap=>&v_begin_snap,end_snap=>'&v_end_snap',
                                      basic_filter=q'# sql_id= '&v_sqlid' and plan_hash_value=&v_phv #' );
dbms_output.put_line('tmp= ' || tmp);
end;
/

