--------------------------------------------------------
--  File created - Tuesday-February-09-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package CATALOG_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."CATALOG_UTILS" AS 

-- It returns the id of a column of a relation
-- given its position in Oracle catalog
function GET_COLUMN_ID_IN_POSITION(v_database_schema varchar2, v_table_name varchar2, v_position integer) return varchar2;

-- It returns the name of a column of a relation
-- given its position in Oracle catalog
function GET_COLUMN_NAME_IN_POSITION(v_database_schema varchar2, v_table_name varchar2, v_position integer) return varchar2;


END CATALOG_UTILS;

/
