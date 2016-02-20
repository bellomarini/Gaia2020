--------------------------------------------------------
--  File created - Saturday-February-20-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HOMOMORPHISMS
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "GAIA"."HOMOMORPHISMS" 
   (	"ID" VARCHAR2(500 BYTE), 
	"VARIABLE" VARCHAR2(20 BYTE), 
	"VALUE" VARCHAR2(20 BYTE), 
	"LHS_RHS" VARCHAR2(20 BYTE)
   ) ON COMMIT PRESERVE ROWS ;
--------------------------------------------------------
--  DDL for Index HOMOMORPHISMS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."HOMOMORPHISMS_PK" ON "GAIA"."HOMOMORPHISMS" ("ID", "VARIABLE") ;
--------------------------------------------------------
--  DDL for Index HOMOMORPHISMS_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."HOMOMORPHISMS_UK1" ON "GAIA"."HOMOMORPHISMS" ("ID", "VARIABLE", "VALUE") ;
--------------------------------------------------------
--  Constraints for Table HOMOMORPHISMS
--------------------------------------------------------

  ALTER TABLE "GAIA"."HOMOMORPHISMS" ADD CONSTRAINT "HOMOMORPHISMS_UK1" UNIQUE ("ID", "VARIABLE", "VALUE") ENABLE;
  ALTER TABLE "GAIA"."HOMOMORPHISMS" ADD CONSTRAINT "HOMOMORPHISMS_PK" PRIMARY KEY ("ID", "VARIABLE") ENABLE;
  ALTER TABLE "GAIA"."HOMOMORPHISMS" MODIFY ("VARIABLE" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."HOMOMORPHISMS" MODIFY ("ID" NOT NULL ENABLE);
