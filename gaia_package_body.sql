--------------------------------------------------------
--  File created - Monday-February-08-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body GAIA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."GAIA" AS

PROCEDURE ENCODE_RELATION (v_relationName IN VARCHAR2, v_target_e_schema in varchar2  ) AS 

cursor cur_table is
    select cols.column_name, k2.constraint_type, k3.table_name AS "TO_TABLE", k3.column_name as "TO_COLUMN"
    from all_tab_columns cols
    left outer join all_cons_columns k on (k.column_name = cols.column_name and k.table_name = cols.table_name)
    left outer join all_constraints k2 on (k.constraint_name = k2.constraint_name and k2.constraint_type in ('P','R'))
    left outer join all_cons_columns k3 on (k2.r_constraint_name = k3.constraint_name)
    where cols.table_name = v_relationName
    and cols.owner = 'GAIA_INPUT'
    and nvl(k.owner,'GAIA_INPUT') = 'GAIA_INPUT'
    and nvl(k2.owner,'GAIA_INPUT') = 'GAIA_INPUT'
    and nvl(k3.owner,'GAIA_INPUT') = 'GAIA_INPUT'
    and (substr(k.constraint_name,1,3)<>'SYS' or k.constraint_name is null)
    order by constraint_type nulls last;
    
    v_col_name varchar2(20);
    v_cons_type varchar2(20);
    v_to_table varchar2(20);
    v_to_column varchar2(20);
    
    v_to_table_id varchar2(20);
    v_from_column_id varchar2(20);
    
    v_cur_col_name varchar2(20);
    
    first_loop boolean := true;
  
BEGIN
    dbms_output.put_line('Encoding relation ' || v_relationName || ' into e-schema ' || v_target_e_schema);
    
    -- encodes the relation and returns an error if it is
    -- duplicated
    begin
        insert into relations(eschema, id, name) values (v_target_e_schema, seq_relations.nextval, v_relationName);
    exception
        when DUP_VAL_ON_INDEX
            then dbms_output.put_line('Relation ' || v_relationName || ' already encoded for target schema ' || v_target_e_schema);
            rollback;
            return;
    end;
        
    v_cur_col_name := null;
    open cur_table;

        
    loop
        fetch cur_table into v_col_name, v_cons_type, v_to_table, v_to_column;
        exit when cur_table%NOTFOUND;
        first_loop := false;

        
        -- if the case, saves the attribute
        -- (notice that key attributes are stored only into KEYS)
        if (v_cur_col_name is null or v_cur_col_name != v_col_name) and v_cons_type != 'P' then
            insert into attributes(id,name,relation) values (seq_attributes.nextval, v_col_name, seq_relations.currval);
            v_cur_col_name := v_col_name;
            dbms_output.put_line('Encoding attribute ' || v_cur_col_name);
        -- if the case, saves the key
        elsif v_cons_type='P' then
            insert into keys(id,name,relation) values (seq_keys.nextval,v_col_name, seq_relations.currval);
            dbms_output.put_line('Encoding key ' || v_col_name);
        end if;
        
        -- if the case, saves the constraint
        if v_cons_type='R' then
        -- it finds the id of the referred relation, given its name        
            declare
                cur_rel varchar2(20);
            
            begin
            
                select seq_relations.currval into cur_rel from dual;
            
                select id into v_to_table_id
                from relations
                where eschema = v_target_e_schema
                    and name = v_to_table;
                
                select id into v_from_column_id
                from attributes
                where relation = cur_rel
                    and name = v_col_name;
                        
            exception
                when NO_DATA_FOUND then
                    dbms_output.put_line('Relation ' || v_relationName || ' refers to relation ' || v_to_table || ', which is not properly encoded');
                    rollback;
                    return;
                end;
        
            insert into fkeys(id,from_column,to_relation) values(seq_fkeys.nextval,v_from_column_id,v_to_table_id);
            dbms_output.put_line('Encoding fk from relation ' || v_relationName || ', attribute ' || v_col_name || ' to relation ' || v_to_table);
        
        end if;
        
    end loop;
    
    close cur_table;
    
    if first_loop then
        dbms_output.put_line('Table not found');
        rollback;
    end if;
    
    commit;
    
END ENCODE_RELATION;

PROCEDURE GET_CANONICAL_TEMPLATE_MAPPING 
(
  v_e_schema1 IN VARCHAR2  
, v_e_schema2 IN VARCHAR2  
) AS 

    lhs varchar(200);
    rhs varchar2(2000);
    tmp varchar2(70);
    
    cursor cur_fkeys (c_eschema varchar2) is
    select 'fkey('||a.name||','||r.name||','||r1.name||')'
        from fkeys f join attributes a on (f.from_column = a.id)
        join relations r on (a.relation = r.id)
        join relations r1 on (f.to_relation = r1.id)
        where r.eschema = c_eschema and r1.eschema = c_eschema;
    
    cursor cur_keys (c_eschema varchar2) is
        select 'key('||a.name||','||r.name||')'
        from keys a join relations r on (a.relation = r.id)
        where eschema = c_eschema;
    
    cursor cur_attributes (c_eschema varchar2) is
        select 'attribute('||a.name||','||r.name||')'
        from attributes a join relations r on (a.relation = r.id)
        where eschema = c_eschema;
    
    cursor cur_relations (c_eschema varchar2) is
        select 'relation('||name||')'
        from relations
        where eschema = c_eschema;
    
BEGIN
    
    -- building lhs
    open cur_relations (v_e_schema1);
    loop
        fetch cur_relations into tmp;
            exit when cur_relations%notfound;
        if lhs is null or length(lhs)=0 then
            lhs := tmp;
        else
            lhs := lhs || ', ' || tmp;
        end if;
    end loop;
    close cur_relations;
    
    open cur_keys (v_e_schema1);
    loop
        fetch cur_keys into tmp;
            exit when cur_keys%notfound;
        lhs := lhs || ', ' || tmp;
    end loop;
    close cur_keys;
    
    open cur_attributes (v_e_schema1);
    loop
        fetch cur_attributes into tmp;
            exit when cur_attributes%notfound;
        lhs := lhs || ', ' || tmp;
    end loop;
    close cur_attributes;
    
    open cur_fkeys (v_e_schema1);
    loop
        fetch cur_fkeys into tmp;
            exit when cur_fkeys%notfound;
        lhs := lhs || ', ' || tmp;
    end loop;
    close cur_fkeys;
    
    dbms_output.put_line(lhs);
    
    open cur_relations (v_e_schema2);
    open cur_keys (v_e_schema2);
    open cur_attributes (v_e_schema2);
    open cur_fkeys (v_e_schema2);
    
    close cur_fkeys;
    close cur_attributes;
    close cur_keys;
    close cur_relations;



END GET_CANONICAL_TEMPLATE_MAPPING;

procedure PARSE_MAPPING(v_mapping_string in varchar2, v_mapping_id out varchar2) as

atom_name varchar2(20) := 'dummy';
param_list varchar2(20) := 'dummy';
var varchar2(20) := 'dummy';
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
insert into mappings(id, description, source_schema, target_schema) values (seq_mappings.nextval, v_mapping_string, null, null);

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
    
    select regexp_substr(v_mapping_string,'\(((\w+\s*,\s*)+\s*\w+\s*)\)',1,pos,NULL,1) into param_list from dual;
    
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

v_mapping_id := mapping_id;

end PARSE_MAPPING;

function MAPPING_TO_STRING_BY_ID(v_mapping_id in varchar2) return varchar2 as

-- cursor to rebuild the mapping string
cursor cur_mapping is 
select lhs_rhs, a.name as "ATOM", v.name as "VARIABLE"
    from 
        mappings m join atoms a on (a.mapping = m.id)
        join variables_atoms va on (a.id = va.atom)
        join variables v on (va.variable = v.id)
    where m.id = v_mapping_id
    order by lhs_rhs, a.id, va.position;
    
v_mapping_string varchar(200);
v_lhs_rhs varchar2(20);
v_atom_name varchar2(20);
v_var_name varchar2(20);

v_rhs_ok boolean := false;

v_prev_atom_name varchar2(20) := null;

begin

open cur_mapping;

loop
    fetch cur_mapping into v_lhs_rhs, v_atom_name, v_var_name;
    exit when cur_mapping%notfound;
    
    -- sets the '->' symbol
    if not v_rhs_ok and v_lhs_rhs = 'RHS' then
        v_mapping_string := v_mapping_string || ')->';
        -- and starts from a new atom
        v_prev_atom_name := null;
        v_rhs_ok := true;
    end if;
    
    -- if the first atom of LHS or RHS
    if v_prev_atom_name is null then
        v_mapping_string := v_mapping_string || v_atom_name || '(' || v_var_name;
    -- if a new atom, close the previous and open a new one
    elsif v_prev_atom_name != v_atom_name then
        v_mapping_string := v_mapping_string || '),' || v_atom_name || '(' || v_var_name;
    -- if the same atom, just another variable
    else
        v_mapping_string := v_mapping_string || ',' || v_var_name;
    end if;
    
    v_prev_atom_name := v_atom_name;
            
end loop;
    
    v_mapping_string := v_mapping_string || ')';
    return v_mapping_string;

end MAPPING_TO_STRING_BY_ID;


END GAIA;

/
