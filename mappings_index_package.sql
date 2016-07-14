--------------------------------------------------------
--  File created - Thursday-July-14-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package MAPPINGS_INDEX
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."MAPPINGS_INDEX" AS 
    
    procedure index_all_mappings;
    
    -- indexes a given mapping
    function index_mapping(v_mapping_id in varchar2) return number;
    
    -- number of relations in the LHS
    function l_rel(v_mapping_id in varchar2) return number;
    
    -- number of relations in the RHS
    function r_rel(v_mapping_id in varchar2) return number;
    
    -- number of existentially quantified variables
    function exist(v_mapping_id in varchar2) return number;
    
    -- number of joins in the LHS
    function l_join(v_mapping_id in varchar2) return number;
    
    -- number of joins in the RHS
    function r_join(v_mapping_id in varchar2) return number;
    
    -- number of relations in the LHS without any variable in common
    function l_cart(v_mapping_id in varchar2) return number;
    
    -- number of relations in the RHS without any variable in common
    function r_cart(v_mapping_id in varchar2) return number;
    
    -- number of joins along FKs in the LHS
    function l_join_fk(v_mapping_id in varchar2) return number;
    
    -- number of joins along FKs in the RHS
    function r_join_fk(v_mapping_id in varchar2) return number;
    
    -- TODO
    -- number of cartesian products along FKs in LHS
    -- function l_cart_fk(v_mapping_id in varchar2) return number;
    
    -- TODO
    -- number of cartesian products along FKs in RHS
    -- function r_cart_fk(v_mapping_id in varchar2) return number;

    -- number of joins along a key in the LHS
    function l_join_key(v_mapping_id in varchar2) return number;
    
    -- number of joins along a key in the RHS
    function r_join_key(v_mapping_id in varchar2) return number;
    
    -- number of distinct variables copied from LHS to RHS
    function var_copied(v_mapping_id in varchar2) return number;
    
    -- TODO
    -- number of unique pairs of variables in distinct relations
    -- without FKs in the LHS copied to the same relation
    -- or into relations with Fks in the RHS
    -- function var_joined(v_mapping_id in varchar2) return number;
    
    -- TODO
    -- ... 
    
    -- scores a query to assess the similarity with mappings
    function score_query(v_query_id in varchar2) return integer;



END MAPPINGS_INDEX;

/
