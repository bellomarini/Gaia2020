--------------------------------------------------------
--  File created - Tuesday-February-09-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FKEYS
--------------------------------------------------------

  CREATE TABLE "GAIA"."FKEYS" 
   (	"ID" VARCHAR2(20 BYTE), 
	"FROM_COLUMN" VARCHAR2(20 BYTE), 
	"TO_RELATION" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index FKEYS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."FKEYS_PK" ON "GAIA"."FKEYS" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index FKEYS_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."FKEYS_UK1" ON "GAIA"."FKEYS" ("FROM_COLUMN", "TO_RELATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table FKEYS
--------------------------------------------------------

  ALTER TABLE "GAIA"."FKEYS" ADD CONSTRAINT "FKEYS_UK1" UNIQUE ("FROM_COLUMN", "TO_RELATION")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."FKEYS" ADD CONSTRAINT "FKEYS_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."FKEYS" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table FKEYS
--------------------------------------------------------

  ALTER TABLE "GAIA"."FKEYS" ADD CONSTRAINT "FKEYS_ATTRIBUTES_FK1" FOREIGN KEY ("FROM_COLUMN")
	  REFERENCES "GAIA"."ATTRIBUTES" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "GAIA"."FKEYS" ADD CONSTRAINT "FKEYS_RELATIONS_FK1" FOREIGN KEY ("TO_RELATION")
	  REFERENCES "GAIA"."RELATIONS" ("ID") ON DELETE CASCADE ENABLE;
