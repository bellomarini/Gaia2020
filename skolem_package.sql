--------------------------------------------------------
--  File created - Thursday-February-11-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package SKOLEM
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."SKOLEM" AS 

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- SKOLEM Functions for metamodel objects
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- It takes as input the name of the atom and returns a relation_id
function relations_from_atoms_sk(v_atom_name varchar2, v_eschema varchar2) return varchar2;

-- It takes as input the name of an atom, the position of a variable and returns an attribute_id
function attributes_from_variables_sk(v_atom_name varchar2, v_variable_position varchar2, v_eschema varchar2) return varchar2;

-- It takes as input the name of an atom, the position of a variable and returns a key_id
function keys_from_variables_sk(v_atom_name varchar2, v_variable_position varchar2, v_eschema_id varchar2) return varchar2;

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- SKOLEM Functions for mappings
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-- It takes as input the identifier of a relation and creates the corresponding
-- atom identifier
function atoms_from_relations_sk(v_relation_id varchar2, v_mapping varchar2) return varchar2;

-- It takes as input the identifier of an attribute and creates the corresponding
-- atom identifier
function atoms_from_attributes_sk(v_attribute_id varchar2, v_mapping varchar2) return varchar2;

-- It takes as input the identifier of a key and creates the corresponding
-- key identifier
function atoms_from_keys_sk(v_key_id varchar2, v_mapping varchar2) return varchar2;

-- It takes as input the identifier of a foreign key and creates teh
-- corresponding key indentifier
function atoms_from_fkeys_sk(v_fkey_id varchar2, v_mapping varchar2) return varchar2;

-- It takes as input a literal value, from an example, and returns an id of
-- a variable.
function variables_from_literals_sk(v_literal varchar2, v_mapping varchar2) return varchar2;

END SKOLEM;

/
