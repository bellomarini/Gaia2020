--------------------------------------------------------
--  File created - Thursday-July-14-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body MAPPINGS_INDEX
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."MAPPINGS_INDEX" AS

  function x_rel(v_mapping_id in varchar2, v_XHS in varchar2) return number AS
    v_x_rel_num integer := 0;
  
  BEGIN
    select count(*) into v_x_rel_num from atoms 
    where mapping = v_mapping_id
    and NAME = 'RELATION'
    and LHS_RHS = v_XHS;
    
    return v_x_rel_num;

  END x_rel;
  
  
  function l_rel(v_mapping_id in varchar2) return number AS  
  BEGIN
    return x_rel(v_mapping_id, 'LHS');
  END l_rel;
  
  function r_rel(v_mapping_id in varchar2) return number AS  
  BEGIN
    return x_rel(v_mapping_id, 'RHS');
  END r_rel;


    function exist(v_mapping_id in varchar2) return number as
        v_exist integer := 0;
    begin
        select count(*) into v_exist
        from variables
        where mapping = v_mapping_id
        and quantification = 'E';
        
        return v_exist;
        
    end exist;
    
    function x_join(v_mapping_id in varchar2, v_XHS in varchar2) return number as 
     v_x_join integer := 0;
    begin
    
        select
        count(*) into v_x_join
        from (
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va.atom = a.id
            and va2.atom = va.atom
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'ATTRIBUTE' or a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) A,
        (   
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va2.atom = va.atom
            and va.atom = a.id
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'ATTRIBUTE' or a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) B
        where 
        A.variable2 < b.variable2
        and A.VARIABLE = B.VARIABLE
        and A.LHS_RHS = v_XHS
        and B.LHS_RHS = v_XHS;
        
        return v_x_join;
    end x_join;
    
    function l_join(v_mapping_id in varchar2) return number as
    begin
        return x_join(v_mapping_id, 'LHS');
    end l_join;
    
    function r_join(v_mapping_id in varchar2) return number as
    begin
        return x_join(v_mapping_id, 'RHS');
    end r_join;
    
    function x_cart(v_mapping_id in varchar2, v_XHS in varchar2) return number as
        v_x_cart integer := 0;
    begin 

    select count(*) into v_x_cart from (
    select a1.id, a2.id
    from atoms a1, atoms a2
    where a1.name = 'RELATION'
    and a2.name = 'RELATION'
    and a1.mapping = v_mapping_id
    and a2.mapping = v_mapping_id
    and a1.LHS_RHS = v_XHS
    and a2.LHS_RHS = v_XHS
    and a1.id < a2.id
    minus
     select
        A.A2, B.A2
        from (
            select va.variable, a.LHS_RHS, va2.variable variable2, va2.atom a2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va.atom = a.id
            and va2.atom = va.atom
            and (a.NAME = 'ATTRIBUTE' or a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
        ) A,
        (   
            select va.variable, a.LHS_RHS, va2.variable variable2, va2.atom a2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va2.atom = va.atom
            and va.atom = a.id
            and (a.NAME = 'ATTRIBUTE' or a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
        ) B
        where 
        A.variable2 < b.variable2
        and A.VARIABLE = B.VARIABLE
        and A.LHS_RHS = v_XHS
        and B.LHS_RHS = v_XHS);
        
        return v_x_cart;
    end x_cart;
    
    function l_cart(v_mapping_id in varchar2) return number as
    begin
        return x_cart(v_mapping_id, 'LHS');
    end l_cart;
    
    function r_cart(v_mapping_id in varchar2) return number as
    begin
        return x_cart(v_mapping_id, 'RHS');
    end r_cart;
    
    
    function x_join_fk(v_mapping_id in varchar2, v_XHS in varchar2) return number as
        v_x_join_fk integer := 0;
    begin
    
    select
        count(*) into v_x_join_fk
        from (
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va.atom = a.id
            and va2.atom = va.atom
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'ATTRIBUTE' or a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) A,
        (   
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va2.atom = va.atom
            and va.atom = a.id
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'ATTRIBUTE' or a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) B
        where 
        A.variable2 < b.variable2
        and A.VARIABLE = B.VARIABLE
        and A.LHS_RHS = 'LHS'
        and B.LHS_RHS = 'LHS'
        and exists (
            select *
            from atoms a, variables_atoms va1, variables_atoms va2
            where a.name = 'FKEY'
            and a.LHS_RHS = v_XHS
            and a.id = va1.atom
            and a.mapping = v_mapping_id
            and va1.position = 1
            and va2.position = 2
            and va1.variable = A.variable
            and (va2.variable = b.variable2 or va2.variable = a.variable2)
        );
        
        return v_x_join_fk;
    end x_join_fk;
    
    function l_join_fk(v_mapping_id in varchar2) return number as
    begin
        return x_join_fk(v_mapping_id, 'LHS');
    end l_join_fk;
    
    function r_join_fk(v_mapping_id in varchar2) return number as
    begin
        return x_join_fk(v_mapping_id, 'RHS');
    end r_join_fk;
    
    function x_join_key_to_attribute(v_mapping_id in varchar2, v_XHS in varchar2) return number as
         v_x_join_key integer := 0;
    begin
    
        select count(*) into v_x_join_key
        from (
        select * 
        from (
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va.atom = a.id
            and va2.atom = va.atom
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) A,
        (   
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va2.atom = va.atom
            and va.atom = a.id
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'ATTRIBUTE')
            and va.position = 1
            and va2.position = 2
        ) B
        where 
        A.variable2 <> b.variable2
        and A.VARIABLE = B.VARIABLE
        and A.LHS_RHS = v_XHS
        and B.LHS_RHS = v_XHS);
        
        return v_x_join_key;
    
    end x_join_key_to_attribute;
    
    function x_join_key_to_key(v_mapping_id in varchar2, v_XHS in varchar2) return number as
         v_x_join_key integer := 0;
    begin
    
        select count(*) into v_x_join_key
        from (
        select * 
        from (
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va.atom = a.id
            and va2.atom = va.atom
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) A,
        (   
            select va.variable, a.LHS_RHS, va2.variable variable2
            from atoms a, variables_atoms va, variables_atoms va2, variables_atoms va3, atoms at2
            where a.mapping = v_mapping_id
            and va2.atom = va.atom
            and va.atom = a.id
            and va3.variable = va2.variable
            and at2.id = va3.atom
            and at2.name = 'RELATION'
            and at2.LHS_RHS = v_XHS
            and (a.NAME = 'KEY')
            and va.position = 1
            and va2.position = 2
        ) B
        where 
        A.variable2 < b.variable2
        and A.VARIABLE = B.VARIABLE
        and A.LHS_RHS = v_XHS
        and B.LHS_RHS = v_XHS);
        
        return v_x_join_key;
    
    end x_join_key_to_key;
    
    function l_join_key(v_mapping_id in varchar2) return number as
    begin
        return x_join_key_to_attribute(v_mapping_id,'LHS') + x_join_key_to_key(v_mapping_id,'LHS');
    end l_join_key;
    
    function r_join_key(v_mapping_id in varchar2) return number as
    begin
        return x_join_key_to_attribute(v_mapping_id,'RHS') + x_join_key_to_key(v_mapping_id,'RHS');
    end r_join_key;
    
    function var_copied(v_mapping_id in varchar2) return number as 
        v_var_copied integer := 0;
    begin    
        select count (distinct va1.variable) into v_var_copied
        from variables_atoms va1, variables_atoms va2, atoms a1, atoms a2
        where va1.atom = a1.id
        and va2.atom = a2.id
        and a1.LHS_RHS = 'LHS'
        and a2.LHS_RHS = 'RHS'
        and va1.variable = va2.variable
        and a1.id <> a2.id
        and a1.mapping = v_mapping_id
        and a2.mapping = v_mapping_id;
    return v_var_copied;
    
    end var_copied;

    
    function index_mapping(v_mapping_id in varchar2) return number as
    begin
    
    LOG_UTILS.log_me('Indexing mapping: ' || v_mapping_id);
    
    delete from laconic_index 
    where mapping = v_mapping_id;
    
    insert into laconic_index(mapping, l_rel, r_rel, exist, l_join, r_join, l_cart, r_cart, 
        l_join_fk, r_join_fk, l_join_key, r_join_key, var_copied)
    select
     v_mapping_id,
     l_rel(v_mapping_id),
     r_rel(v_mapping_id),
     exist(v_mapping_id),
     l_join(v_mapping_id),
     r_join(v_mapping_id),
     l_cart(v_mapping_id),
     r_cart(v_mapping_id),
     l_join_fk(v_mapping_id),
     r_join_fk(v_mapping_id),
     l_join_key(v_mapping_id),
     r_join_key(v_mapping_id),
     var_copied(v_mapping_id)
     from dual;
     
     return 0;
    
    end index_mapping;
    
    function score_query(v_query_id in varchar2) return integer as
    begin
        return index_mapping(v_query_id);
    end score_query;
    
    procedure index_all_mappings as
    
        v_mapping_id varchar2(30);
        outcome integer := 0;
        
        cursor cur_lac_mappings is
        select id from mappings
        where type = 'L';
        
        begin
        open cur_lac_mappings;
        loop
        fetch cur_lac_mappings into v_mapping_id;
        exit when cur_lac_mappings%notfound;
            outcome := index_mapping(v_mapping_id);
        end loop;
        
        close cur_lac_mappings;
        
    end index_all_mappings;


END MAPPINGS_INDEX;

/
