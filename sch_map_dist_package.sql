--------------------------------------------------------
--  File created - Saturday-July-23-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package SCH_MAP_DIST
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."SCH_MAP_DIST" AS 

    -- this function returns a similarity score between a mapping that represents a transformation
    -- i.e. source and target schema and a schema mapping.
    -- The score is based on an encoding of the LHS or RHS of the mapping.
    -- v_mapping_id the id of the mapping that represents the transformation to be performed
    -- v_in_mapping_eschema is an eschema encoded out of mapping v_mapping_id (LHS or RHS)
    --  it contains the actual names of tables and attributes
    -- v_target_mapping_id is the id of the mapping in the repository to be compared with the input one
    --  it is a template
    function distance(v_in_mapping_id in varchar2, v_in_mapping_eschema in varchar2, v_target_mapping_id in varchar2) 
        return number;

END SCH_MAP_DIST;

/
