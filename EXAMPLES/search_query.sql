DECLARE
        v_eschema_out varchar2(20);
    BEGIN
        -- we encode the input query that selects a portion
        -- of the schema to search for
        --GAIA.encode_relational_query('BANKS(i,x,y,z,k)', 'GAIA_INPUT', v_eschema_out);
        
        --TEMPLATE_MAPPINGS_UTILS.mapping_specificity('53249','LHS',v_eschema_out);
        --dbms_output.put_line(TEMPLATE_MAPPINGS_UTILS.mapping_specificity('53249','LHS',v_eschema_out));
        GAIA.search_transformation('BANK0(a,b,c,d,e,f,g),BANK1(a,', 'BILANA', 'SOURCE');
        --GAIA.profile_transformation('G1(x,y)', 'GAIA_INPUT', 'SOURCE');
    END;