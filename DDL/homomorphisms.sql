--------------------------------------------------------
--  File created - Friday-February-19-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table HOMOMORPHISMS
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "GAIA"."HOMOMORPHISMS" 
   (	"ID" VARCHAR2(500 BYTE), 
	"VARIABLE" VARCHAR2(20 BYTE), 
	"VALUE" VARCHAR2(20 BYTE)
   ) ON COMMIT PRESERVE ROWS ;
--------------------------------------------------------
--  DDL for Index HOMOMORPHISMS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."HOMOMORPHISMS_PK" ON "GAIA"."HOMOMORPHISMS" ("ID", "VARIABLE") ;
--------------------------------------------------------
--  Constraints for Table HOMOMORPHISMS
--------------------------------------------------------

  ALTER TABLE "GAIA"."HOMOMORPHISMS" ADD CONSTRAINT "HOMOMORPHISMS_PK" PRIMARY KEY ("ID", "VARIABLE") ENABLE;
  ALTER TABLE "GAIA"."HOMOMORPHISMS" MODIFY ("VARIABLE" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."HOMOMORPHISMS" MODIFY ("ID" NOT NULL ENABLE);
