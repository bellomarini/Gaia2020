--------------------------------------------------------
--  File created - Saturday-February-27-2016   
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


procedure ALL_POSSIBLE_HOMOMORPHISMS(v_mapping_id in varchar2, XHS in varchar2) as
    path varchar2(200);
    var varchar2(20);
    val varchar2(20);
    var_val varchar2(20);
    var_pos integer := 0;
    v_id_homo varchar2(20);
    
    v_eschema varchar2(20);
    
cursor cur_homo is
           -- each row is a string "var:val/var:val/var:val .... "
           -- each row is a distinct assignment of variables
           -- not all teh combinations are possible
           -- and must be discarded
                with var_val as (
                 select distinct pv.value, va.variable
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
    if XHS = 'RHS' then
        select target_schema into v_eschema
        from mappings where id = v_mapping_id;
    elsif XHS = 'LHS' then
        select source_schema into v_eschema
        from mappings where id = v_mapping_id;
    end if;
    
    -- calculates all the atomic homomorphisms
    POPULATE_POSSIBLE_VALUES(v_eschema);
    
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
        
    
end ALL_POSSIBLE_HOMOMORPHISMS;


END TEMPLATE_MAPPINGS_UTILS;

/
