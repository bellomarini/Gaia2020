--------------------------------------------------------
--  File created - Friday-February-19-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body MAPPINGS_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."MAPPINGS_UTILS" AS

procedure PARSE_MAPPING(v_mapping_string in varchar2, v_mapping_id out varchar2) as

atom_name varchar2(20) := 'dummy';
param_list varchar2(20) := 'dummy';
var varchar2(20) := 'dummy';
v_condition varchar2(20) := 'dummy';
v_cond_pos integer := 1;
pos integer := 1;
var_pos integer := 1;

first_rhs varchar2(20); -- the first atom in the RHS
lhs varchar(3) := 'LHS'; -- if considering the LHS or the RHS

var_id varchar2(20) := null;
v_quantification varchar(1); -- U or E

mapping_id integer;

begin

-- it detects the first atom in the RHS
-- so as to understand when actually parsing RHS
select regexp_substr(v_mapping_string,'\-\>\s*(\w+)',1,1,NULL,1) into first_rhs from dual;

-- it stores the mapping
insert into mappings(id, description, source_schema, target_schema, type) values (seq_mappings.nextval, v_mapping_string, null, null,'S');

-- stores the mapping id for later use
select seq_mappings.currval into mapping_id from dual;

dbms_output.put_line('Parsing LHS:');

while atom_name is not null
loop

    var_pos := 1;
    var := 'dummy';
    select regexp_substr(v_mapping_string,'(\w+)\s*\(',1,pos,NULL,1) 
    into atom_name from dual;
    exit when atom_name is null;
    
    -- it detects if we have started to
    -- parse the rhs
    if atom_name = first_rhs then
        dbms_output.put_line('Parsing RHS');
        lhs := 'RHS';
    end if;
    
    dbms_output.put_line('Atom : ' || atom_name);
    
    -- it stores the current atom
    insert into atoms (id, name, mapping, lhs_rhs) values (seq_atoms.nextval,atom_name,seq_mappings.currval,lhs);
    
    select regexp_substr(v_mapping_string,'\(((\w+\s*,?\s*)+\s*\w*\s*)\)',1,pos,NULL,1) into param_list from dual;
    
    dbms_output.put_line('  Parameters : ' || param_list);

    while var is not null
    loop
        select regexp_substr(param_list,'(\w+)',1,var_pos,NULL,1) into var from dual;
        exit when var is null;
        
        -- to understand the quantification, it operates as follows.
        -- It extracts the id of the variable, to understand if it
        -- has already been added.
        begin
            select id into var_id
            from variables where mapping = mapping_id and name = var;
        exception
            when no_data_found then
                var_id := null;
        end;
        
        -- Is we are in the RHS, and the variable appears for the first time
        -- then it is existentially quantified
        if lhs='RHS' and var_id is null then 
            v_quantification := 'E';
        -- else if in LHS or if the variable has already been used
        -- then it is universally quantified
        else  
            v_quantification := 'U';
        end if;
        
        dbms_output.put_line('      Variable: ('||v_quantification||') '|| var);

        -- if the first time, generate an identifier and insert
        if var_id is null then
            insert into variables(name, mapping, quantification, id) values (var, seq_mappings.currval, v_quantification , seq_variables.nextval);
            select seq_variables.currval into var_id from dual;
        end if;
        
        -- it stores the current variable in the respective atom
        insert into variables_atoms(variable, atom, position) values (var_id, seq_atoms.currval, var_pos);
        
        var_pos := var_pos + 1;
    end loop;
    pos := pos + 1;

end loop;

-- to parse the conditions
dbms_output.put_line('Conditions:');

while v_condition is not null
loop
    select regexp_substr(v_mapping_string,',(\w+(=|<>)\"\w+\")',1,v_cond_pos,NULL,1) into v_condition from dual;
    exit when v_condition is null;
    
    dbms_output.put_line('Condition: ' || v_condition);

    declare
        v_var varchar2(20);
        v_var_id varchar2(20);
        v_op varchar2(2);
        v_val varchar2(20);
        
    begin
        
        select regexp_substr(v_condition,'(\w+)(=|<>)\"(\w+)\"',1,1,NULL,1) into v_var from dual;
        select regexp_substr(v_condition,'(\w+)(=|<>)\"(\w+)\"',1,1,NULL,2) into v_op from dual;
        select regexp_substr(v_condition,'(\w+)(=|<>)\"(\w+)\"',1,1,NULL,3) into v_val from dual;
        
        -- retrieves the id of the variable
        -- for the current condition
        select id into v_var_id
        from variables
        where name = v_var
        and mapping = mapping_id;

        insert into conditions(id, variable, value, cond_type)
        values (seq_conditions.nextval, v_var_id, v_val, case when v_op = '=' then 'EQ' else 'NEQ' end);
                
    end;
    
    v_cond_pos := v_cond_pos + 1;
        
end loop;


v_mapping_id := mapping_id;

dbms_output.put_line('Mapping generated: ' || v_mapping_id);

end PARSE_MAPPING;



procedure MAPPING_TO_STRING_BY_ID(v_mapping_id in varchar2, v_mapping_string out varchar2) as

-- cursor to rebuild the mapping string
cursor cur_mapping is 
select lhs_rhs, a.name as "ATOM", a.id as "ATOM_ID", v.name as "VARIABLE"
    from 
        mappings m join atoms a on (a.mapping = m.id)
        join variables_atoms va on (a.id = va.atom)
        join variables v on (va.variable = v.id)
    where m.id = v_mapping_id
    order by lhs_rhs, a.id, va.position;

cursor cur_conditions is
select v.name, case when cond_type = 'EQ' then '=' else '<>' end, cond.value
from conditions cond join variables v on (cond.variable = v.id)
where v.mapping = v_mapping_id;
    
v_lhs_rhs varchar2(20);
v_atom_name varchar2(20);
v_atom_id varchar2(20);
v_var_name varchar2(20);

v_cond_var varchar2(20);
v_cond_op varchar2(2);
v_cond_val varchar2(20);


v_rhs_ok boolean := false;

v_prev_atom_id varchar2(20) := null;

begin

open cur_mapping;

loop
    fetch cur_mapping into v_lhs_rhs, v_atom_name, v_atom_id, v_var_name;
    exit when cur_mapping%notfound;
    
    -- sets the '->' symbol
    if not v_rhs_ok and v_lhs_rhs = 'RHS' then
        -- close the last atom
        v_mapping_string := v_mapping_string || ')';
        
        -- parse the conditions
        open cur_conditions;
        loop
        fetch cur_conditions into v_cond_var, v_cond_op, v_cond_val;
        exit when cur_conditions%notfound;
            v_mapping_string := v_mapping_string || ','||v_cond_var||v_cond_op||'"'||v_cond_val||'"';
        end loop;
        close cur_conditions;
        
        -- the arrow
        v_mapping_string := v_mapping_string || '->';
        -- and starts from a new atom
        v_prev_atom_id := null;
        v_rhs_ok := true;
    end if;
    
    -- if the first atom of LHS or RHS
    if v_prev_atom_id is null then
        v_mapping_string := v_mapping_string || v_atom_name || '(' || v_var_name;
    -- if a new atom, close the previous and open a new one
    elsif v_prev_atom_id != v_atom_id then
        v_mapping_string := v_mapping_string || '),' || v_atom_name || '(' || v_var_name;
    -- if the same atom, just another variable
    else
        v_mapping_string := v_mapping_string || ',' || v_var_name;
    end if;
    
    v_prev_atom_id := v_atom_id;
            
end loop;
    
    v_mapping_string := v_mapping_string || ')';

end MAPPING_TO_STRING_BY_ID;

procedure CLONE_MAPPING(v_mapping_id in varchar2, v_new_mapping_id out varchar2) as
begin

    select seq_mappings.nextval into v_new_mapping_id from dual;
    dbms_output.put_line('Cloning into mapping ' || v_new_mapping_id);

    -- mapping
    insert into mappings (id, description, source_schema, target_schema, type, repair_ref)
        select v_new_mapping_id, description, source_schema, target_schema, type, id
        from mappings
        where id = v_mapping_id;
    
    -- atoms
    insert into atoms (id, name, mapping, LHS_RHS)
        select skolem.atoms_from_atoms_sk(id,v_new_mapping_id), name, v_new_mapping_id, LHS_RHS
        from atoms
        where mapping = v_mapping_id;
        
    -- variables
    insert into variables(id, name, mapping, quantification)
        select skolem.variables_from_variables_sk(id, v_new_mapping_id), 'var' || skolem.variables_from_variables_sk(id, v_new_mapping_id), v_new_mapping_id, quantification
        from variables
        where mapping = v_mapping_id;
    
    -- variables_atoms
    insert into variables_atoms(variable, atom, position)
    select skolem.variables_from_variables_sk(variable, v_new_mapping_id),
           skolem.atoms_from_atoms_sk(atom, v_new_mapping_id),
           position
    from variables_atoms
    where atom in (
        select id
        from atoms
        where mapping = v_mapping_id);
    
    -- conditions
    insert into conditions(id, variable, value, cond_type)
        select seq_conditions.nextval, skolem.variables_from_variables_sk(variable, v_new_mapping_id),
            value, cond_type
        from conditions
        where variable in (
            select id
            from variables
            where mapping = v_mapping_id);
end CLONE_MAPPING;

procedure UPDATE_DESCRIPTION(v_mapping_id in varchar2) as
    v_mapping_string varchar2(400);
begin
        MAPPINGS_UTILS.MAPPING_TO_STRING_BY_ID(v_mapping_id, v_mapping_string);
        update mappings
        set description = v_mapping_string
        where id = v_mapping_id;

end UPDATE_DESCRIPTION;

END MAPPINGS_UTILS;

/
