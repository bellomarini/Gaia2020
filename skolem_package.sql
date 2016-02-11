--------------------------------------------------------
--  File created - Thursday-February-11-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package SKOLEM
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "GAIA"."SKOLEM" AS 

-- It takes as input the name of the atom and returns a relation_id
function relations_from_atoms_sk(v_atom_name varchar2, v_eschema varchar2) return varchar2;

-- It takes as input the name of an atom, the position of a variable and returns an attribute_id
function attributes_from_variables_sk(v_atom_name varchar2, v_variable_position varchar2, v_eschema varchar2) return varchar2;

-- It takes as input the name of an atom, the position of a variable and returns a key_id
function keys_from_variables_sk(v_atom_name varchar2, v_variable_position varchar2, v_eschema_id varchar2) return varchar2;


END SKOLEM;

/
