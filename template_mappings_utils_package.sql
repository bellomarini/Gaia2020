--------------------------------------------------------
--  File created - Saturday-February-27-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package TEMPLATE_MAPPINGS_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."TEMPLATE_MAPPINGS_UTILS" AS 

-- It takes as input the id of a template mapping, 'LHS' or 'RHS'
-- and populates relation HOMOMORPHISMS with all the possible homomorphism from the XHS to the values
procedure ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id in varchar2, XHS in varchar2);


END TEMPLATE_MAPPINGS_UTILS;

/
