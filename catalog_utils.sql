--------------------------------------------------------
--  File created - Wednesday-February-10-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body CATALOG_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."CATALOG_UTILS" AS

function GET_COLUMN_ID_IN_POSITION(v_database_schema varchar2, v_table_name varchar2, v_position integer) return varchar2 as
v_column_id varchar2(20);
begin
    select column_id into v_column_id from (
        select column_id, ROWNUM as NO
        from all_tab_columns cols
        where cols.owner = v_database_schema
        and cols.table_name = v_table_name
        order by column_id 
    ) WHERE NO = v_position;
    return v_column_id;
end GET_COLUMN_ID_IN_POSITION;

function GET_COLUMN_NAME_IN_POSITION(v_database_schema varchar2, v_table_name varchar2, v_position integer) return varchar2 as
v_column_name varchar2(20);
begin
    select column_name into v_column_name from (
        select column_name, ROWNUM as NO
        from all_tab_columns cols
        where cols.owner = v_database_schema
        and cols.table_name = v_table_name
        order by column_id 
    ) WHERE NO = v_position;
    return v_column_name;
    
end GET_COLUMN_NAME_IN_POSITION;

function GET_COLUMN_POSITION_BY_NAME(v_database_schema varchar2, v_table_name varchar2, v_column_name varchar2) return integer as
v_pos integer;

begin
select T.POS into v_pos from (
    select COLUMN_NAME, rank() over (order by column_id) as POS
    from all_tab_columns
    where table_name = v_table_name
    and owner = v_database_schema) T
    where T.COLUMN_NAME = v_column_name;
return v_pos; 
end GET_COLUMN_POSITION_BY_NAME;


END CATALOG_UTILS;

/
