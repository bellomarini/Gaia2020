--------------------------------------------------------
--  File created - Thursday-May-12-2016   
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
        LOG_UTILS.log_me('Generated template mapping: ' || v_mapping_id);
        
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
        -- We recurse the join by finding all the variables, no matter what mapping
        -- they come from
       
            with B as (
                select A.first_variable, A.first_mapping, A.current_variable, A.current_mapping, A.conditions, mapping orig_mapping, "LEVEL"
                from 
                            (
                                select /*+ materialize */ sys_connect_by_path(original_variable ||':'||from_mapping,'/') conditions, mapping, LEVEL, 
                                connect_by_root from_mapping first_mapping, 
                                from_mapping current_mapping,
                                connect_by_root original_variable first_variable,
                                original_variable current_variable
                                from (
                                select distinct orig_var.id original_variable, var.mapping from_mapping, orig_var.mapping
                                from conditions c join variables var on (c.variable = var.id)
                                    join mappings m on (m.id = var.mapping), variables orig_var
                                where 
                                    var.mapping in (select mapping from mapping_sets where id = v_mapping_sets_id)
                                    and orig_var.mapping = m.repair_ref
                                    and c.variable = skolem.variables_from_variables_sk(orig_var.id,m.id)
                            ) 
                            where connect_by_isleaf = 1
                            connect by nocycle ( original_variable < prior original_variable)
                            order by FIRST_MAPPING, LEVEL     
                ) A
            ), C as (
                select distinct b1.CONDITIONS, b2.first_mapping, b2.first_variable
                , a.name atom, va.position, va2.position given_pos, va2.variable given_variable, c.id cond, c.cond_type, c.value
                , count(*) over (partition by b1.CONDITIONS, c.cond_type, a.name, va.position, va2.variable, c.value) number_by_value_and_cond_type -- for EQ
                , count(*) over                    (partition by b1.CONDITIONS, a.name, va.position, va2.variable, c.value) number_by_value -- number of value cross cond
                , count(distinct c.cond_type) over (partition by b1.CONDITIONS, a.name, va.position, va2.variable, c.value) number_of_cond_types_by_value -- number of conds a value appears in
                , count(distinct c.cond_type) over (partition by b1.CONDITIONS, a.name, va.position, va2.variable) number_of_cond_types_by_pos -- number of conds for a position
                
                , listagg(c.value, ',') within group (order     by b1.CONDITIONS, c.cond_type, a.name, va.position, va2.variable, c.value) 
                                              over (partition by b1.CONDITIONS, c.cond_type, a.name, va.position, va2.variable) agg_values_by_cond_type -- for NEQ
                , count(distinct c.cond_type) over (partition by b1.CONDITIONS) number_of_cond_types
                , b1.orig_mapping
                from 
                B b1 join B b2 on (
                    b1."LEVEL">=b2."LEVEL"
                    --and b1.first_variable = b2.first_variable 
                    --and b1.first_mapping = b2.first_mapping
                     and b1.conditions like '%' || b2.conditions
                     --and b1.conditions > b2.conditions
                )
                        join conditions c on (c.variable = skolem.variables_from_variables_sk(b2.first_variable,b2.first_mapping))
                        join variables_atoms va on (va.variable = b2.first_variable)
                        join atoms a on (va.atom = a.id)
                        join variables_atoms va2 on (va2.atom = va.atom and va2.variable <> va.variable)
                        
                where b1."LEVEL"=(select max("LEVEL") from B)
                and a.LHS_RHS = 'LHS'
            )
            , D AS (
                select C.*, count(distinct first_variable) over (partition by conditions, cond_type, atom, given_pos, given_variable, agg_values_by_cond_type) num_of_aggs 
                from C
                
            ) 
            select conditions, orig_mapping
            from D
            where conditions not in ( -- exclude the unwanted combinations
                select conditions
                from D
                where 
                    (number_of_cond_types = 1) -- discard the ones with only equalities or inequalities, since they are already present
                    or (number_by_value_and_cond_type > 1 and cond_type = 'EQ') -- discard the ones where a value is assigned more than once in equalities
                    or (num_of_aggs > 1 and cond_type = 'NEQ') -- discard cases where exactly the same inequality is repeated for the same positions
                    or (cond_type = 'EQ' and number_of_cond_types_by_value = 1 and number_of_cond_types_by_pos > 1) -- discard the cases where exactly the same variable is allowed by a NEQ and bound by an EQ
            );
    
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
    
    LOG_UTILS.log_me('Generating the combinations');
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
                
                --dbms_output.put_line('  Condition on the variable ' || v_var);
                --dbms_output.put_line('  From the mapping ' || v_map);
                
                -- retrieves the value and cond_type of the condition for v_var in v_map
                -- and creates the new condition
                -- finding the corresponding variables with the Skolem function
                
                -- DEBUGGING
                
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
    v_var_neg integer;

    cursor cur_homo is
    select id, variable, value from homomorphisms
    order by id, variable;
        
    cursor cur_neg_homo is
        -- we calculate the positive repairs
        -- and join them with themselves for the same variable, but different values
        -- for the unwanted "correct" combinations (mappings need
        -- not be in normal form)
        -- then we calculate the union with the unwanted homomorphisms
        
                                 -- We individuate all the ambiguities in the LHS
        -- such that they do not correspond to equivalent
        -- ambiguities in the RHS and
        -- repair, by assigning the variables with
        -- distinct values
                with LAC as (  
                    select distinct h2.id ,a.name, va.position,  h2.value, 
                                                   va3.position given_pos, 
                                                   h3.value given_value,  
                                                   h2.variable variable
                    from homomorphisms h2 
                    join variables_atoms va on (h2.variable = va.variable) join atoms a on (va.atom = a.id)
                    left outer join homomorphisms h3 on (h2.id = h3.id and h2.variable <> h3.variable) 
                    left outer join variables_atoms va3 on (h3.variable = va3.variable) 
                    left outer join atoms a3 on (va3.atom = a3.id) 
                    
                    where va3.position <> va.position    
                    and a3.name = a.name
                    and h2.LHS_RHS = 'LHS'
                    and h3.LHS_RHS = 'LHS'
                ), 
                -- atoms in the RHS
                RAC as (
                select distinct h2.id ,a.name, va.position,  h2.value, 
                                                   va3.position given_pos, 
                                                   h3.value given_value,  
                                                   h2.variable variable
                    from homomorphisms h2 
                    join variables_atoms va on (h2.variable = va.variable) join atoms a on (va.atom = a.id)
                    left outer join homomorphisms h3 on (h2.id = h3.id and h2.variable <> h3.variable) 
                    left outer join variables_atoms va3 on (h3.variable = va3.variable) 
                    left outer join atoms a3 on (va3.atom = a3.id) 
                    
                    where va3.position <> va.position    
                    and a3.name = a.name
                    and h2.LHS_RHS = 'RHS'
                    and h3.LHS_RHS = 'RHS'
                
                ), 
                -- ambiguous in the LHS, that is,
                -- they match in the LHS exactly with the same atom 
                -- and produce the same value (however here we take
                -- distinct values for repair purposes)
                -- The distinct values exist since the
                -- originating mapping is canonical
                L_PAIRS AS (
                    select distinct 
                     l1.id
                    ,l1.variable variable
                    ,l1.value value
                    ,l2.variable v2
                    ,l2.value given_value
                    from LAC l1, LAC l2
                    where l1.name = l2.name
                    and l1.position = l2.position
                    and l1.value <> l2.value
                    and l1.given_pos = l2.given_pos
                    and l1.given_value = l2.given_value
                    and l1.variable <> l2.variable
                    and l1.id = l2.id
                ),
                -- non-ambiguous in the RHS
                R_PAIRS AS (
                    select distinct 
                     r1.id
                    ,r1.variable variable
                    ,r1.value value
                    ,r2.variable v2
                    ,r2.value given_value
                    from RAC r1, RAC r2
                    where 
                    r1.variable <> r2.variable -- the two variables are distinct
                    and r1.id = r2.id -- belonging to the same homomorphism
                    and (
                        r1.name <> r2.name -- in different atoms
                        or r1.position <> r2.position -- or in in different positions
                        or r1.given_pos <> r2.given_pos -- or with different given pos (which should be like above)
                        or r1.given_value <> r2.given_value -- or with different given values
                    )
                    
                ), 
                POS as ( -- the tree of assignments
                    -- such that for the ambiguous LHS there are
                    -- extending homo ambiguous in the RHS
                    select distinct l.id, l.variable, l.value
                    from L_PAIRS l -- ambiguous LHS
                                   -- for which there are some 
                                    -- or the pair does not exist at all and just one appears
                    join R_PAIRS r on ((r.variable = l.variable and r.v2 = l.v2 and l.value = r.value and l.given_value = r.given_value) or
                                       (r.variable = l.variable and l.value = r.value))
                    connect by nocycle 
                    (prior l.variable < l.variable and prior l.id = l.id) -- don't assign the same variable twice
                )
        -- and exclude the incompatible homomorphisms
        -- We individuate the assignments in the
        -- homomorphsism in the LHS
        -- that are are incompatible with
        -- all the assignments of any homomorphism in the RHS
        -- These assignments must be excluded in the negative repairs.
               , w as (
               select id, variable, value from (
               select distinct id, variable, value, count(value) over (partition by id) as var_no from POS
                  where id not in (
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
                            ) 
                    ) Q where Q.var_no >= all ( -- only the homomorphisms assigning all the variables
                        select count(value)
                        from POS
                        group by id
                    )
                ), z as
                (
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
                    and h1.value = h2.value)
                    
                ), x as (
                
                    select w1.id, w1.variable,w2.value 
                    from w w1, w w2
                    where w1.variable=w2.variable 
                    and w1.value<>w2.value
                    union
                    select w1.id, w1.variable, z.value 
                    from w w1, z
                    where w1.variable=z.variable 
                    and w1.value<>z.value     
                    
                ), y as (
                select id, sys_connect_by_path(variable ||':'||value, '/') as PATH, LEVEL 
                from x
                connect by nocycle 
                    (prior id = id and ( (prior variable = variable and prior value < value) or (prior variable < variable) )) -- don't assign the same variable twice
                ) select distinct PATH from y where "LEVEL" =
                    (select max("LEVEL") from y);

        cursor cur_pos_homo is
        -- We individuate all the ambiguities in the LHS
        -- such that they do not correspond to equivalent
        -- ambiguities in the RHS and
        -- repair, by assigning the variables with
        -- distinct values
                                -- We individuate all the ambiguities in the LHS
        -- such that they do not correspond to equivalent
        -- ambiguities in the RHS and
        -- repair, by assigning the variables with
        -- distinct values
                with LAC as (  
                    select distinct h2.id ,a.name, va.position,  h2.value, 
                                                   va3.position given_pos, 
                                                   h3.value given_value,  
                                                   h2.variable variable
                    from homomorphisms h2 
                    join variables_atoms va on (h2.variable = va.variable) join atoms a on (va.atom = a.id)
                    left outer join homomorphisms h3 on (h2.id = h3.id and h2.variable <> h3.variable) 
                    left outer join variables_atoms va3 on (h3.variable = va3.variable) 
                    left outer join atoms a3 on (va3.atom = a3.id) 
                    
                    where va3.position <> va.position    
                    and a3.name = a.name
                    and h2.LHS_RHS = 'LHS'
                    and h3.LHS_RHS = 'LHS'
                ), 
                -- atoms in the RHS
                RAC as (
                select distinct h2.id ,a.name, va.position,  h2.value, 
                                                   va3.position given_pos, 
                                                   h3.value given_value,  
                                                   h2.variable variable
                    from homomorphisms h2 
                    join variables_atoms va on (h2.variable = va.variable) join atoms a on (va.atom = a.id)
                    left outer join homomorphisms h3 on (h2.id = h3.id and h2.variable <> h3.variable) 
                    left outer join variables_atoms va3 on (h3.variable = va3.variable) 
                    left outer join atoms a3 on (va3.atom = a3.id) 
                    
                    where va3.position <> va.position    
                    and a3.name = a.name
                    and h2.LHS_RHS = 'RHS'
                    and h3.LHS_RHS = 'RHS'
                
                ), 
                -- ambiguous in the LHS, that is,
                -- they match in the LHS exactly with the same atom 
                -- and produce the same value (however here we take
                -- distinct values for repair purposes)
                -- The distinct values exist since the
                -- originating mapping is canonical
                L_PAIRS AS (
                    select distinct 
                     l1.id
                    ,l1.variable variable
                    ,l1.value value
                    ,l2.variable v2
                    ,l2.value given_value
                    from LAC l1, LAC l2
                    where l1.name = l2.name
                    and l1.position = l2.position
                    and l1.value <> l2.value
                    and l1.given_pos = l2.given_pos
                    and l1.given_value = l2.given_value
                    and l1.variable <> l2.variable
                    and l1.id = l2.id
                ),
                -- non-ambiguous in the RHS
                R_PAIRS AS (
                    select distinct 
                     r1.id
                    ,r1.variable variable
                    ,r1.value value
                    ,r2.variable v2
                    ,r2.value given_value
                    from RAC r1, RAC r2
                    where 
                    r1.variable <> r2.variable -- the two variables are distinct
                    and r1.id = r2.id -- belonging to the same homomorphism
                    and (
                        r1.name <> r2.name -- in different atoms
                        or r1.position <> r2.position -- or in in different positions
                        or r1.given_pos <> r2.given_pos -- or with different given pos (which should be like above)
                        or r1.given_value <> r2.given_value -- or with different given values
                    )
                    
                ), 
                tree as ( -- the tree of assignments
                    -- such that for the ambiguous LHS there are
                    -- extending homo ambiguous in the RHS
                    select distinct l.id, sys_connect_by_path(l.variable ||':'||l.value, '/') as PATH, LEVEL
                    from L_PAIRS l -- ambiguous LHS
                                   -- for which there are some 
                                   -- or the pair does not exist at all and just one appears
                    join R_PAIRS r on ((r.variable = l.variable and r.v2 = l.v2 and l.value = r.value and l.given_value = r.given_value) or
                                       (r.variable = l.variable and l.value = r.value))
                    connect by nocycle 
                    (prior l.variable < l.variable and prior l.id = l.id) -- don't assign the same variable twice
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
    
    LOG_UTILS.log_me('Generating homomorphisms');

    -- We calculate all the RHS homorphisms
    LOG_UTILS.log_me('Generating homomorphisms - RHS');

    TEMPLATE_MAPPINGS_UTILS.ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id,'RHS');
    
    -- We calculate all the LHS homomorphisms
    TEMPLATE_MAPPINGS_UTILS.ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id,'LHS');
    
    LOG_UTILS.log_me('Generating homomorphisms - RHS');

    -- we create the new mapping set
    select seq_mapping_sets.nextval into v_mapping_set from dual;
    dbms_output.put_line('Generating repaired set : ' || v_mapping_set);
    LOG_UTILS.log_me('Generating repaired set : ' || v_mapping_set);
    
    -- %%%% POSITIVE REPAIRS %%%% --
    dbms_output.put_line('Positive repairs');

    LOG_UTILS.log_me('Generating positive repairs');
        
            
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
            --dbms_output.put_line('New mapping ' || v_new_pos_mapping_id || ' added to set ' || v_mapping_set);
            
            update mappings set type = 'P' where id = v_new_pos_mapping_id; -- negative repair

            
            v_var_pos := 1;
            --dbms_output.put_line('---->' || v_path);
            v_var := 'dummy';
    
            loop
                    
                select regexp_substr(v_path,'\w+:\w+',1,v_var_pos) into v_var_val from dual;
                exit when v_var_val is null;
                
                select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,1) into v_var from dual;
                select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,2) into v_val from dual;
                
                --dbms_output.put_line('Variable to repair: ' || v_var);            
                insert into conditions(id, variable, value, cond_type) values
                    (seq_conditions.nextval, skolem.variables_from_variables_sk(v_var, v_new_pos_mapping_id), v_val, 'EQ');
                    --dbms_output.put_line('Condition ' || skolem.variables_from_variables_sk(v_var, v_new_pos_mapping_id) || '=' || v_val || ' added.');

                v_var_pos := v_var_pos + 1;
        
            end loop;
            
        -- we update the mapping description
        MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_new_pos_mapping_id);
        
        -- to return the output
        v_mapping_set_id := v_mapping_set;
   
    end loop;
    close cur_pos_homo;
    
    -- %%%% NEGATIVE REPAIRS %%%% --
    dbms_output.put_line('Negative repairs');
    LOG_UTILS.log_me('Generating negative repairs');

        
    open cur_neg_homo;
        loop
    
        v_path := null;
        v_var_val := null;
    
        fetch cur_neg_homo into v_path;
        exit when cur_neg_homo%notfound;
            MAPPINGS_UTILS.CLONE_MAPPING(v_mapping_id, v_new_neg_mapping_id);
            
            insert into mapping_sets(id, mapping) values (v_mapping_set, v_new_neg_mapping_id);
            --dbms_output.put_line('New mapping ' || v_new_pos_mapping_id || ' added to set ' || v_mapping_set);
            
            update mappings set type = 'N' where id = v_new_neg_mapping_id; -- negative repair

            
            v_var_neg := 1;
            --dbms_output.put_line('---->' || v_path);
            v_var := 'dummy';
    
            loop
                    
                select regexp_substr(v_path,'\w+:\w+',1,v_var_neg) into v_var_val from dual;
                exit when v_var_val is null;
                
                select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,1) into v_var from dual;
                select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,2) into v_val from dual;
                
                --dbms_output.put_line('Variable to repair: ' || v_var);            
                insert into conditions(id, variable, value, cond_type) values
                    (seq_conditions.nextval, skolem.variables_from_variables_sk(v_var, v_new_neg_mapping_id), v_val, 'NEQ');
                    --dbms_output.put_line('Condition ' || skolem.variables_from_variables_sk(v_var, v_new_pos_mapping_id) || '=' || v_val || ' added.');

                v_var_neg := v_var_neg + 1;
        
            end loop;
            
        -- we update the mapping description
        MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_new_neg_mapping_id);
        
        -- to return the output
        v_mapping_set_id := v_mapping_set;
   
    end loop;
    close cur_neg_homo;

    -- We now do the shuffling so as to generate all the possible combinations
    
    -- of conditions
    commit; -- Commit since there seems to be an Oracle bug, double-reading transactions when WITH is used (like in the suffle).
    dbms_output.put_line('Shuffling');
    LOG_UTILS.log_me('Shuffling');
    
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


procedure MERGE_MAPPING_SETS (v_mapping_set_id1 in varchar2, v_mapping_set_id2 in varchar2, v_mapping_set_id out varchar2) as

    v_mapping_1 varchar2(20);
    v_mapping_2 varchar2(20);
    
    -- all the pairs of mappings in the first
    -- and in the second
    -- Then we iterate through them and add to the final set
    -- only the mappings (M1) such that M2 extends to M1.
    -- In this way we obtain the merged set
   cursor cur_all_pairs is 
    select m1.mapping M1, m2.mapping M2
    from mapping_sets m1, mapping_sets m2
    where m1.id = v_mapping_set_id1
    and m2.id = v_mapping_set_id2
    union
    select m2.mapping, m1.mapping
    from mapping_sets m1, mapping_sets m2
    where m1.id = v_mapping_set_id1
    and m2.id = v_mapping_set_id2;
    
    
begin

    -- mapping set id
    select seq_mapping_sets.nextval into v_mapping_set_id from dual;

    dbms_output.put_line('Merging sets ' || v_mapping_set_id1 || ' and ' || v_mapping_set_id2 || ' into set ' || v_mapping_set_id);
    LOG_UTILS.log_me('Merging sets ' || v_mapping_set_id1 || ' and ' || v_mapping_set_id2 || ' into set ' || v_mapping_set_id);

    open cur_all_pairs;
    loop    
    fetch cur_all_pairs into v_mapping_1, v_mapping_2;
    exit when cur_all_pairs%notfound;
    
    -- adds the mappings to the set when the merge condition holds
    if template_mappings_utils.extension_test(v_mapping_1, v_mapping_2) then
        begin
        insert into mapping_sets(id, mapping) values (v_mapping_set_id, v_mapping_2);
        exception 
            when DUP_VAL_ON_INDEX then
                null; -- just skip, it has already been inserted (it is a set)
        end;
        --dbms_output.put_line('Mapping ' || v_mapping_2 || ' added');
    end if;
    end loop;
    close cur_all_pairs;

    
END MERGE_MAPPING_SETS;



procedure GENERATE_VARIANTS (v_mapping_set_id in varchar2, v_new_mapping_set out varchar2) as
    
    -- we extract all the source schemas
    -- for our set of mappings
    cursor cur_source_schemas is
        select distinct source_schema
        from mappings m join mapping_sets ms on (m.id = ms.mapping)
        and ms.id = v_mapping_set_id;

    -- we extract all the template mappings
    cursor cur_all_tm is
        select distinct mapping
        from mapping_sets
        where id = v_mapping_set_id;
        
        
    -- calculate all the possible combinations of assignments
    -- at any level
    cursor cur_variants is
        select distinct sys_connect_by_path(variable ||':'||value,'/') as conditions
        from (
            -- all the fixed assignments
            -- for which there are no conditions
            select distinct variable, value
            from homomorphisms h
            where LHS_RHS = 'LHS'
            and not exists ( -- the assignment is always the same
                select *
                from homomorphisms h1
                where h.id <> h1.id
                and h.variable = h1.variable
                and h.value <> h1.value
                and LHS_RHS = 'LHS'
            ) and not exists ( -- and is not enforced by a condition
                select *
                from conditions c
                where c.variable = h.variable
            ) 
        )
        connect by nocycle (prior variable < variable);
        
    v_template_mapping varchar2(20);
    v_new_template_mapping varchar2(20);
    v_source_eschema varchar2(20);
    v_conditions varchar2(100);
    
    v_var_val varchar2(100);
    v_var varchar2(20);
    v_val varchar2(20);
    v_var_pos integer;

begin
    -- we create a new set of mappings
    select seq_mapping_sets.nextval into v_new_mapping_set from dual;
    dbms_output.put_line('Generating variants of ' || v_mapping_set_id || ' into ' || v_new_mapping_set);
    LOG_UTILS.log_me('Generating variants of ' || v_mapping_set_id || ' into ' || v_new_mapping_set);
    
    -- we copy all the original mapping into the new set
    insert into mapping_sets (id, mapping)
        select v_new_mapping_set, mapping
        from mapping_sets ms
        where ms.id = v_mapping_set_id;
    
    -- for each template, we generate the homomorhpisms from the LHS
    -- to all the possible source schemas
    open cur_all_tm;
    loop
    fetch cur_all_tm into v_template_mapping;
    exit when cur_all_tm%notfound;
    delete from homomorphisms; -- we prepare the temporary table
        --dbms_output.put_line('Generating homomorphisms for ' || v_template_mapping);
        open cur_source_schemas;
        loop
        -- we consider all the source eschema for that mapping
        fetch cur_source_schemas into v_source_eschema;
        exit when cur_source_schemas%notfound;
            -- and calculate all the possible homomorphisms
            template_mappings_utils.all_possible_homomorphisms(v_template_mapping,'LHS',v_source_eschema);
        end loop;
        close cur_source_schemas;
        
         -- now in HOMOMORPHISMS we have the union of all the homomorphisms for our
        -- template mapping
        open cur_variants;
        loop
        fetch cur_variants into v_conditions;
        exit when cur_variants%notfound;

        -- we create the new mapping by cloning the current
        mappings_utils.clone_mapping(v_template_mapping, v_new_template_mapping);
        -- and add it to the target mapping set
        insert into mapping_sets (id, mapping) values (v_new_mapping_set, v_new_template_mapping);
        
            -- now we iterate the condition and
            -- create all the variants, by cloning the original mapping,
            -- and adding the conditions.
            v_var_pos := 1;
            loop
                select regexp_substr(v_conditions,'\w+:\w+',1,v_var_pos) into v_var_val from dual;
                exit when v_var_val is null;
                    select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,1) into v_var from dual;
                    select regexp_substr(v_var_val,'(\w+)\:(\w+)',1,1,null,2) into v_val from dual;
                    
                    --dbms_output.put_line('  Condition on the variable ' || v_var || '=' || v_val);
                    
                    -- we create the appropriate condition, by finding
                    -- the target variable (the one in the cloned schema)
                    -- with the Skolem function
                    insert into conditions(id, variable, value, cond_type)
                        values(seq_conditions.nextval, 
                        skolem.variables_from_variables_sk(v_var,v_new_template_mapping), 
                        v_val, 
                        'EQ');
                        
                    v_var_pos := v_var_pos + 1;
            end loop;   
            
            -- we update the description, by considering the new conditions
            mappings_utils.update_description(v_new_template_mapping);
            update mappings set type = type || 'V' where id = v_new_template_mapping;
        end loop;
        close cur_variants;    
    end loop;
    close cur_all_tm;

end GENERATE_VARIANTS;

procedure encode(v_mapping_list in clob, v_source_schema in varchar2, v_target_schema in varchar2, v_mapping_set out varchar2, enable_second_level_variants boolean default true) as

    v_map_pos integer := 1;
    v_mapping_string varchar2(200);
    v_mapping_id varchar2(20);
    
    v_eschema1 varchar2(20);
    v_eschema2 varchar2(20);
    v_canonical_mapping_id varchar2(20);
    v_mapping_set_id varchar2(20);
    v_prev_mapping_set_id varchar2(20) := null;
    v_new_mapping_set_id varchar2(20);
    v_var_mapping_set_id varchar2(20);
    
    v_ts timestamp with time zone;
    v_overall_ts timestamp with time zone := systimestamp;
        
begin

    loop
    
    select regexp_substr(v_mapping_list,'([^;]+)',1,v_map_pos) into v_mapping_string from dual;
        exit when v_mapping_string is null;
        
        LOG_UTILS.log_me('GAIA: encoding mapping ' || v_mapping_string);
        dbms_output.put_line('GAIA: handling mapping ' || v_mapping_string);
        
        -- parse mapping
        MAPPINGS_UTILS.PARSE_MAPPING(
            V_MAPPING_STRING => v_mapping_string,
            V_MAPPING_ID => V_MAPPING_ID
        );
        
        -- generate e-schemas
        dbms_output.put_line('     GAIA: GENERATE ESCHEMAS');
        LOG_UTILS.log_me('GAIA: GENERATE ESCHEMAS');
        v_ts := systimestamp;
        GAIA.GENERATE_ESCHEMAS(v_mapping_id, v_source_schema, v_target_schema, v_eschema1, v_eschema2);
        dbms_output.put_line('Elapsed: ' || TO_CHAR(systimestamp - v_ts));
        -- generate the canonical mapping
        dbms_output.put_line('     GAIA: GENERATE THE CANONICAL TEMPLATE MAPPING');
        LOG_UTILS.log_me('GAIA: GENERATE THE CANONICAL TEMPLATE MAPPING');
        v_ts := systimestamp;
        GAIA.GET_CANONICAL_TEMPLATE_MAPPING (v_eschema1, v_eschema2, v_canonical_mapping_id);
        dbms_output.put_line('Elapsed: ' || TO_CHAR(systimestamp - v_ts));
        -- repair the generated mapping
        dbms_output.put_line('     GAIA: GENERATE THE SET OF REPAIRED CANONICAL TEMPLATE MAPPINGS');
        LOG_UTILS.log_me('GAIA: GENERATE THE SET OF REPAIRED CANONICAL TEMPLATE MAPPINGS');
        v_ts := systimestamp;
        GAIA.GET_REPAIRED_TEMPLATE_MAPPINGS (v_canonical_mapping_id, v_mapping_set_id);
        dbms_output.put_line('Elapsed: ' || TO_CHAR(systimestamp - v_ts));
        
        -- if we have generated the first mapping set,
        -- then it is the same as the previous
        if v_prev_mapping_set_id is null then
            v_prev_mapping_set_id := v_mapping_set_id;
        else -- else we merge with the previous
            v_ts := systimestamp;
            dbms_output.put_line('     GAIA: MERGING THE GENERATED SET');   
            LOG_UTILS.log_me('GAIA: MERGING THE GENERATED SET');
            merge_mapping_sets(v_prev_mapping_set_id, v_mapping_set_id, v_new_mapping_set_id);
        dbms_output.put_line('Elapsed: ' || TO_CHAR(systimestamp - v_ts));
            v_prev_mapping_set_id := v_new_mapping_set_id;
        end if;
                        
        v_map_pos := v_map_pos + 1;
    end loop;   
    
    -- then we generate all the second level variants
    -- and return its result

    if enable_second_level_variants then
        dbms_output.put_line('     GAIA: GENERATE THE SECOND-LEVEL VARIANTS');
        LOG_UTILS.log_me('GAIA: GENERATE THE SECOND-LEVEL VARIANTS');
        v_ts := current_timestamp;
        generate_variants(v_prev_mapping_set_id, v_mapping_set_id);
        dbms_output.put_line('Elapsed: ' || TO_CHAR(systimestamp - v_ts));

        v_mapping_set := v_mapping_set_id;
        
    end if;
    
    dbms_output.put_line('TOTAL Elapsed: ' || TO_CHAR(systimestamp - v_overall_ts));
    LOG_UTILS.log_me('Finished');

end encode;

END GAIA;

/
