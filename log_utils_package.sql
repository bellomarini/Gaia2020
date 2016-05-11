--------------------------------------------------------
--  File created - Wednesday-May-11-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package LOG_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."LOG_UTILS" AS 

  -- It logs in a log table
  procedure log_me(message clob); 

END LOG_UTILS;

/
