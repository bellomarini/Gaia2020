--------------------------------------------------------
--  File created - Wednesday-February-17-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table AMBIGUOUS_VARIABLES
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "GAIA"."AMBIGUOUS_VARIABLES" 
   (	"VARIABLE" VARCHAR2(20 BYTE), 
	"ATOM" VARCHAR2(20 BYTE), 
	"ATOM_NAME" VARCHAR2(20 BYTE)
   ) ON COMMIT PRESERVE ROWS ;
--------------------------------------------------------
--  DDL for Index AMBIGUOUS_VARIABLES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."AMBIGUOUS_VARIABLES_PK" ON "GAIA"."AMBIGUOUS_VARIABLES" ("VARIABLE", "ATOM") ;
--------------------------------------------------------
--  Constraints for Table AMBIGUOUS_VARIABLES
--------------------------------------------------------

  ALTER TABLE "GAIA"."AMBIGUOUS_VARIABLES" MODIFY ("VARIABLE" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."AMBIGUOUS_VARIABLES" MODIFY ("ATOM" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."AMBIGUOUS_VARIABLES" ADD CONSTRAINT "AMBIGUOUS_VARIABLES_PK" PRIMARY KEY ("VARIABLE", "ATOM") ENABLE;
