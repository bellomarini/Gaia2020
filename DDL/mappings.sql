--------------------------------------------------------
--  File created - Wednesday-March-23-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table MAPPINGS
--------------------------------------------------------

  CREATE TABLE "GAIA"."MAPPINGS" 
   (	"ID" VARCHAR2(20 BYTE), 
	"DESCRIPTION" VARCHAR2(1000 BYTE), 
	"SOURCE_SCHEMA" VARCHAR2(20 BYTE), 
	"TARGET_SCHEMA" VARCHAR2(20 BYTE), 
	"TYPE" VARCHAR2(2 BYTE) DEFAULT 'S', 
	"REPAIR_REF" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;

   COMMENT ON COLUMN "GAIA"."MAPPINGS"."SOURCE_SCHEMA" IS 'Populated only in case of canonical template mapping (C).';
   COMMENT ON COLUMN "GAIA"."MAPPINGS"."TARGET_SCHEMA" IS 'Populated only in case of canonical template mapping (C).';
   COMMENT ON COLUMN "GAIA"."MAPPINGS"."TYPE" IS 'S: schema mapping, C: canonical template mapping, R: repaired canonical template mapping';
   COMMENT ON COLUMN "GAIA"."MAPPINGS"."REPAIR_REF" IS 'if it is a repaired template mapping, it refers to the respective template mapping';
--------------------------------------------------------
--  DDL for Index MAPPING_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."MAPPING_PK" ON "GAIA"."MAPPINGS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table MAPPINGS
--------------------------------------------------------

  ALTER TABLE "GAIA"."MAPPINGS" ADD CONSTRAINT "MAPPING_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."MAPPINGS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table MAPPINGS
--------------------------------------------------------

  ALTER TABLE "GAIA"."MAPPINGS" ADD CONSTRAINT "MAPPINGS_MAPPINGS_FK1" FOREIGN KEY ("REPAIR_REF")
	  REFERENCES "GAIA"."MAPPINGS" ("ID") ENABLE;
