--------------------------------------------------------
--  File created - Tuesday-February-09-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body SKOLEM
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."SKOLEM" AS

  function relations_from_atoms_sk(v_atom_id varchar2, v_eschema varchar2) return varchar2 AS
  v_id_out varchar2(20);
  BEGIN
    
    begin
    -- if the function has already been calculated then return that value
    select out into v_id_out
    from relations_sk
    where function = 'relations_from_atoms_sk'
    and atom_id = v_atom_id
    and eschema = v_eschema;
    -- if this is the first time, then calculate the value from the sequence
    -- and insert it for later use
    exception
        when no_data_found then
            select seq_relations.nextval into v_id_out from dual;
            insert into relations_sk(out, function, atom_id, eschema) values (v_id_out,'relations_from_atoms_sk',v_atom_id, v_eschema);
    end;
    
    return v_id_out;
    
  END relations_from_atoms_sk;
  
  function attributes_from_variables_sk(v_variable_id varchar2, v_eschema varchar2) return varchar2 as
  v_id_out varchar2(20);
  BEGIN
    
    begin
    -- if the function has already been calculated then return that value
    select out into v_id_out
    from attributes_sk
    where function = 'attributes_from_variables_sk'
    and variable_id = v_variable_id
    and eschema = v_eschema;
    -- if this is the first time, then calculate the value from the sequence
    -- and insert it for later use
    exception
        when no_data_found then
            select seq_attributes.nextval into v_id_out from dual;
            insert into attributes_sk(out, function, variable_id, eschema) values (v_id_out,'attributes_from_variables_sk',v_variable_id, v_eschema);
    end;
    
    return v_id_out;
    
    end attributes_from_variables_sk;
    
    
    function keys_from_variables_sk(v_variable_id varchar2, v_eschema_id varchar2) return varchar2 as
        v_id_out varchar2(20);
        begin
        
        begin
        -- if the function has already been calculated then return that value
        select out into v_id_out
        from keys_sk
        where function = 'keys_from_variables_sk'
        and variable_id = v_variable_id
        and eschema = v_eschema_id;
        -- if this is the first time, then calculate the value from the sequence
        -- and insert it for later use
        exception
            when no_data_found then
                select seq_keys.nextval into v_id_out from dual;
                insert into keys_sk(out, function, variable_id, eschema) values (v_id_out,'keys_from_variables_sk',v_variable_id, v_eschema_id);
        
        end;
        
        return v_id_out;
    
    end keys_from_variables_sk;

END SKOLEM;

/
