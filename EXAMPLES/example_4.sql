-- DESCRIPTION OF THE TEST:
-- Encoding of a simple mapping that needs the repair.
DECLARE
    v_mapping_set_out varchar2(20);
    -- Oracle source schema
    V_SOURCE_SCHEMA varchar2(20) := 'GAIA_INPUT';
    -- Oracle target schema
    V_TARGET_SCHEMA varchar2(20) := 'GAIA_INPUT';
    -- Semicolon-separated schema mappings of the transformation scenario
    V_MAPPING_LIST varchar2(200) := 'TEST_TABLE_2(i,x,y,z,k)->OUTPUT_TABLE_2(i,x,y,z)';
BEGIN
    GAIA.encode(V_MAPPING_LIST,V_SOURCE_SCHEMA,V_TARGET_SCHEMA,v_mapping_set_out);
END;