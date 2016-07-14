--------------------------------------------------------
--  File created - Thursday-July-14-2016   
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

-- It takes as input the id of a schema mapping,
-- the name of an Oracle database schema to apply the mapping, the 'LHS','RHS' for the mapping and generates
-- the corresponding e-schema.
-- It returns the identifiers of the created e-schema.
procedure GENERATE_ESCHEMAS_FROM_XHS (v_mapping_id in varchar2, v_database_schema varchar2, v_XHS varchar2, v_eschema out integer);

-- It returns the canonical template mapping for a given pair of e-schemas
procedure GET_CANONICAL_TEMPLATE_MAPPING (v_e_schema1 in varchar2, v_e_schema2 in varchar2,  v_mapping_id out varchar2);

-- It takes as input a canonical template mapping and returns a set of possible repairs for it
procedure GET_REPAIRED_TEMPLATE_MAPPINGS (v_mapping_id in varchar2, v_mapping_set_id out varchar2, lac_optimize boolean default false);

-- It takes as input a pair of disjoint mapping sets, each containing equivalent
-- canonical mappings, and produces the merged set.
-- It determines the list of pairs (c1, c2) where c1 and c2 are canonical template mappings
-- in the input sets, such that c1 extends to c2
-- and the list of pairs (c2, c1) such that c2 extends to c1. 
-- Then all the c1 and c2 are added to the output set
procedure MERGE_MAPPING_SETS (v_mapping_set_id1 in varchar2, v_mapping_set_id2 in varchar2, v_mapping_set_id out varchar2);

-- It takes as input a mapping set and produces a new mapping set with
-- all the possible variants (including the original ones)
procedure GENERATE_VARIANTS (v_mapping_set_id in varchar2, v_new_mapping_set out varchar2, lac_optimize boolean default false);

-- We take as input a list schema mappings (separated by ";"), all from S to T and do the following:
-- 1)
-- schema mapping 1 --> canonical mapping 1 --> set 1 of repaired canonical mappings
-- schema mapping 2 --> canonical mapping 2 --> set 2 of repaired canonical mappings
-- ...
-- schema mapping N --> canonical mapping N --> set N of repaired canonical mappings

-- 2)
-- set 1 +merge+ set 2 +merge+ ... +merge+ setN --> set M of merged canonical template mappings

-- 3)
-- generate_variants(set M) --> set Q of the possible variants
-- set M is the final output
procedure encode(v_mapping_list in clob, v_source_schema in varchar2, v_target_schema in varchar2, v_mapping_set out varchar2, enable_second_level_variants boolean default true, lac_optimize boolean default false);

-- We take as input a database schema and a conjunctive query defined over it.
-- We encode the restriction of the schema that responds to that query.
procedure encode_relational_query(v_query_string in clob, v_database_schema in varchar2, v_eschema out varchar2);

-- It searches the transformations that are more suitable
-- to transform a source, target (or both) database schema
-- as constrained by a conjunctive query
procedure search_transformation(v_query varchar2, v_database_schema varchar2, v_source_target_both varchar2);


-- It searches a transformation using the index
procedure search_transformation_index(v_query varchar2, v_database_schema varchar2);

-- It calculates for a given transformation
-- the number of homomorphisms towards all the mappings (LHS and RHS) and
-- stores it into a profile
procedure profile_transformation(v_query varchar2, v_database_schema varchar2, v_source_target_both varchar2);

END GAIA;

/
