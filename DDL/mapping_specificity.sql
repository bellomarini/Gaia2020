--------------------------------------------------------
--  File created - Friday-June-10-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table MAPPING_SPECIFICITY
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "GAIA"."MAPPING_SPECIFICITY" 
   (	"MAPPING" VARCHAR2(20 BYTE), 
	"SPEC_LHS" NUMBER, 
	"SPEC_RHS" NUMBER
   ) ON COMMIT PRESERVE ROWS ;
--------------------------------------------------------
--  DDL for Index MAPPING_SPECIFICITY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."MAPPING_SPECIFICITY_PK" ON "GAIA"."MAPPING_SPECIFICITY" ("MAPPING") ;
--------------------------------------------------------
--  Constraints for Table MAPPING_SPECIFICITY
--------------------------------------------------------

  ALTER TABLE "GAIA"."MAPPING_SPECIFICITY" ADD CONSTRAINT "MAPPING_SPECIFICITY_PK" PRIMARY KEY ("MAPPING") ENABLE;
  ALTER TABLE "GAIA"."MAPPING_SPECIFICITY" MODIFY ("MAPPING" NOT NULL ENABLE);
