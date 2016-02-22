DECLARE
V_MAPPING_STRING VARCHAR2(200);
V_MAPPING_ID VARCHAR2(200);
V_CANONICAL_MAPPING_ID VARCHAR2(200);
V_SOURCE_SCHEMA varchar2(200);
V_TARGET_SCHEMA varchar2(200);
V_ESCHEMA1 integer;
V_ESCHEMA2 integer;
V_MAPPING_SET_ID varchar2(200);
BEGIN
V_MAPPING_STRING := 'TEST_TABLE_2(i,x,y,z,k)->TEST_TABLE(x,k)';
V_SOURCE_SCHEMA := 'GAIA_INPUT';
V_TARGET_SCHEMA := 'GAIA_INPUT';
-- parse mapping
MAPPINGS_UTILS.PARSE_MAPPING(
V_MAPPING_STRING => V_MAPPING_STRING,
V_MAPPING_ID => V_MAPPING_ID
);
-- generate e-schemas
GAIA.GENERATE_ESCHEMAS(V_MAPPING_ID, V_SOURCE_SCHEMA, V_TARGET_SCHEMA, v_eschema1, v_eschema2);
-- generate the canonical mapping
GAIA.GET_CANONICAL_TEMPLATE_MAPPING (v_eschema1, v_eschema2, v_canonical_mapping_id);
-- repair the generated mapping
GAIA.GET_REPAIRED_TEMPLATE_MAPPINGS (v_canonical_mapping_id, V_MAPPING_SET_ID);
END;