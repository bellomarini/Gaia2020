--------------------------------------------------------
--  File created - Monday-February-08-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body GAIA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."GAIA" AS

PROCEDURE ENCODERELATION (v_relationName IN VARCHAR2, v_target_e_schema in varchar2  ) AS 

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
    
END ENCODERELATION;

PROCEDURE GETCANONICALTEMPLATEMAPPING 
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



END GETCANONICALTEMPLATEMAPPING;

procedure PARSEMAPPING(v_mapping_string in varchar2) as

atom_name varchar2(20) := 'dummy';
param_list varchar2(20) := 'dummy';
var varchar2(20) := 'dummy';
pos integer := 1;
var_pos integer := 1;

begin

while atom_name is not null
loop

    var_pos := 1;
    select regexp_substr(v_mapping_string,'(\w+)\(',1,pos,NULL,1) 
    into atom_name from dual;
    exit when atom_name is null;
    
    dbms_output.put_line('Atom : ' || atom_name);
    select regexp_substr(v_mapping_string,'\(((\w+,)+\w)\)',1,pos,NULL,1) into param_list from dual;
    dbms_output.put_line('  Parameters : ' || param_list);
    while var is not null
    loop
        select regexp_substr(param_list,'(\w+)',1,var_pos,NULL,1) into var from dual;
        exit when var is null;
        dbms_output.put_line('      Variable: ' || var);
        var_pos := var_pos + 1;

    end loop;
    pos := pos + 1;

end loop;

end PARSEMAPPING;


END GAIA;

/
