-- DESCRIPTION OF THE TEST:
-- Encoding of a simple mapping that needs the repair.
DECLARE
    v_mapping_set_out varchar2(20);
    -- Oracle source schema
    V_SOURCE_SCHEMA varchar2(20) := 'GAIA_INPUT';
    -- Oracle target schema
    V_TARGET_SCHEMA varchar2(20) := 'GAIA_INPUT';
    -- Semicolon-separated schema mappings of the transformation scenario
    V_MAPPING_LIST varchar2(200) := 'BANKS(i,x,x,x,x),G2(i,y)->G1(x,y)';
    -- Second-level variants
    V_ENABLE_SECOND_LEVEL_VARIANTS boolean := FALSE;
    -- LAC OPTIMIZATION
    V_LAC_OPTIMIZE boolean := TRUE;
    
BEGIN
    GAIA.encode(V_MAPPING_LIST,V_SOURCE_SCHEMA,V_TARGET_SCHEMA,v_mapping_set_out, V_ENABLE_SECOND_LEVEL_VARIANTS, V_LAC_OPTIMIZE);
END;