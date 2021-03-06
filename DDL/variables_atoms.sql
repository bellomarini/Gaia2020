--------------------------------------------------------
--  File created - Tuesday-March-22-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table VARIABLES_ATOMS
--------------------------------------------------------

  CREATE TABLE "GAIA"."VARIABLES_ATOMS" 
   (	"VARIABLE" VARCHAR2(20 BYTE), 
	"ATOM" VARCHAR2(20 BYTE), 
	"POSITION" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index VARIABLES_ATOMS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "GAIA"."VARIABLES_ATOMS_PK" ON "GAIA"."VARIABLES_ATOMS" ("VARIABLE", "ATOM", "POSITION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index VARIABLES_ATOMS_INDEX1
--------------------------------------------------------

  CREATE INDEX "GAIA"."VARIABLES_ATOMS_INDEX1" ON "GAIA"."VARIABLES_ATOMS" ("VARIABLE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index VARIABLES_ATOMS_INDEX2
--------------------------------------------------------

  CREATE INDEX "GAIA"."VARIABLES_ATOMS_INDEX2" ON "GAIA"."VARIABLES_ATOMS" ("ATOM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table VARIABLES_ATOMS
--------------------------------------------------------

  ALTER TABLE "GAIA"."VARIABLES_ATOMS" ADD CONSTRAINT "VARIABLES_ATOMS_PK" PRIMARY KEY ("VARIABLE", "ATOM", "POSITION")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "GAIA"."VARIABLES_ATOMS" MODIFY ("POSITION" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."VARIABLES_ATOMS" MODIFY ("ATOM" NOT NULL ENABLE);
  ALTER TABLE "GAIA"."VARIABLES_ATOMS" MODIFY ("VARIABLE" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table VARIABLES_ATOMS
--------------------------------------------------------

  ALTER TABLE "GAIA"."VARIABLES_ATOMS" ADD CONSTRAINT "VARIABLES_ATOMS_ATOMS_FK1" FOREIGN KEY ("ATOM")
	  REFERENCES "GAIA"."ATOMS" ("ID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "GAIA"."VARIABLES_ATOMS" ADD CONSTRAINT "VARIABLES_ATOMS_VARIABLES_FK1" FOREIGN KEY ("VARIABLE")
	  REFERENCES "GAIA"."VARIABLES" ("ID") ON DELETE CASCADE ENABLE;
