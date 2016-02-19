--------------------------------------------------------
--  File created - Friday-February-19-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package MAPPINGS_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."MAPPINGS_UTILS" AS 

-- It parses a string representing a schema mapping (or a template mapping) of the form
-- "R1(x,y,z),R2(z,k,w),w="23"...->R3(k,q,s)"
-- and stores it into our metamodel MAPPINGS, VARIABLES, ATOMS, VARIABLES_ATOMS.
-- This procedure stores the mapping independently of the relation it refers to.
-- It returns the id of the created mapping
procedure PARSE_MAPPING(v_mapping_string in varchar2, v_mapping_id out varchar2);

-- It takes as input the identifier of a mapping and returns a string
-- representation of it.
procedure MAPPING_TO_STRING_BY_ID(v_mapping_id in varchar2, v_mapping_string out varchar2);

-- It clones a mapping and returns the id of the new one.
procedure CLONE_MAPPING(v_mapping_id in varchar2, v_new_mapping_id out varchar2);

END MAPPINGS_UTILS;

/
