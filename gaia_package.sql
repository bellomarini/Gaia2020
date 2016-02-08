--------------------------------------------------------
--  File created - Monday-February-08-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package GAIA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."GAIA" AS 

-- It parses a string representing a schema mapping (or a template mapping) of the form
-- "R1(x,y,z),R2(z,k,w)->R3(k,q,s)"
-- and stores it into our metamodel MAPPINGS, VARIABLES, ATOMS, VARIABLES_ATOMS.
-- This procedure stores the mapping independently of the relation it refers to.
-- It returns the id of the created mapping
procedure PARSE_MAPPING(v_mapping_string in varchar2, v_mapping_id out varchar2);

-- Takes as input the identifier of a mapping and returns a string
-- representation of it.
function MAPPING_TO_STRING_BY_ID(v_mapping_id in varchar2) return varchar2;

-- It encodes a relation in GAIA_INPUT given its name and the target e-scema
procedure ENCODE_RELATION (v_relationName in varchar2, v_target_e_schema in varchar2);

-- It returns the canonical template mapping for a given pair of e-schemas
procedure GET_CANONICAL_TEMPLATE_MAPPING (v_e_schema1 in varchar2, v_e_schema2 in varchar2);



END GAIA;

/
