/********************************************
     Author: Paresh Mehta             
     Script Name : newobj_by_time.sql
     Description:  Developed for CAMP
********************************************/

set echo off
set numwidth 9
set linesize 132
set pagesize 300
Set head off
set feedback off
set verify off
set time off
set timing off

accept start_time_frame prompt 'Enter Time Frame (DD-MON-RRRR:HH24:MI) : '
accept stop_time_frame prompt 'Enter Time Frame (DD-MON-RRRR:HH24:MI) : '

spool grant_to_roles.sql

select 'grant select, insert, update, delete on ' || owner || '.' || table_nm || ' to CSI_OBJECTS_ROLE, ALL_USERS_ROLE, DEV, DEVUSER, CSI;' 
 from ( select a.owner, a.table_name as table_nm 
          from dba_tables a, dba_objects b  
         where a.table_name = b.object_name
           and b.object_type in ('TABLE')
           and a.owner = b.owner
           and a.owner in ('CSI', 'ALLOEM', 'CESCOM', 'TREND', 'CAMP', 'INV', 'CAMP360', 'MTX', 'ADSI') 
           and b.created >= to_date('&start_time_frame', 'DD-MON-RRRR:HH24:MI') 
           and b.created <= to_date('&stop_time_frame', 'DD-MON-RRRR:HH24:MI') ) ;


select 'grant select on ' || owner || '.' || table_nm || ' to 
       CSI_OBJECTS_ROLE,  RONLY_ROLE, STRICTLY_READ_ONLY_ROLE, READ_ONLY_ROLE;'
 from ( select a.owner, a.view_name as table_nm
          from dba_views a, dba_objects b
         where a.view_name = b.object_name
           and b.object_type in ('VIEW')
           and a.owner = b.owner
           and a.owner in ('CSI', 'ALLOEM', 'CESCOM', 'TREND', 'CAMP', 'INV', 'CAMP360', 'MTX', 'ADSI') 
           and b.created >= to_date('&start_time_frame', 'DD-MON-RRRR:HH24:MI') 
           and b.created <= to_date('&stop_time_frame', 'DD-MON-RRRR:HH24:MI') ) ;



select 'grant select on ' || owner || '.' || table_nm || ' to RONLY_ROLE, STRICTLY_READ_ONLY_ROLE, READ_ONLY_ROLE;'
 from ( select a.owner, a.table_name as table_nm
          from dba_tables a, dba_objects b
         where a.table_name = b.object_name
           and b.object_type in ('TABLE')
           and a.owner = b.owner
           and a.owner in ('CSI', 'ALLOEM', 'CESCOM', 'TREND', 'CAMP', 'INV', 'CAMP360', 'MTX', 'ADSI') 
           and b.created >= to_date('&start_time_frame', 'DD-MON-RRRR:HH24:MI') 
           and b.created <= to_date('&stop_time_frame', 'DD-MON-RRRR:HH24:MI') ) ;



select 'grant select on ' || owner || '.' || seq_nm || ' to CSI_OBJECTS_ROLE, ALL_USERS_ROLE, DEV, DEVUSER, CSI;' 
 from ( select owner, a.sequence_name as seq_nm 
          from dba_sequences a, dba_objects b  
         where a.sequence_name = b.object_name
           and a.sequence_owner = b.owner
           and a.sequence_owner in ('CSI', 'ALLOEM', 'CESCOM', 'TREND', 'CAMP', 'INV', 'CAMP360', 'MTX', 'ADSI') 
           and b.object_type = 'SEQUENCE'
           and b.created >= to_date('&start_time_frame', 'DD-MON-RRRR:HH24:MI') 
           and b.created <= to_date('&stop_time_frame', 'DD-MON-RRRR:HH24:MI') ) ;



select 'grant execute on ' || owner || '.' || object_name || ' to CSI_OBJECTS_ROLE, ALL_USERS_ROLE, DEV, DEVUSER, CSI; ' 
 from dba_objects
where object_type in ('FUNCTION', 'PROCEDURE', 'PACKAGE', 'TYPE')
  and owner in ('CSI', 'ALLOEM', 'CESCOM', 'TREND', 'CAMP', 'INV', 'CAMP360', 'MTX') 
  and created >= to_date('&start_time_frame', 'DD-MON-RRRR:HH24:MI') 
  and created <= to_date('&stop_time_frame', 'DD-MON-RRRR:HH24:MI')  ;

spool off

spool cre_syn_script.sql

select 'create public synonym ' || object_name || ' for ' || owner || '.' || object_name || ';'
 from dba_objects
where object_type in ('TABLE', 'SEQUENCE', 'FUNCTION', 'PACKAGE', 'PROCEDURE', 'VIEW', 'TYPE')
  and owner in ('CSI', 'ALLOEM', 'CESCOM', 'TREND', 'CAMP', 'INV', 'CAMP360', 'MTX', 'ADSI') 
  and created >= to_date('&start_time_frame', 'DD-MON-RRRR:HH24:MI') 
  and created <= to_date('&stop_time_frame', 'DD-MON-RRRR:HH24:MI')  ;

spool off


set echo on
set numwidth 9
Set head on
set feedback 1
set verify on
set time on
set timing on


