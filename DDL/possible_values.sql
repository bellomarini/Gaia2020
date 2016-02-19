--------------------------------------------------------
--  File created - Wednesday-February-17-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table POSSIBLE_VALUES
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "GAIA"."POSSIBLE_VALUES" 
   (	"ATOM_NAME" VARCHAR2(20 BYTE), 
	"POSITION" VARCHAR2(20 BYTE), 
	"VALUE" VARCHAR2(20 BYTE), 
	"GIVEN_POS" VARCHAR2(20 BYTE), 
	"GIVEN_VALUE" VARCHAR2(20 BYTE)
   ) ON COMMIT PRESERVE ROWS ;
