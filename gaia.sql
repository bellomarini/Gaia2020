--------------------------------------------------------
--  File created - Saturday-February-20-2016   
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

-- It takes as input the id of a template mapping, the specification of the fact it is LHS_RHS
-- a populated POSSIBLE_VALUES table and populates relation HOMOMORPHISMS
-- with all the possible homomorphism from the XHS to the values
procedure ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id in varchar2, XHS in varchar2) as
    path varchar2(200);
    var varchar2(20);
    val varchar2(20);
    var_val varchar2(20);
    var_pos integer := 0;
    v_id_homo varchar2(20);
    
cursor cur_homo is
   -- each row is a string "| var:val/var:val/var:val | .... "
    select sys_connect_by_path(PATH,'|') as homo
    from (
    select PATH, ROOT
    from (
    select A.*, sys_connect_by_path(a.variable||':'||a.value,'/') as path, connect_by_isleaf as is_leaf, connect_by_root (variable) as root 
    from (
        select pv.*, va.variable, nullif(g_va.variable,va.variable) as GIVEN_VARIABLE
        from possible_values pv, variables_atoms va, atoms a,
                                 variables_atoms g_va, atoms g_a
        where va.atom = a.id
        and a.mapping = v_mapping_id
        and a.name = pv.atom_name
        and pv.position = va.position
        and a.LHS_RHS = XHS
        and g_va.atom = a.id
        and g_va.atom = g_a.id
        and g_a.mapping = v_mapping_id
        and g_a.name = pv.atom_name
        and (g_va.position = pv.given_pos or pv.given_pos is null)
        and (g_a.LHS_RHS = XHS or pv.given_pos is null)
    ) A
        where connect_by_isleaf = 1
        connect by nocycle (prior variable = given_variable and prior value = given_value)
        start with (a.atom_name = 'RELATION')
    ) )
    where connect_by_isleaf = 1
    connect by nocycle (prior root <> root);
    -- Each tuple in the result set of the inner query 
    -- is a coherent assignment of the variables of a set of atoms
    -- with some variables in common. 
    -- Tuples with the same ROOT represent alternative assignments for lists of related variables
    -- Tuples with different ROOT represent assignments for non-related variables
    -- Pick any set of tuples covering all the distinct ROOTS.
    -- For each set of tuples produce one mapping by assigning the corresponding variables.

begin
        
    open cur_homo;
    loop
    fetch cur_homo into path;
    exit when cur_homo%notfound;
        var_pos := 1;
            select seq_homomorphisms.nextval into v_id_homo from dual;
        loop
            select regexp_substr(path,'\w+:\w+',1,var_pos) into var_val from dual;
            exit when var_val is null;
                select regexp_substr(var_val,'(\w+)\:(\w+)',1,1,null,1) into var from dual;
                select regexp_substr(var_val,'(\w+)\:(\w+)',1,1,null,2) into val from dual;
                insert into homomorphisms(id, variable, value,LHS_RHS) values (v_id_homo, var, val, XHS);
            var_pos := var_pos + 1;
        end loop;
    
    var_pos := var_pos + 1;
    end loop;
    
    close cur_homo;

end ALL_POSSIBLE_HOMOMORPHISMS;


-- It populates the relation POSSIBLE_VALUES with all the
-- possible assignments for a given eschema. In other words, it calculates
-- all the possible homomorphisms for each attribute of the eschema.
procedure POPULATE_POSSIBLE_VALUES(v_target_eschema in varchar2) as
begin

-- table of the possible values
    -- for the atoms of an eschema
    delete from possible_values;
    insert into possible_values (atom_name, position, value, given_pos, given_value)
    select * from (
        select 'RELATION' as NAME, 1 as POSITION, r.name as "VALUE", null as GIVEN_POS, null as GIVEN_VALUE
        from relations r
        where r.eschema = v_target_eschema -- target e-schema
        union
        select 'ATTRIBUTE' as NAME, 1 as POSITION, att.name as "VALUE", '2' as GIVEN_POS, r.name as GIVEN_VALUE
        from attributes att join relations r on (att.relation = r.id)
        where r.eschema = v_target_eschema
        union
        select 'ATTRIBUTE' as NAME, 2 as POSITION, r.name as "VALUE", '1' as GIVEN_POS, att.name as GIVEN_VALUE
        from attributes att join relations r on (att.relation = r.id)
        where r.eschema = v_target_eschema
        union
        select 'KEY' as NAME, 1 as "POSITION", k.name as "VALUE", '2' as GIVEN_POS, r.name as GIVEN_VALUE
        from keys k join relations r on (k.relation = r.id)
        where r.eschema = v_target_eschema
        union
        select 'KEY' as NAME, 2 as "POSITION", r.name as "VALUE", '1' as GIVEN_POS, k.name as GIVEN_VALUE
        from keys k join relations r on (k.relation = r.id)
        where r.eschema = v_target_eschema
        union
        select 'FKEY' as NAME, 1 as "POSITION", att.name as "VALUE", '2' as GIVEN_POS, r1.name as GIVEN_VALUE
        from fkeys fk join attributes att on (fk.from_column = att.id) join relations r on (r.id = att.relation)
                join relations r1 on (r1.id = fk.to_relation)
        where r.eschema = v_target_eschema
        union 
        select 'FKEY' as NAME, 2 as "POSITION", r1.name as "VALUE",  '1' as GIVEN_POS, att.name as GIVEN_VALUE
        from fkeys fk join attributes att on (fk.from_column = att.id) join relations r on (r.id = att.relation)
            join relations r1 on (r1.id = fk.to_relation)
        where r.eschema = v_target_eschema
    ) POSSIBLE_VALUES;


end POPULATE_POSSIBLE_VALUES;


procedure GET_REPAIRED_TEMPLATE_MAPPINGS (v_mapping_id in varchar2, v_mapping_set_id out varchar2) as

    v_var_id varchar2(20);
    v_atom_id varchar2(20);
    v_atom_name varchar2(20);
    
    v_source_eschema varchar2(20);
    v_target_eschema varchar2(20);
    
    v_h_var_id varchar2(20);
    v_h_val varchar2(20);
    v_h_id varchar2(20);
    v_h_id_old varchar2(20);
    
    v_mapping_set varchar2(20);
    v_new_mapping_id varchar2(20);

    -- find the ambiguous variables in the LHS that are used differently
    -- in the RHS.
    -- find the ambiguous variables that are used in RHS such that
    -- there are other ambiguous variables of the same LHS
    -- atom that are not used in the RHS
    -- or are used differently, that is:
    -- a. used  in non-homonym atoms
    -- b. used  in homonym atoms but in different positions
    -- c. used  in homonym atoms, in the same position, but those atoms have some non-common variables
cursor cur_ambiguous_variables is
    select av.variable, a.id as atom_id, a.name as atom_name 
    from ambiguous_variables av -- ambiguous variables that are used also in RHS
        join variables_atoms va on (va.variable = av.variable) 
        join atoms a on (va.atom = a.id and a.LHS_RHS='RHS')
    
    where (exists ( -- with some other variables of the same atom not used in RHS
        select * 
        from ambiguous_variables av1
        where av.atom_name = av1.atom_name
        and av.variable <> av1.variable
        and not exists ( -- not used in the RHS
            select *
            from variables_atoms va1 join atoms a1 on (va1.atom = a1.id)
            where va1.variable = av1.variable
            and a1.LHS_RHS='RHS'
        )
        )
        or exists ( -- or there is some ambiguous variable of the same LHS atom used
                    -- in a different atom at RHS, or at a different position
                    select * 
            from ambiguous_variables av1 join variables_atoms va1 on (av1.variable = va1.variable)
            where av.atom_name = av1.atom_name
            and av.variable <> av1.variable
            and exists (
                select *
                from variables_atoms va2 join atoms a2 on (va2.atom = a2.id)
                where va2.variable = av1.variable
                and a2.LHS_RHS='RHS'
                and (a2.name <> av1.atom_name or va2.position <> va1.position)
            
            )      
            ) -- or there is some ambiguous variable of the same LHS atom used
              -- in a homonym attribute, at the right position in the RHS, but the two
              -- atoms have some non-common variables
        or exists (
        select * 
            from ambiguous_variables av1 join variables_atoms va1 on (av1.variable = va1.variable)
            where av.atom_name = av1.atom_name
            and av.variable <> av1.variable
            and exists (
                select *
                from variables_atoms va2 join atoms a2 on (va2.atom = a2.id)
                where va2.variable = av1.variable
                and a2.LHS_RHS='RHS'
                and a2.name = av1.atom_name 
                and va2.position = va1.position
                and exists (
                    select *
                    from variables_atoms va3 join atoms a3 on (a3.id = va3.atom)
                    where a3.name = a2.name
                    and a3.LHS_RHS='RHS'
                    and va3.variable <> va2.variable
                )
            )      
        )    
    );
    
    cursor cur_homo is
    select id, variable, value from homomorphisms
    order by id, variable;
    
    cursor cur_neg_homo is
        -- We individuate the assignments in the
        -- homomorphsism in the LHS
        -- that are are incompatible with
        -- all the assignments of any homomorphism in the RHS
        select id, variable, value
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

begin

    -- if in the LHS there are two atoms A(x,y,...), A(z,k,...) with the same name
    -- and with variables in common only with the same atoms (i.e. the same join conditions) or with no common variables    
    -- and some of their variables also appear in the RHS
    
    -- find the ambiguous variables, that is,
    -- all the non-common variables
    -- of homonym atoms that are linked (joined) exactly to the same set
    -- of atoms by common variables
    -- in the LHS
    delete from ambiguous_variables;
    insert into ambiguous_variables (VARIABLE, ATOM, ATOM_NAME)
    select distinct v.id as VARIABLE, a1.id as ATOM, a1.name as ATOM_NAME
    from 
         atoms a1 
            join atoms a2 on (a1.name = a2.name and a1.id<>a2.id and a1.mapping = a2.mapping)
            join variables_atoms va on (va.atom = a1.id)
            join variables v on (v.id = va.variable)
    where 
        a1.mapping=v_mapping_id
        and a1.LHS_RHS='LHS'
        and a1.LHS_RHS = a2.LHS_RHS
    -- and then exclude those connected to different atoms
    -- by different variables
        and not exists (
            select *
            from variables_atoms va1,  variables_atoms va2,
                 variables_atoms va11, variables_atoms va22,
                 atoms a11, atoms a22
            where 
                va1.atom = a1.id
            and va2.atom = a2.id
            and va1.variable <> va2.variable
            and va11.variable = va1.variable
            and va11.position = va1.position
            and va22.variable = va2.variable
            and va22.position = va22.position
            and va11.atom <> va22.atom
            and va11.atom <> va1.atom
            and va22.atom <> va2.atom
            and va11.atom <> va2.atom
            and va22.atom <> va1.atom
            and a11.id = va11.atom
            and a22.id = va22.atom
            and a11.LHS_RHS = a22.LHS_RHS
            and a11.LHS_RHS = a1.LHS_RHS
        ) and not exists ( -- for the non-common variables
            select *
            from variables_atoms va222
            where va222.atom = a2.id
            and va222.variable = va.variable
            and va222.position = va.position
        );
        
    -- fetch source and target eschemas
    select source_schema, target_schema into v_source_eschema, v_target_eschema
    from mappings
    where id = v_mapping_id;
    
    -- to erase the temporary table
    delete from homomorphisms;

    -- %%%% POSITIVE REPAIRS %%%% --
    dbms_output.put_line('Positive repairs');

    -- calculates all the possible assignments for all
    -- the atoms of a given e-schema
    POPULATE_POSSIBLE_VALUES(v_target_eschema);
    -- calculates all possible homomorphism
    ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id,'RHS');
    
    
    -- we create the new mapping set
    select seq_mapping_sets.nextval into v_mapping_set from dual;
    v_h_id_old := null;
    
    open cur_homo;
    loop
        fetch cur_homo into v_h_id, v_h_var_id, v_h_val;
        exit when cur_homo%notfound;
        
        -- if homomorphism has changed, create a new mapping
        if v_h_id_old is null or v_h_id <> v_h_id_old then
            -- for each homomorphism it clones the original mapping
            MAPPINGS_UTILS.CLONE_MAPPING(v_mapping_id,v_new_mapping_id);
            insert into mapping_sets(id, mapping) values (v_mapping_set, v_new_mapping_id);
            dbms_output.put_line('New mapping ' || v_new_mapping_id || ' added to set ' || v_mapping_set);
        end if;
        
        -- loops over all the ambiguous
        -- variables and if we find the current one, it
        -- saves the condition
            open cur_ambiguous_variables;
            loop
                fetch cur_ambiguous_variables into v_var_id, v_atom_id, v_atom_name;
                exit when cur_ambiguous_variables%notfound;
                -- if it finds the variable to repair
                if v_var_id = v_h_var_id then
                    dbms_output.put_line('Variable to repair: ' || v_var_id || ' in atom ' || v_atom_name);            
                    insert into conditions(id, variable, value, cond_type) values
                        (seq_conditions.nextval, skolem.variables_from_variables_sk(v_var_id, v_new_mapping_id), v_h_val, 'EQ');
                        dbms_output.put_line('Condition ' || skolem.variables_from_variables_sk(v_var_id, v_new_mapping_id) || '=' || v_h_val || ' added.');
                end if;
            end loop;
            close cur_ambiguous_variables;
        
        MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_new_mapping_id);

        v_h_id_old := v_h_id;
    end loop;
    close cur_homo;
    
    -- TODO: negative repairs and 
    -- positive repairs now are first considered separately
    -- but then are combined for different ambiguous variables
    -- with a shuffling of the mapping_set
    
    -- %%%% NEGATIVE REPAIRS %%%% --
    dbms_output.put_line('Negative repairs');
        
    -- We calculate all the LHS homomorphisms
    POPULATE_POSSIBLE_VALUES(v_source_eschema);
    ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id,'LHS');

    v_h_id_old := null;
     
    -- create a new mapping
    -- cloning the original mapping
    MAPPINGS_UTILS.CLONE_MAPPING(v_mapping_id, v_new_mapping_id);
    
    insert into mapping_sets(id, mapping) values (v_mapping_set, v_new_mapping_id);
            dbms_output.put_line('New mapping ' || v_new_mapping_id || ' added to set ' || v_mapping_set);
        
    -- There is no need to use the cursors
    -- for the ambiguous variables in the negative repair,
    -- since the conditions directly derive from
    -- the fact that the homomorphism is not extensible.
    open cur_neg_homo;
    loop
        fetch cur_neg_homo into v_h_id, v_h_var_id, v_h_val;
        exit when cur_neg_homo%notfound;

        dbms_output.put_line('Variable to repair: ' || v_h_var_id || ' in atom ' || v_atom_name);            
                    insert into conditions(id, variable, value, cond_type) values
                        (seq_conditions.nextval, skolem.variables_from_variables_sk(v_h_var_id, v_new_mapping_id), v_h_val, 'NEQ');
                        dbms_output.put_line('Condition ' || skolem.variables_from_variables_sk(v_h_var_id, v_new_mapping_id) || '<>' || v_h_val || ' added.');
        
    end loop;
    close cur_neg_homo;
        
    -- we update the mapping description
    MAPPINGS_UTILS.UPDATE_DESCRIPTION(v_new_mapping_id);

        
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
