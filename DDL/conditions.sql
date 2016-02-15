--------------------------------------------------------
--  File created - Monday-February-15-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CONDITIONS
--------------------------------------------------------

  CREATE TABLE "GAIA"."CONDITIONS" 
   (	"ID" VARCHAR2(20 BYTE), 
	"VARIABLE" VARCHAR2(20 BYTE), 
	"VALUE" VARCHAR2(20 BYTE), 
	"COND_TYPE" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index CONDITION_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."CONDITION_PK" ON "GAIA"."CONDITIONS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table CONDITIONS
--------------------------------------------------------

  ALTER TABLE "GAIA"."CONDITIONS" ADD CONSTRAINT "CONDITION_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."CONDITIONS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table CONDITIONS
--------------------------------------------------------

  ALTER TABLE "GAIA"."CONDITIONS" ADD CONSTRAINT "CONDITION_VARIABLES_FK1" FOREIGN KEY ("VARIABLE")
	  REFERENCES "GAIA"."VARIABLES" ("ID") ENABLE;
