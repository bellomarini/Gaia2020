--------------------------------------------------------
--  File created - Monday-February-22-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body SKOLEM
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."SKOLEM" AS

  function relations_from_atoms_sk(v_atom_name varchar2, v_eschema varchar2) return varchar2 AS
  v_id_out varchar2(20);
  BEGIN
    
    begin
    -- if the function has already been calculated then return that value
    select out into v_id_out
    from relations_sk
    where function = 'relations_from_atoms_sk'
    and atom_name = v_atom_name
    and eschema = v_eschema;
    -- if this is the first time, then calculate the value from the sequence
    -- and insert it for later use
    exception
        when no_data_found then
            select seq_relations.nextval into v_id_out from dual;
            insert into relations_sk(out, function, atom_name, eschema) values (v_id_out,'relations_from_atoms_sk',v_atom_name, v_eschema);
    end;
    
    return v_id_out;
    
  END relations_from_atoms_sk;
  
function attributes_from_variables_sk(v_atom_name varchar2, v_variable_position varchar2, v_eschema varchar2) return varchar2 as
  v_id_out varchar2(20);
  BEGIN
    
    begin
    -- if the function has already been calculated then return that value
    select out into v_id_out
    from attributes_sk
    where function = 'attributes_from_variables_sk'
    and atom_name = v_atom_name
    and variable_position = v_variable_position
    and eschema = v_eschema;
    -- if this is the first time, then calculate the value from the sequence
    -- and insert it for later use
    exception
        when no_data_found then
            select seq_attributes.nextval into v_id_out from dual;
            insert into attributes_sk(out, function, atom_name, variable_position, eschema) values (v_id_out,'attributes_from_variables_sk',v_atom_name, v_variable_position, v_eschema);
    end;
    
    return v_id_out;
    
    end attributes_from_variables_sk;
    
    
function keys_from_variables_sk(v_atom_name varchar2, v_variable_position varchar2, v_eschema_id varchar2) return varchar2 as
        v_id_out varchar2(20);
        begin
        
        begin
        -- if the function has already been calculated then return that value
        select out into v_id_out
        from keys_sk
        where function = 'keys_from_variables_sk'
        and atom_name = v_atom_name
        and variable_position = v_variable_position
        and eschema = v_eschema_id;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_keys.nextval into v_id_out from dual;
                insert into keys_sk(out, function, atom_name, variable_position, eschema) values (v_id_out,'keys_from_variables_sk',v_atom_name, v_variable_position, v_eschema_id);
        
        end;
        
        return v_id_out;
    
    end keys_from_variables_sk;
    
    function atoms_from_relations_sk(v_relation_id varchar2, v_mapping varchar2) return varchar2 as
    v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from atoms_sk
        where function = 'atoms_from_relations_sk'
        and relation_id = v_relation_id
        and mapping = v_mapping;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_atoms.nextval into v_id_out from dual;
                insert into atoms_sk(out, function, relation_id, mapping) 
                values (v_id_out,'atoms_from_relations_sk',v_relation_id, v_mapping);
        end;
        return v_id_out;
    end atoms_from_relations_sk;
    
    function atoms_from_attributes_sk(v_attribute_id varchar2, v_mapping varchar2) return varchar2 as
    v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from atoms_sk
        where function = 'atoms_from_attributes_sk'
        and attribute_id = v_attribute_id
        and mapping = v_mapping;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_atoms.nextval into v_id_out from dual;
                insert into atoms_sk(out, function, attribute_id, mapping) 
                values (v_id_out,'atoms_from_attributes_sk',v_attribute_id, v_mapping);
        end;
        return v_id_out;
    
    end atoms_from_attributes_sk;
    
    function atoms_from_keys_sk(v_key_id varchar2, v_mapping varchar2) return varchar2 as 
    v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from atoms_sk
        where function = 'atoms_from_keys_sk'
        and key_id = v_key_id
        and mapping = v_mapping;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_atoms.nextval into v_id_out from dual;
                insert into atoms_sk(out, function, key_id, mapping) 
                values (v_id_out,'atoms_from_keys_sk',v_key_id, v_mapping);
        end;
        return v_id_out;
    
    end atoms_from_keys_sk;
    
    function atoms_from_fkeys_sk(v_fkey_id varchar2, v_mapping varchar2) return varchar2 as
        v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from atoms_sk
        where function = 'atoms_from_fkeys_sk'
        and fkey_id = v_fkey_id
        and mapping = v_mapping;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_atoms.nextval into v_id_out from dual;
                insert into atoms_sk(out, function, fkey_id, mapping) 
                values (v_id_out,'atoms_from_fkeys_sk',v_fkey_id, v_mapping);
        end;
        return v_id_out;
    
    end atoms_from_fkeys_sk;
    
    
    function atoms_from_atoms_sk(v_atom_id varchar2, v_mapping_id varchar2) return varchar2 as
       v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from atoms_sk
        where function = 'atoms_from_atoms_sk'
        and atom_id = v_atom_id
        and mapping = v_mapping_id;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_atoms.nextval into v_id_out from dual;
                insert into atoms_sk(out, function, atom_id, mapping) 
                values (v_id_out,'atoms_from_atoms_sk',v_atom_id, v_mapping_id);
        end;
        return v_id_out;
    
    end atoms_from_atoms_sk;
    
    function variables_from_literals_sk(v_literal varchar2, v_mapping varchar2) return varchar2 as
    v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from variables_sk
        where function = 'variables_from_literals_sk'
        and literal = v_literal
        and mapping = v_mapping;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_variables.nextval into v_id_out from dual;
                insert into variables_sk(out, function, literal, mapping) 
                values (v_id_out,'variables_from_literals_sk',v_literal, v_mapping);
        end;
        return v_id_out;    
    
    end variables_from_literals_sk;
    
    
    function variables_from_variables_sk(v_variable varchar2, v_mapping varchar2) return varchar2 as
    v_id_out varchar2(20);
    begin
    
    begin
    -- if the function has already been calculated then return that value
        select out into v_id_out
        from variables_sk
        where function = 'variables_from_variables_sk'
        and variable_id = v_variable
        and mapping = v_mapping;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_variables.nextval into v_id_out from dual;
                insert into variables_sk(out, function, variable_id, mapping) 
                values (v_id_out,'variables_from_variables_sk',v_variable, v_mapping);
        end;
        return v_id_out;    
    


    end variables_from_variables_sk;
 
END SKOLEM;

/
