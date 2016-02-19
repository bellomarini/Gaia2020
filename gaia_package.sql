--------------------------------------------------------
--  File created - Friday-February-19-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package GAIA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."GAIA" AS 


-- It takes as input the id of a schema mapping,
-- the name of a source and target Oracle database schema to apply the mapping and generates
-- the corresponding e-schemas.
-- It returns the identifiers of the two created eschemas.
procedure GENERATE_ESCHEMAS(v_mapping_id in varchar2, v_database_source_schema varchar2, v_database_target_schema varchar2, v_eschema1 out integer, v_eschema2 out integer);

-- It returns the canonical template mapping for a given pair of e-schemas
procedure GET_CANONICAL_TEMPLATE_MAPPING (v_e_schema1 in varchar2, v_e_schema2 in varchar2);

-- It takes as input a canonical template mapping and returns a set of possible repairs for it
procedure GET_REPAIRED_TEMPLATE_MAPPINGS (v_mapping_id in varchar2, v_mapping_set_id out varchar2);





END GAIA;

/
