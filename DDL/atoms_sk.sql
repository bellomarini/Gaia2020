--------------------------------------------------------
--  File created - Saturday-February-13-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ATOMS_SK
--------------------------------------------------------

  CREATE TABLE "GAIA"."ATOMS_SK" 
   (	"OUT" VARCHAR2(20 BYTE), 
	"FUNCTION" VARCHAR2(100 BYTE), 
	"RELATION_ID" VARCHAR2(20 BYTE), 
	"MAPPING" VARCHAR2(20 BYTE), 
	"ATTRIBUTE_ID" VARCHAR2(20 BYTE), 
	"KEY_ID" VARCHAR2(20 BYTE), 
	"FKEY_ID" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index ATOMS_SK_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."ATOMS_SK_PK" ON "GAIA"."ATOMS_SK" ("OUT") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table ATOMS_SK
--------------------------------------------------------

  ALTER TABLE "GAIA"."ATOMS_SK" ADD CONSTRAINT "ATOMS_SK_PK" PRIMARY KEY ("OUT")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."ATOMS_SK" MODIFY ("MAPPING" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."ATOMS_SK" MODIFY ("OUT" NOT NULL ENABLE);