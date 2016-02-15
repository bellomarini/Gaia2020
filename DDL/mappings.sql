--------------------------------------------------------
--  File created - Monday-February-15-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table MAPPINGS
--------------------------------------------------------

  CREATE TABLE "GAIA"."MAPPINGS" 
   (	"ID" VARCHAR2(20 BYTE), 
	"DESCRIPTION" VARCHAR2(300 BYTE), 
	"SOURCE_SCHEMA" VARCHAR2(20 BYTE), 
	"TARGET_SCHEMA" VARCHAR2(20 BYTE), 
	"IS_TEMPLATE" VARCHAR2(1 BYTE) DEFAULT 'N'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
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
