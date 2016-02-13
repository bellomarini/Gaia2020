--------------------------------------------------------
--  File created - Saturday-February-13-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body GAIA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."GAIA" AS

PROCEDURE GET_CANONICAL_TEMPLATE_MAPPING 
(
  v_e_schema1 IN VARCHAR2  
, v_e_schema2 IN VARCHAR2  
) AS 

    v_mapping_id varchar2(20);
    v_mapping_string varchar2(200);
    
BEGIN
    
    select seq_mappings.nextval into v_mapping_id from dual;
    
    -- It creates and inserts the new mapping.
    
    -- Now we add one single mapping. Multiple mappings will be generated
    -- to handle rewritings.
    
    insert into mappings(id, description, source_schema, target_schema)
    values (v_mapping_id, null, null, null);
    
    -----------
    -- ATOMS --
    -----------
    -- We create the atoms, one for each relation, in the RHS and in the LHS
        insert into atoms(id, name, mapping, LHS_RHS)
        -- from RELATIONS
        select skolem.atoms_from_relations_sk(rel.id, v_mapping_id), 
            'RELATION', 
            v_mapping_id, 
            case when eschema = v_e_schema1 then 'LHS' else 'RHS' end
        from relations rel
        where 
        (eschema = v_e_schema1 or eschema = v_e_schema2)
    -- from ATTRIBUTES
    union
        select skolem.atoms_from_attributes_sk(att.id, v_mapping_id),
            'ATTRIBUTE',
            v_mapping_id,
            case when eschema = v_e_schema1 then 'LHS' else 'RHS' end
        from attributes att join relations rel on (att.relation = rel.id)
        where
        (eschema = v_e_schema1 or eschema = v_e_schema2)
    -- and for each key
    union
        select skolem.atoms_from_keys_sk(k.id, v_mapping_id),
            'KEY',
            v_mapping_id,
            case when eschema = v_e_schema1 then 'LHS' else 'RHS' end
        from keys k join relations rel on (k.relation = rel.id)
        where
        (eschema = v_e_schema1 or eschema = v_e_schema2)
    -- from FKEYS
    union
        select skolem.atoms_from_fkeys_sk(fk.id, v_mapping_id),
            'FKEY',
            v_mapping_id,
            case when eschema = v_e_schema1 then 'LHS' else 'RHS' end
        from fkeys fk join attributes att on (fk.from_column = att.id) join relations rel on (rel.id = att.relation)
        where
        (eschema = v_e_schema1 or eschema = v_e_schema2);
        

    ---------------
    -- VARIABLES --
    ---------------

   -- The quantification of variables is set to 'U' and then updated to 'E' when needed
   
        insert into variables(id, name, mapping, quantification)
        -- FROM RELATIONS.NAME : one name variable for each relation fact
        select skolem.variables_from_literals_sk(rel.name, v_mapping_id) as id,
           'var' || skolem.variables_from_literals_sk(rel.name, v_mapping_id) as name,
           v_mapping_id as mapping,
           'U' as quantification
           from relations rel
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)        
        union
        -- ATTRIBUTES.NAME: one name variable for each attribute fact
           select skolem.variables_from_literals_sk(att.name, v_mapping_id) as id,
           'var' || skolem.variables_from_literals_sk(att.name, v_mapping_id) as name,
           v_mapping_id as mapping,
           'U' as quantification
           from attributes att join relations rel on (att.relation = rel.id)
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- ATTRIBUTES.RELATION: one relation variable for each attribute fact
        union
            select skolem.variables_from_literals_sk(rel.name, v_mapping_id) as id,
            'var' || skolem.variables_from_literals_sk(rel.name, v_mapping_id) as name,
            v_mapping_id as mapping,
            'U' as quantification
                       from attributes att join relations rel on (att.relation = rel.id)
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- KEYS.NAME: one name variable for each key fact
        union
            select skolem.variables_from_literals_sk(k.name, v_mapping_id) as id,
            'var' || skolem.variables_from_literals_sk(k.name, v_mapping_id) as name,
            v_mapping_id as mapping,
            'U' as quantification
            from keys k join relations rel on (k.relation = rel.id)
            where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- KEYS.RELATION: one relation variable for each key fact
        union
             select skolem.variables_from_literals_sk(rel.name, v_mapping_id) as id,
            'var' || skolem.variables_from_literals_sk(rel.name, v_mapping_id) as name,
            v_mapping_id as mapping,
            'U' as quantification
                       from keys k join relations rel on (k.relation = rel.id)
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- FKEYS.FROM_COLUMN: one from_column variable for each fkey fact
        union
            select skolem.variables_from_literals_sk(att.name, v_mapping_id) as id,
            'var' || skolem.variables_from_literals_sk(att.name, v_mapping_id) as name,
            v_mapping_id as mapping,
            'U' as quantification
            from fkeys fk join attributes att on (fk.from_column = att.id)
                join relations rel on (att.relation = rel.id)
                           where (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- FKEYS.TO_RELATION: one to_relation variable for each fkey fact
        union
            select skolem.variables_from_literals_sk(to_rel.name, v_mapping_id) as id,
            'var' || skolem.variables_from_literals_sk(to_rel.name, v_mapping_id) as name,
            v_mapping_id as mapping,
            'U' as quantification
            from fkeys fk join attributes att on (fk.from_column = att.id)
                join relations rel on (att.relation = rel.id) join relations to_rel on (fk.to_relation = to_rel.id)
                           where (rel.eschema = v_e_schema1 or rel.eschema = v_e_schema2);
        

    -- and connect the various variables to the respective atoms
    -- select all the variables that have been added to this mapping
    
    ------------------
    -- VARIABLES_ATOMS
    ------------------

    insert into variables_atoms(variable, atom, position) 
        -- FROM RELATIONS.NAME : one name variable for each relation fact
        select 
            skolem.variables_from_literals_sk(rel.name, v_mapping_id) as variable,
            skolem.atoms_from_relations_sk(rel.id, v_mapping_id) as atom,
           '1' as position
           from relations rel
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        union
        -- ATTRIBUTES.NAME: one name variable for each attribute fact
            select           
            skolem.variables_from_literals_sk(att.name, v_mapping_id) as variable,
            skolem.atoms_from_attributes_sk(att.id, v_mapping_id) as atom,
           '1' as position
           from attributes att join relations rel on (att.relation = rel.id)
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- ATTRIBUTES.RELATION: one relation variable for each attribute fact
        union
            select           
            skolem.variables_from_literals_sk(rel.name, v_mapping_id) as variable,
            skolem.atoms_from_attributes_sk(att.id, v_mapping_id) as atom,
           '2' as position
           from attributes att join relations rel on (att.relation = rel.id)
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- KEYS.NAME: one name variable for each key fact
        union
            select           
            skolem.variables_from_literals_sk(k.name, v_mapping_id) as variable,
            skolem.atoms_from_keys_sk(k.id, v_mapping_id) as atom,
           '1' as position
            from keys k join relations rel on (k.relation = rel.id)
            where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        union
        -- KEYS.RELATION: one relation variable for each key fact
            select           
            skolem.variables_from_literals_sk(rel.name, v_mapping_id) as variable,
            skolem.atoms_from_keys_sk(k.id, v_mapping_id) as atom,
           '2' as position
                       from keys k join relations rel on (k.relation = rel.id)
           where 
            (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- FKEYS.FROM_COLUMN: one from_column variable for each fkey fact
        union
            select           
            skolem.variables_from_literals_sk(att.name, v_mapping_id) as variable,
            skolem.atoms_from_fkeys_sk(fk.id, v_mapping_id) as atom,
           '1' as position
            from fkeys fk join attributes att on (fk.from_column = att.id)
                join relations rel on (att.relation = rel.id)
                           where (eschema = v_e_schema1 or eschema = v_e_schema2)
        -- FKEYS.TO_RELATION: one to_relation variable for each fkey fact
        union
           select           
            skolem.variables_from_literals_sk(to_rel.name, v_mapping_id) as variable,
            skolem.atoms_from_fkeys_sk(fk.id, v_mapping_id) as atom,
           '2' as position
            from fkeys fk join attributes att on (fk.from_column = att.id)
                join relations rel on (att.relation = rel.id) join relations to_rel on (fk.to_relation = to_rel.id)
                           where (rel.eschema = v_e_schema1 or rel.eschema = v_e_schema2);
      
            
        -- We update the quantification
            update variables
            set quantification = 'E'
            where id in (
                select v.id 
                from variables v join variables_atoms va on (v.id = va.variable)
                                  join atoms a on (a.id = va.atom)
                where LHS_RHS = 'RHS'
                and v.mapping = v_mapping_id
                and not exists (
                select * from 
                    variables v1 join variables_atoms va1 on (v1.id = va1.variable)
                        join atoms a1 on (a1.id = va1.atom)
                    where a1.LHS_RHS = 'LHS'
                    and v1.id = v.id
                )
            );
        
        -- We update the textual description of the template mapping
        
        GAIA.MAPPING_TO_STRING_BY_ID(v_mapping_id, v_mapping_string);
        update mappings
        set description = v_mapping_string
        where id = v_mapping_id;
        
        dbms_output.put_line('Generated template mapping: ' || v_mapping_id);

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
    
v_lhs_rhs varchar2(20);
v_atom_name varchar2(20);
v_atom_id varchar2(20);
v_var_name varchar2(20);

v_rhs_ok boolean := false;

v_prev_atom_id varchar2(20) := null;

begin

open cur_mapping;

loop
    fetch cur_mapping into v_lhs_rhs, v_atom_name, v_atom_id, v_var_name;
    exit when cur_mapping%notfound;
    
    -- sets the '->' symbol
    if not v_rhs_ok and v_lhs_rhs = 'RHS' then
        v_mapping_string := v_mapping_string || ')->';
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

-- It verifies if a mapping appropriately applies
-- to a source and a target schema
function VERIFY_BINDING(v_mapping_id in varchar2, v_database_source_schema varchar2, v_database_target_schema varchar2) return boolean
as
v_atom_name varchar2(20);
v_atom_id varchar2(20);
v_lhs_rhs varchar2(3);
v_vars_no integer;
v_cols_no integer;

    -- Query to verify if some relations in the LHS
    -- are not present in the source schema (with the atom name and as many variables as the attributes)
    -- and if some relations in the RHS are not present in the target schema (with the atom name and as
    -- many variables as the attributes).
    cursor verify_binding is
    select B.ATOM_ID, B.ATOM_NAME, B.LHS_RHS, B.VARS_NO, A.COLS_NO
    from
    (select 
        a.name as TABLE_NAME, a.LHS_RHS, 
        count(*) as COLS_NO
    from 
        atoms a,
        all_tables tab,
        all_tab_columns cols
    where
        a.name = tab.table_name
        and a.mapping='45'
        and ((tab.owner = v_database_source_schema and a.LHS_RHS='LHS') or (tab.owner = v_database_target_schema and a.LHS_RHS='RHS'))
        and ((tab.owner = v_database_source_schema and a.LHS_RHS='LHS') or (tab.owner = v_database_target_schema and a.LHS_RHS='RHS'))
        and cols.table_name = tab.table_name
    group by a.name, a.LHS_RHS) A,
    (select 
        a.id as ATOM_ID,
        a.name as ATOM_NAME, a.LHS_RHS, 
        count(*) as VARS_NO
    from 
        atoms a,
        variables_atoms va
    where
        a.mapping=v_mapping_id
        and va.atom = a.id
    group by a.id, a.name, a.LHS_RHS) B
    where A.TABLE_NAME = B.ATOM_NAME
    and A.LHS_RHS = B.LHS_RHS;

begin

    open verify_binding;
    loop
    fetch verify_binding into v_atom_id, v_atom_name, v_lhs_rhs, v_vars_no, v_cols_no;
    
    exit when verify_binding%notfound;
        if v_vars_no <> v_cols_no and v_cols_no>0 then
                dbms_output.put_line('Atom ' || v_atom_name || ' (' || v_lhs_rhs || ') has ' || v_vars_no || ' variables, while the corresponding relation has ' || v_cols_no || ' attributes');
        elsif v_cols_no = 0 then
                dbms_output.put_line('Atom ' || v_atom_name || ' (' || v_lhs_rhs || ') has no corresponding relation');
        end if;
        return false;
    end loop;
    close verify_binding;

    dbms_output.put_line('Mapping consistent with database schemas');
    return true;
END VERIFY_BINDING;




procedure GENERATE_ESCHEMAS(v_mapping_id in varchar2, v_database_source_schema varchar2, v_database_target_schema varchar2, v_eschema1 out integer, v_eschema2 out integer) as

check_ok boolean := true;
v_source_eschema_id varchar2(20);
v_target_eschema_id varchar2(20);
begin    
    -- We verify if the mapping correctly binds to the schemas
    check_ok := VERIFY_BINDING(v_mapping_id, v_database_source_schema, v_database_target_schema);
    -- Then, we encode the mapping

    -- ids for the new eschemas
    select seq_eschemas.nextval into v_source_eschema_id from dual;
    v_eschema1 := v_source_eschema_id;
    select seq_eschemas.nextval into v_target_eschema_id from dual;
    v_eschema2 := v_target_eschema_id;

    -- for each ATOM a --> RELATION r
    --  for each VARIABLE v in a --> ATTRIBUTE att in r named after the variable (for the non keys)
    --  for each VARIABLE v in a --> KEY key in r named after the variable (for the keys)
    --  for any two ATOMS a1 a2 linked by a FK in the database schema f --> FK
    
    -- for each atom we create a relation
    -- creating a distinct relation for each atom name.
    insert into relations(id, name, eschema)
    select distinct case LHS_RHS when 'LHS' then skolem.relations_from_atoms_sk(a.name,v_source_eschema_id)
                        when 'RHS' then skolem.relations_from_atoms_sk(a.name,v_target_eschema_id) end,
           name, 
           case LHS_RHS when 'LHS' then v_source_eschema_id
                        when 'RHS' then v_target_eschema_id end
    from atoms a
    where mapping = v_mapping_id;
    
    -- for each variable position of each atom 
    -- we create an attribute and connect it to
    -- the right relation
    -- if it is not a key attribute
    insert into attributes(id, name, relation, position)
    select case LHS_RHS when 'LHS' then skolem.attributes_from_variables_sk(a.name,va.position, v_source_eschema_id)
                        when 'RHS' then skolem.attributes_from_variables_sk(a.name,va.position, v_target_eschema_id) end, 
                        v.name as name,
           case LHS_RHS when 'LHS' then skolem.relations_from_atoms_sk(a.name, v_source_eschema_id)
                        when 'RHS' then skolem.relations_from_atoms_sk(a.name, v_target_eschema_id) end,
           va.position
    from variables v join variables_atoms va on (v.id = va.variable)
        join atoms a on (va.atom = a.id)
    where
    a.mapping = v_mapping_id
    and not exists (
        select *
        from all_cons_columns cons
        where
            cons.column_name = (case LHS_RHS when 'LHS' then CATALOG_UTILS.get_column_name_in_position(v_database_source_schema, a.name, va.position)
                                             when 'RHS' then CATALOG_UTILS.get_column_name_in_position(v_database_target_schema, a.name, va.position) end)
            and cons.constraint_name like '%PK'
    );
    
    -- for each variable position of each atom 
    -- we create an attribute and connect it to
    -- the right relation
    -- if it is a key attribute
    insert into keys(id, name, relation, position)
    select case LHS_RHS when 'LHS' then skolem.keys_from_variables_sk(a.name, va.position,v_source_eschema_id)
                        when 'RHS' then skolem.keys_from_variables_sk(a.name, va.position, v_target_eschema_id) end,
                        v.name as name,
                        case LHS_RHS when 'LHS' then skolem.relations_from_atoms_sk(a.name, v_source_eschema_id)
                         when 'RHS' then skolem.relations_from_atoms_sk(a.name, v_target_eschema_id) end,
            va.position
    from variables v join variables_atoms va on (v.id = va.variable)
        join atoms a on (va.atom = a.id)
    where
    a.mapping = v_mapping_id
    and exists (
        select *
        from all_cons_columns cons
        where
            cons.column_name = (case LHS_RHS when 'LHS' then CATALOG_UTILS.get_column_name_in_position(v_database_source_schema, a.name, va.position)
                                             when 'RHS' then CATALOG_UTILS.get_column_name_in_position(v_database_target_schema, a.name, va.position) end)
            and cons.constraint_name like '%PK'
    );
    
    -- for each pairs of relations in the source and target eschema, if the corresponding
    -- Oracle relations have a fkey, then create a fk in the metamodel
    insert into fkeys(id, from_column, to_relation)
    select 
        seq_fkeys.nextval, 
        att.id as CHILD_ATT_ID,
        a2.id as PARENT_ID
    from 
        relations a1,
        relations a2,
        attributes att,
        all_cons_columns cons,
        all_constraints c1, all_constraints c2
    where 
        a1.eschema = v_source_eschema_id
        and a1.eschema = a2.eschema
        and a1.id<>a2.id
        and cons.table_name = a1.name
        and c1.constraint_name = cons.constraint_name
        and c1.constraint_type = 'R'
        and c2.constraint_name = c1.r_constraint_name
        and c2.table_name = a2.name
        and att.relation = a1.id
        and c1.owner = c2.owner
        and (c1.owner = v_database_source_schema or c1.owner = v_database_target_schema)
        and att.position = catalog_utils.get_column_position_by_name(c1.owner, a1.name, cons.column_name);
        -- selezionare la variabile per posizione
        -- selezionare l'attributo dalla variabile
  



end GENERATE_ESCHEMAS;



END GAIA;

/
