--------------------------------------------------------
--  File created - Wednesday-May-11-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body LOG_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."LOG_UTILS" AS

    
  procedure log_me(message clob) AS
  PRAGMA AUTONOMOUS_TRANSACTION;

  BEGIN
    insert into gaia_log(id, timestamp, text) values (seq_gaia_log.nextval, systimestamp, message);
  END log_me;

END LOG_UTILS;

/
