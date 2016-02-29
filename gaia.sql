--------------------------------------------------------
--  File created - Monday-February-29-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body GAIA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."GAIA" AS

PROCEDURE GET_CANONICAL_TEMPLATE_MAPPING (v_e_schema1 IN VARCHAR2, v_e_schema2 IN VARCHAR2, v_mapping_id out varchar2)
AS 
    v_mapping_string varchar2(200);
    
BEGIN
    
    select seq_mappings.nextval into v_mapping_id from dual;
    
    -- It creates and inserts the new mapping.
    
    -- Now we add one single mapping. Multiple mappings will be generated
    -- to handle rewritings.
    insert into mappings(id, description, source_schema, target_schema, type)
    values (v_mapping_id, null, v_e_schema1, v_e_schema2, 'C');
    
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
        MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_mapping_id);
        
        dbms_output.put_line('Generated template mapping: ' || v_mapping_id);
        
END GET_CANONICAL_TEMPLATE_MAPPING;


-- It takes as input a mapping set of repaired template mappings 
-- and enriches it with all the new mappings that are obtained 
-- by combining the conditions of the various mappings, 
-- picking the condition for one variable from
-- each template mapping

procedure SHUFFLE_MAPPING_SET (v_mapping_sets_id in varchar2) as

 cursor cur_shuffling is
        -- It builds the paths of all the possible
        -- choices for the conditions
        -- of the form "/original_variable_id:condition_from_mapping"
        -- It builds the paths of all the possible
        -- choices for the conditions
        -- of the form "/original_variable_id:condition_from_mapping"
            with A as (
            select /*+ materialize */ sys_connect_by_path(original_variable ||':'||from_mapping,'/') conditions, mapping, LEVEL from (
                            select distinct orig_var.id original_variable, var.mapping from_mapping, orig_var.mapping
                            from conditions c join variables var on (c.variable = var.id)
                                join mappings m on (m.id = var.mapping), variables orig_var
                            where 
                                var.mapping in (select mapping from mapping_sets where id = v_mapping_sets_id)
                                and orig_var.mapping = m.repair_ref
                                and c.variable = skolem.variables_from_variables_sk(orig_var.id,m.id)
                        ) 
                        where connect_by_isleaf = 1
                        connect by nocycle (prior original_variable > original_variable and prior from_mapping <> from_mapping)
            )
        select distinct CONDITIONS, MAPPING from A
        where "LEVEL" = (select max("LEVEL") from A) and regexp_count(conditions,'/') >1; -- to avoid one-variable conditions
    
        -- we then iterate along these paths and build a mappign for each
        -- cloning the mapping and taking the conditions from
        -- the appropriate source mapping
        
    v_conditions varchar2(500);
    v_variable_id varchar2(20);
    v_from_mapping_id varchar2(20);
    v_original_mapping_id varchar2(20);
    v_var_map varchar2(20);
    v_var varchar2(20);
    v_map varchar2(20);
    
    v_var_pos integer := 1;
    
    v_new_mapping_id varchar2(20);


begin
    
    open cur_shuffling;
    loop
        fetch cur_shuffling into v_conditions, v_original_mapping_id;
        exit when cur_shuffling%notfound;
        -- each row of the cursor represents a choice for all the conditions
        -- we clone the original mapping, parse the conditions and add them
        mappings_utils.clone_mapping(v_original_mapping_id, v_new_mapping_id);
        
        -- shuffled mappings
        update mappings set type = 'H' where id = v_new_mapping_id;
        
        -- add the mapping to the mapping set
        insert into mapping_sets (id, mapping) values (v_mapping_sets_id, v_new_mapping_id);
        
        v_var_pos := 1;
        
        loop
            select regexp_substr(v_conditions,'\w+:\w+',1,v_var_pos) into v_var_map from dual;
            exit when v_var_map is null;
                select regexp_substr(v_var_map,'(\w+)\:(\w+)',1,1,null,1) into v_var from dual;
                select regexp_substr(v_var_map,'(\w+)\:(\w+)',1,1,null,2) into v_map from dual;
                
                dbms_output.put_line('  Condition on the variable ' || v_var);
                dbms_output.put_line('  From the mapping ' || v_map);
                
                -- retrieves the value and cond_type of the condition for v_var in v_map
                -- and creates the new condition
                -- finding the corresponding variables with the Skolem function
                insert into conditions(id, variable, value, cond_type)
                    select seq_conditions.nextval, skolem.variables_from_variables_sk(v_var,v_new_mapping_id), 
                    value, cond_type
                    from conditions c join variables v on (c.variable = v.id)
                    where v.mapping = v_map
                        and c.variable = skolem.variables_from_variables_sk(v_var,v_map);
                
                v_var_pos := v_var_pos + 1;
        end loop;
        
        -- We update the description of the generated mapping
        mappings_utils.update_description(v_new_mapping_id);
        
        -- Mappings that generate the same fact
        -- twice (and miss some other) are not allowed and should be deleted
        -- Basically, the following query eliminates the mappings
        -- generated by the combination of multiple
        -- equality conditions that assign the same value
        -- twice.
        delete from mappings 
        where id in (
            select mapping from (
            select m.id mapping, a.name atom, va.position, va2.position given_pos, va2.variable given_variable, c.value, count(*)
            from
                mappings m join mapping_sets ms on (m.id = ms.mapping)
                join variables v on (v.mapping = m.id)
                join variables_atoms va on (va.variable = v.id)
                join atoms a on (va.atom = a.id)
                join conditions c on (c.variable = v.id and c.cond_type = 'EQ')
                join variables_atoms va2 on (va2.atom = va.atom and va2.variable <> va.variable)
                
            where ms.id = v_mapping_sets_id
            and m.type = 'H' -- shuffled
            group by m.id, a.name, va.position, va2.position, va2.variable, c.value
            having count(*)>1)
        );
        
        -- if there are shuffled mappings without any equality condition
        -- or without any equality condition, then they must be deleted
        -- as already present.
        delete from mappings where id in (
        select m.id
            from mappings m join mapping_sets ms on (m.id = ms.mapping)
            where ms.id = v_mapping_sets_id 
            and m.type = 'H'
            and (
                (not exists ( -- there are no equality conditions
                    select *
                    from conditions c join variables v on (c.variable = v.id)
                    where c.variable = v.id
                    and c.cond_type = 'EQ'
                    and v.mapping = m.id
                )) or
                (not exists ( -- there are no inequality conditions
                select *
                from conditions c join variables v on (c.variable = v.id)
                where c.variable = v.id
                and c.cond_type = 'NEQ'
                and v.mapping = m.id
                )))
            );
                
    end loop;
    
    close cur_shuffling;
end SHUFFLE_MAPPING_SET;


procedure GET_REPAIRED_TEMPLATE_MAPPINGS (v_mapping_id in varchar2, v_mapping_set_id out varchar2) as

    v_source_eschema varchar2(20);
    v_target_eschema varchar2(20);
    
    v_h_var_id varchar2(20);
    v_h_val varchar2(20);
    v_h_id varchar2(20);
    v_h_id_old varchar2(20);
    
    v_mapping_set varchar2(20);
    v_new_pos_mapping_id varchar2(20);
    v_new_neg_mapping_id varchar2(20);
    
    v_path varchar2(1000);
    v_var_val varchar2(200);
    v_var varchar2(20);
    v_val varchar2(20);
    
    v_var_pos integer;

    cursor cur_homo is
    select id, variable, value from homomorphisms
    order by id, variable;
        
    cursor cur_neg_homo is
        -- We individuate the assignments in the
        -- homomorphsism in the LHS
        -- that are are incompatible with
        -- all the assignments of any homomorphism in the RHS
        -- These assignments must be excluded in the negative repairs.
        select distinct variable, value
        from homomorphisms h1
        where
            h1.LHS_RHS = 'LHS'
        and exists ( -- the variable appears in the RHS
            select * 
            from variables_atoms va join atoms a on (va.atom = a.id)
            where 
                a.LHS_RHS = 'RHS'
                and va.variable = h1.variable
                and a.mapping = v_mapping_id
        )                
        and not exists ( -- a compatible assignment does not exist in any homomorphism
            select *
            from homomorphisms h2
            where h2.LHS_RHS = 'RHS'
            and h1.variable = h2.variable
            and h1.value = h2.value);
            
        cursor cur_pos_homo is
        -- We individuate all the assignments in the homomorphism
        -- in the LHS that are compatible with all the assignments
        -- of any homomorphism in the RHS and
        -- for which there exists
        -- another possible assignment in some homomorphism in the LHS, 
        -- for the same variable,
        -- that is incompatible with all the assignments in the RHS.
        -- The right assignments must be forced with conditions.
        -- Notice that the homomorphisms are injective on variables
          with v as (            
     select distinct h1.id, variable, value
    from homomorphisms h1
    where h1.LHS_RHS = 'LHS'
    and h1.variable in ( -- assignments in the LHS of variables appearing also in the RHS
        select variable 
        from variables_atoms va join atoms a on (va.atom = a.id)
        where a.LHS_RHS = 'RHS'
    ) and  exists ( -- compatible with at least one assignments
        select *
        from homomorphisms h2
        where h2.variable = h1.variable
        and h2.value = h1.value
        and h2.LHS_RHS = 'RHS' )
                    -- but there are other assignments for the same variable
                    -- that are incompatible
    and exists (
        select *
        from homomorphisms h3
        where h3.variable = h1.variable
        and h3.id <> h1.id 
                    -- for which there are no compatible RHS 
        and not exists (
            select *
            from homomorphisms h4
            where h4.variable = h3.variable
            and h4.value = h3.value
            and h4.LHS_RHS = 'RHS'
        )
                    
    ) -- and exclude the incompatible homomorphisms
       ), tree as ( select id, sys_connect_by_path(variable ||':'||value, '/') as PATH, LEVEL
       from v
       connect by nocycle 
            (prior variable < variable and prior id = id) -- don't assign the same variable twice
            )
       select distinct PATH from tree
       where "LEVEL" = (select max("LEVEL") from tree)
      and id not in (
            -- exclude all the homomorphisms that
            -- produce twice the same fact
                    select id from (
                    -- counts the assignment of the same value for a given atom, position, given value in a given pos
                    select distinct h2.id ,a.name, va.position, h2.value, va3.position, h3.value,  count(distinct h2.variable)
                    from homomorphisms h2 join variables_atoms va on (h2.variable = va.variable) join atoms a on (va.atom = a.id)
                    
                    left outer join homomorphisms h3 on (h2.id = h3.id and h2.variable <> h3.variable) left outer join variables_atoms va3 on (h3.variable = va3.variable) left outer join atoms a3 on (va3.atom = a3.id) 
                    where va3.position <> va.position    
                    and a3.name = a.name
                    group by h2.id ,a.name, va.position, h2.value, va3.position, h3.value
                    having count(distinct h2.variable)>1)
                );
                
    
begin
        
    -- fetch source and target eschemas
    select source_schema, target_schema into v_source_eschema, v_target_eschema
    from mappings
    where id = v_mapping_id;
    
    -- to erase the temporary table
    delete from homomorphisms;

    -- We calculate all the RHS homorphisms
    TEMPLATE_MAPPINGS_UTILS.ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id,'RHS');
    
    -- We calculate all the LHS homomorphisms
    TEMPLATE_MAPPINGS_UTILS.ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id,'LHS');
    
    -- we create the new mapping set
    select seq_mapping_sets.nextval into v_mapping_set from dual;
    
    -- %%%% POSITIVE REPAIRS %%%% --
    dbms_output.put_line('Positive repairs');
        
            
    -- for positive repairs, we create a mapping for each combination of
    -- assignments (in or)
    open cur_pos_homo;
    loop
    
        v_path := null;
        v_var_val := null;
    
        fetch cur_pos_homo into v_path;
        exit when cur_pos_homo%notfound;
            MAPPINGS_UTILS.CLONE_MAPPING(v_mapping_id, v_new_pos_mapping_id);
            
            insert into mapping_sets(id, mapping) values (v_mapping_set, v_new_pos_mapping_id);
            dbms_output.put_line('New mapping ' || v_new_pos_mapping_id || ' added to set ' || v_mapping_set);
            
            update mappings set type = 'P' where id = v_new_pos_mapping_id; -- negative repair

            
            v_var_pos := 1;
            --dbms_output.put_line('---->' || v_path);
            v_var := 'dummy';
    
            loop
                    
                select regexp_substr(v_path,'\w+:\w+',1,v_var_pos) into v_var_val from dual;
                exit when v_var_val is null;
                
                select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,1) into v_var from dual;
                select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,2) into v_val from dual;
                
                dbms_output.put_line('Variable to repair: ' || v_var);            
                insert into conditions(id, variable, value, cond_type) values
                    (seq_conditions.nextval, skolem.variables_from_variables_sk(v_var, v_new_pos_mapping_id), v_val, 'EQ');
                    dbms_output.put_line('Condition ' || skolem.variables_from_variables_sk(v_var, v_new_pos_mapping_id) || '=' || v_val || ' added.');

                v_var_pos := v_var_pos + 1;
        
            end loop;
            
        -- we update the mapping description
        MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_new_pos_mapping_id);
   
    end loop;
    close cur_pos_homo;
    
    


    -- %%%% NEGATIVE REPAIRS %%%% --
    dbms_output.put_line('Negative repairs');
        
    v_h_id_old := null;
     
    -- create a new mapping
    -- cloning the original mapping
    MAPPINGS_UTILS.CLONE_MAPPING(v_mapping_id, v_new_neg_mapping_id);
    
    update mappings set type = 'N' where id = v_new_neg_mapping_id; -- negative repair
    
    insert into mapping_sets(id, mapping) values (v_mapping_set, v_new_neg_mapping_id);
            dbms_output.put_line('New mapping ' || v_new_neg_mapping_id || ' added to set ' || v_mapping_set);
        
    open cur_neg_homo;
    loop
        fetch cur_neg_homo into v_h_var_id, v_h_val;
        exit when cur_neg_homo%notfound;

        dbms_output.put_line('Variable to repair: ' || v_h_var_id);            
                    insert into conditions(id, variable, value, cond_type) values
                        (seq_conditions.nextval, skolem.variables_from_variables_sk(v_h_var_id, v_new_neg_mapping_id), v_h_val, 'NEQ');
                        dbms_output.put_line('Condition ' || skolem.variables_from_variables_sk(v_h_var_id, v_new_neg_mapping_id) || '<>' || v_h_val || ' added.');
        
    end loop;
    close cur_neg_homo;
        
    -- we update the mapping description
    MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_new_neg_mapping_id);
    
    -- We now do the shuffling so as to generate all the possible combinations
    -- of conditions
    commit; -- Commit since there seems to be an Oracle bug, double-reading transactions when WITH is used (like in the suffle).
    dbms_output.put_line('Shuffling');
    SHUFFLE_MAPPING_SET(v_mapping_set);
    
end GET_REPAIRED_TEMPLATE_MAPPINGS;



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
        and a.mapping=v_mapping_id
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
