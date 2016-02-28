--------------------------------------------------------
--  File created - Sunday-February-28-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package TEMPLATE_MAPPINGS_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."TEMPLATE_MAPPINGS_UTILS" AS 

-- It takes as input the id of a template mapping, 'LHS' or 'RHS'
-- and populates relation HOMOMORPHISMS with all the possible homomorphism from the XHS to the values
-- v_chosen_eschema is the target of the homomorphism, which is the target eschema of
-- v_mapping_id by default
procedure ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id in varchar2, XHS in varchar2, v_chosen_eschema in varchar2 := null);

-- It takes as input two template mappings and returns the outcome of the extension test.
-- It returns true if TM1 extends to TM2, false otherwise
function EXTENSION_TEST(v_mapping_id1 in varchar2, v_mapping_id2 varchar2) return boolean;


END TEMPLATE_MAPPINGS_UTILS;

/
