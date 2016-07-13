--------------------------------------------------------
--  File created - Tuesday-June-21-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table LACONIC_PROFILE
--------------------------------------------------------

  CREATE TABLE "GAIA"."LACONIC_PROFILE" 
   (	"ID" VARCHAR2(20 BYTE), 
	"MAPPING" VARCHAR2(20 BYTE), 
	"LHS_HOMO" NUMBER, 
	"RHS_HOMO" NUMBER, 
	"ESCHEMA_DESC" VARCHAR2(250 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index LACONIC_PROFILE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."LACONIC_PROFILE_PK" ON "GAIA"."LACONIC_PROFILE" ("ID", "MAPPING") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table LACONIC_PROFILE
--------------------------------------------------------

  ALTER TABLE "GAIA"."LACONIC_PROFILE" ADD CONSTRAINT "LACONIC_PROFILE_PK" PRIMARY KEY ("ID", "MAPPING")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."LACONIC_PROFILE" MODIFY ("MAPPING" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."LACONIC_PROFILE" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table LACONIC_PROFILE
--------------------------------------------------------

  ALTER TABLE "GAIA"."LACONIC_PROFILE" ADD CONSTRAINT "LACONIC_PROFILE_MAPPINGS_FK1" FOREIGN KEY ("MAPPING")
	  REFERENCES "GAIA"."MAPPINGS" ("ID") ENABLE;