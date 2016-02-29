--------------------------------------------------------
--  File created - Monday-February-29-2016   
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

-- It returns a set of template mappings, obtained as the
-- merge of the two mappings passed as parameters
-- if TM1 extends to TM2 but TM2 does not extend to TM1 --> {TM2}
-- if TM2 extends to TM1 but TM1 does not extend to TM2 --> {TM1}
-- if TM1 extends to TM2 and TM2 extends to TM1 --> {TM1, TM2}
-- if none extends to the other --> null
procedure MERGE_TEMPLATE_MAPPINGS(v_mapping_id1 in varchar2, v_mapping_id2 in varchar2, v_mapping_sets_id out varchar2);


END TEMPLATE_MAPPINGS_UTILS;

/
