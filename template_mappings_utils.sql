--------------------------------------------------------
--  File created - Friday-June-10-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body TEMPLATE_MAPPINGS_UTILS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."TEMPLATE_MAPPINGS_UTILS" AS

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

function mapping_specificity(v_mapping_id in varchar2, v_XHS in varchar2, v_eschema in varchar2) return number as

    v_cnt integer; -- the number of homomorphisms;
    v_specificity number; -- the affinity between the mapping and the eschema
    v_lac boolean := true;
    
begin
    delete from homomorphisms;
    -- we generate all the possible
    -- homomorphisms from the XHS of the mapping of
    -- interest to the e_schema
    TEMPLATE_MAPPINGS_UTILS.all_possible_homomorphisms(v_mapping_id, v_XHS, v_eschema, v_lac);
    
    select count(distinct id) into v_cnt 
    from homomorphisms;
    
    -- the affinity
    -- is the inverse of the number of homomorphisms
    -- 
    if v_cnt = 0 then
        v_specificity := 0;
    else
        v_specificity := 1/v_cnt;
    end if;
    
    return v_specificity;
    
end mapping_specificity;

procedure ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id in varchar2, XHS in varchar2, v_chosen_eschema in varchar2 := null, lac_optimize boolean default false) as
    path varchar2(200);
    var varchar2(20);
    val varchar2(20);
    var_val varchar2(40);
    var_pos integer := 0;
    v_id_homo varchar2(30);
    
    v_eschema varchar2(20);
        
cursor cur_homo is
           -- each row is a string "var:val/var:val/var:val .... "
           -- each row is a distinct assignment of variables
           -- not all the combinations are possible
           -- and must be discarded
                with var_val as (
                 select distinct pv.value, va.variable
                    from possible_values pv, atoms a, variables_atoms va, variables_atoms g_va, atoms g_a
                    where 
                        a.name = pv.atom_name
                    and va.atom = a.id    
                    and pv.position = va.position
                    and a.mapping = v_mapping_id
                    and a.LHS_RHS = XHS
                    
                    and g_a.name = pv.atom_name
                    and g_va.atom = g_a.id
                    and (g_va.position = pv.given_pos or pv.given_pos is null)
                    and g_a.mapping = v_mapping_id                    
                    and (g_a.LHS_RHS = XHS or pv.given_pos is null)
                    
                    and not exists ( -- exclude the equal values that are forbidden by the inequalities
                        select * 
                        from conditions c
                        where c.variable = va.variable
                        and c.cond_type = 'NEQ'
                        and c.value = pv.value
                    ) -- exclude the different values that are forbidden by the equalities
                    and not exists (
                        select *
                        from conditions c
                        where c.variable = va.variable
                        and c.cond_type = 'EQ'
                        and c.value <> pv.value
                    ) 
        ), tree as ( select distinct sys_connect_by_path(variable||':'||value,'/') as PATH, LEVEL
            from var_val
            where connect_by_isleaf = 1
            connect by nocycle (prior variable < variable) 
        )
            select distinct PATH 
            from tree
            where "LEVEL" = (select max("LEVEL") from tree);
    
begin

    -- invokes POPULATE_POSSIBLE_VALUES
    if v_chosen_eschema is null or v_chosen_eschema = '' then
        if XHS = 'RHS' then
            select target_schema into v_eschema
            from mappings where id = v_mapping_id;
        elsif XHS = 'LHS' then
            select source_schema into v_eschema
            from mappings where id = v_mapping_id;
        end if;
    else
        v_eschema := v_chosen_eschema;
    end if;
    
    -- calculates all the atomic homomorphisms
    --LOG_UTILS.log_me('Generating the possible values for eschema ' || v_eschema);
    POPULATE_POSSIBLE_VALUES(v_eschema);
    
    --LOG_UTILS.log_me('Generating the homomorphisms');

    open cur_homo;
    loop
    fetch cur_homo into path;
    exit when cur_homo%notfound;
        --dbms_output.put_line('raw homo: ' || path);
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
    
        -- all the pairs of different variables of the same
        -- homomorphism that occur in the same atom
        -- must be possible values.
        -- The other homomorphisms are deleted.
        -- By definition of homomorphism
        
        delete from homomorphisms where id in (
           select distinct h1.id
            from homomorphisms h1 join homomorphisms h2 on (h1.id = h2.id and h1.variable < h2.variable)
            join variables_atoms va1 on (h1.variable = va1.variable) 
            join variables_atoms va2 on (h2.variable = va2.variable and va1.atom = va2.atom)
            join atoms a1 on (va1.atom = a1.id) join atoms a2 on (va2.atom = a2.id)
            where a1.LHS_RHS = XHS and a2.LHS_RHS = XHS
            and not exists (
                select *
                from possible_values pv
                where pv.atom_name = a1.name
                and pv.value = h1.value
                and pv.position = va1.position
                and pv.given_pos = va2.position
                and pv.given_value = h2.value)
        );
        
        -- LAC optimization
        -- for all the pairs of ambiguous variables there
        -- must hold an order constraint (<=)
        -- delete all the others
        
        if lac_optimize and XHS = 'LHS' then
            --LOG_UTILS.log_me('LAC optimization');
            declare
                v_cnt integer := 0;
            begin
                select count(distinct id) into v_cnt 
                from homomorphisms where LHS_RHS = 'LHS';
                --LOG_UTILS.log_me('LHS homomorphisms before optimization: ' || v_cnt);
            end;
            
            delete from homomorphisms where id in (
            select distinct h1.id
                
                from homomorphisms h1 join homomorphisms h2 on (h1.id = h2.id and h1.variable <> h2.variable)
                join variables_atoms va1 on (h1.variable = va1.variable) -- pairs of variable, values 
                join variables_atoms va2 on (h2.variable = va2.variable)
                join variables_atoms va11 on (va11.atom = va1.atom and va11.position <> va1.position) -- with the respective given variables
                join variables_atoms va21 on (va21.atom = va2.atom and va21.position <> va2.position)
                
                join atoms a1 on (va1.atom = a1.id) join atoms a2 on (va2.atom = a2.id) -- on the same atom
                -- there is a condition
                join conditions c on (c.variable = h1.variable and c.value = h2.variable and c.cond_type = 'LAC_LE')
    
                where 
                    a1.LHS_RHS = 'LHS' and a2.LHS_RHS = 'LHS' -- both in the LHS
                    and a1.name = a2.name -- same atom name
                    and a1.id <> a2.id -- but different specific atoms
                    and va11.variable = va21.variable -- same given variable
                    and va1.position = va2.position -- same position
                    and h1.value >= h2.value -- wrong relation between values
            );
        end if;
        
        declare
            v_cnt integer := 0;
        begin
            select count(distinct id) into v_cnt 
            from homomorphisms where LHS_RHS = 'LHS';
            --LOG_UTILS.log_me('Total number of homomorphisms: ' || v_cnt);
        end;
       
end ALL_POSSIBLE_HOMOMORPHISMS;

function EXTENSION_TEST_STR(v_mapping_id1 in varchar2, v_mapping_id2 varchar2) return varchar2 as
    begin
        if EXTENSION_TEST(v_mapping_id1, v_mapping_id2) then
            return 'Y';
        else   
            return 'N';
        end if;
end EXTENSION_TEST_STR;


function EXTENSION_TEST(v_mapping_id1 in varchar2, v_mapping_id2 varchar2) return boolean as

    v_source_eschema1 varchar2(20);
    v_target_eschema1 varchar2(20);
    
    v_missing_tuples integer := 0;
    v_incorrect_tuples integer := 0;
    
    v_outcome boolean;
    
    
   
   -- it builds a table evaluating
   -- the correctness and the completeness
   -- of the facts that would be calculated
    cursor cur_eval_results is
            with P as (
            select 
            distinct a.id as atom_id, a.name as atom_name, va.position, h.value
            from atoms a join variables_atoms va on (a.id = va.atom) left outer join homomorphisms h on (va.variable = h.variable)
            where a.mapping = v_mapping_id2
            and a.LHS_RHS = 'RHS'
            and (h.LHS_RHS = 'LHS' or h.LHS_RHS is null)
        ), PV as (
            select atom_name, to_number(position) as position, value, to_number(given_pos) as given_pos, given_value
            from possible_values
        )
        Select 
            case when atom_name is not null and r_atom_name is null then 'N' else 'Y' end as CORR,
            case when atom_name is null and r_atom_name is not null then 'N' else 'Y' end as COMPL,
            R.*
            from 
        (
            select CF.ATOM_NAME, CF.POSITION, CF.VALUE, CF.GIVEN_POS, CF.GIVEN_VALUE, 
            RF.ATOM_NAME R_ATOM_NAME, RF.POSITION R_POSITION, RF.VALUE R_VALUE, RF.GIVEN_POS R_GIVEN_POS, 
            RF.GIVEN_VALUE R_GIVEN_VALUE from (
            -- calculated facts
                select p1.atom_name, to_number(p1.position) as position, p1.value, to_number(p2.position) given_pos, p2.value given_value 
                from P p1 left outer join P p2 on (p1.atom_id = p2.atom_id and p1.position <> p2.position)
            ) CF full outer join
                -- real facts
                (select * from PV) RF
                on ( (CF.ATOM_NAME = RF.ATOM_NAME)
                and (CF.position = RF.position)
                and (nvl(nvl(cf.value,rf.value),'X') = nvl(rf.value,'X'))
                and (nvl(nvl(cf.given_pos,rf.given_pos),0) = nvl(rf.given_pos,0))
                and (nvl(nvl(cf.given_value,rf.given_value),'X') = nvl(rf.given_value,'X') )
                )
        ) R;
    
        v_cur_eval_results cur_eval_results%ROWTYPE;

    
    
    
begin
    
    
    -- we read the source e-schema of the first template mapping
    select source_schema into v_source_eschema1
    from mappings
    where id = v_mapping_id1;
    
    -- we read the target e-schema of the second template mapping
    select target_schema into v_target_eschema1
    from mappings
    where id = v_mapping_id1;
    
    delete from homomorphisms;
    
    -- we calculate all the possible homomorphisms h for the LHS of the second 
    -- template mapping to the source e-schema of the first
    -- h : LHS2 -> source_eschema1
    all_possible_homomorphisms(v_mapping_id2, 'LHS', v_source_eschema1);
    
    -- we calculate the the facts generated by all of these homomorphisms
    -- and verify that they exactly coincide with the possible values
    -- (which we calculate)
    
    populate_possible_values(v_target_eschema1);
    
    open cur_eval_results;
    loop
    fetch cur_eval_results into v_cur_eval_results;
    exit when cur_eval_results%notfound;
        if v_cur_eval_results.corr = 'N' then
            v_incorrect_tuples := v_incorrect_tuples + 1;
            --dbms_output.put_line('Incorrect generated tuple: ' || v_cur_eval_results.atom_name || ',' || v_cur_eval_results.position  || ',' ||  v_cur_eval_results.value  || ',' ||  v_cur_eval_results.given_pos  || ',' ||  v_cur_eval_results.given_value
            --            || v_cur_eval_results.r_atom_name || ',' || v_cur_eval_results.r_position  || ',' ||  v_cur_eval_results.r_value  || ',' ||  v_cur_eval_results.r_given_pos  || ',' ||  v_cur_eval_results.r_given_value);
            
        elsif v_cur_eval_results.compl = 'N' then
            v_missing_tuples := v_missing_tuples + 1;
            --dbms_output.put_line('Missing tuple: ' || v_cur_eval_results.atom_name || ',' || v_cur_eval_results.position  || ',' ||  v_cur_eval_results.value  || ',' ||  v_cur_eval_results.given_pos  || ',' ||  v_cur_eval_results.given_value
              --                      || v_cur_eval_results.r_atom_name || ',' || v_cur_eval_results.r_position  || ',' ||  v_cur_eval_results.r_value  || ',' ||  v_cur_eval_results.r_given_pos  || ',' ||  v_cur_eval_results.r_given_value);       
        end if;
    end loop;
    
    v_outcome := true;
    
    if v_missing_tuples > 0 then
        dbms_output.put_line('Template mapping ' || v_mapping_id1 || ' does not extend to ' || v_mapping_id2 || ' because the latter does not produce some needed tuples.');
        v_outcome := false;
    end if;
    if v_incorrect_tuples > 0 then
        dbms_output.put_line('Template mapping ' || v_mapping_id1 || ' does not extend to ' || v_mapping_id2 || ' because the latter produces some undesired tuples.');
        v_outcome := false;
    end if;
    
    if v_outcome then
                dbms_output.put_line('Template mapping ' || v_mapping_id1 || ' extends to ' || v_mapping_id2 || '.');
    end if;
    
    return v_outcome;
    
end extension_test;

procedure MERGE_TEMPLATE_MAPPINGS(v_mapping_id1 in varchar2, v_mapping_id2 in varchar2, v_mapping_sets_id out varchar2) as
    
    v_tm1_to_tm2 boolean := false;
    v_tm2_to_tm1 boolean := false;
    
    v_new_mapping_id varchar2(20);
    
begin
    
    -- we verify which of the two extends to the other
    v_tm1_to_tm2 := extension_test(v_mapping_id1,v_mapping_id2);
    v_tm2_to_tm1 := extension_test(v_mapping_id2,v_mapping_id1);
    
    -- if none extends to the other, then return null
    if not v_tm1_to_tm2 and not v_tm2_to_tm1 then
        v_mapping_sets_id := null;
    else
        -- create a mapping set
        select seq_mapping_sets.nextval into v_mapping_sets_id from dual;
    
        if v_tm1_to_tm2 then
            dbms_output.put_line(v_mapping_id1 || ' extends to ' || v_mapping_id2);
            -- tm2 must be in the set, then clone it
            mappings_utils.clone_mapping(v_mapping_id2, v_new_mapping_id);
            -- and insert in the set
            insert into mapping_sets(id, mapping) values (v_mapping_sets_id, v_new_mapping_id);
        end if;
        
        if v_tm2_to_tm1 then
            dbms_output.put_line(v_mapping_id2 || ' extends to ' || v_mapping_id1);
            -- tm1 must be in the set, then clone it
            mappings_utils.clone_mapping(v_mapping_id1, v_new_mapping_id);
            -- and insert in the set
            insert into mapping_sets(id, mapping) values (v_mapping_sets_id, v_new_mapping_id);
        end if;
    
    end if;
    
end MERGE_TEMPLATE_MAPPINGS;




END TEMPLATE_MAPPINGS_UTILS;

/
