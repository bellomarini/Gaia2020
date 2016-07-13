Gaia 2020
=========


GAIA encoding
-------------

GAIA.encode

We take as input a list of semicolon-separated schema mappings, all from S to T and do the following:

1-
--
schema mapping 1 --> canonical mapping 1 --> set 1 of repaired canonical mappings (laconic, second-level, etc.)

schema mapping 2 --> canonical mapping 2 --> set 2 of repaired canonical mappings (laconic, second-level, etc.)

...

schema mapping N --> canonical mapping N --> set N of repaired canonical mappings (laconic, second-level, etc.)


2-
--

set 1 +merge+ set 2 +merge+ ... +merge+ setN --> set M of merged canonical template mappings

3-
--

generate_variants(set M) --> set Q of the possible variants 

set M is the final output

The project includes libraries for:
-----------------------------------

  - MAPPINGS\_UTILS.PARSE_MAPPING : parsing a schema mapping expressed as a string into GAIA metamodel
  - MAPPINGS\_UTILS.MAPPING\_TO\_STRING\_BY\_ID: producing the string representation of a mapping stored in GAIA metamodel
  - TEMPLATE\_MAPPINGS\_UTILS.ALL\_POSSIBLE\_HOMOMORPHISMS : generating all the possible homomorphisms from the LHS or RHS of a template mapping to an e-schema
  - TEMPLATE\_MAPPINGS\_UTILS.EXTENSION\_TEST : verifying if a template mapping extends to another one
  - GAIA.GENERATE\_ESCHEMAS : encoding schema mappings acting on Oracle source and target schemas into eschemas
  - GAIA.GENERATE\_ESCHEMAS\_FROM\_XHS : encodes the XHS of a schema mapping in terms of an eschema
  - GAIA.GET\_CANONICAL\_TEMPLATE_MAPPING : generating canonical template schema mappings for a pair of source/target eschemas
  - GAIA.GET\_REPAIRED\_TEMPLATE\_MAPPINGS : given a canonical template mapping, we generate the set of all the possible repairs with equalities and inequalities to make it correct with respect to its e-schemas
  - GAIA.MERGE\_MAPPING\_SETS : we merge two sets of template mappings
  - GAIA.GENERATE\_VARIANTS : we generate second-level variants
  - GAIA.ENCODE : encodes a given schema mapping

Some of the following functions adopt the concept of conjunctive query. In GAIA, a conjunctive query is expressed as schema mapping where
only the LHS is defined.
Some of the following functions adopt the concept of transformation. In GAIA, a transformation is expressed as a schema mapping where the LHS is a conjunctive query denoting the source schema and the RHS is a conjunctive query denoting the target schema.

  - GAIA.ENCODE\_RELATIONAL\_QUERY : from a database schema and a conjunctive query, we encode the restriction of the schema that is used by that query. 
  - GAIA.PROFILE\_TRANSFORMATION : from a database schema and a conjunctive query, we individuate the restriction of the schema that is used by the query. For each laconic schema mapping in the repository, for the LHS and for the RHS, we calculate the number of homomorphisms from that schema mapping to the restriction of the schema defined by the conjunctive query. We store the pair (homo\_LHS, homo\_RHS) as a profile for the conjunctive query. The idea is that the number of homomorphisms from a given portion of a schema to all the homomorphisms, profiles the portion of the schema.
  - GAIA.SEARCH\_TRANSFORMATION : from a database schema and a conjunctive query denoting a part of it, we individuate all the laconic schema mappings that are best suited for that. In particular, we pick up a sample of the available schema mappings and calculate the number of homomorphisms from the LHS and the RHS to each of those mappings. We then individuate the profile that is most similar to the calculated sample profile. For the so individuated profile, we report all the schema mappings, ranked according to the number of homomorphisms. 

Types of mappings
-----------------

These are the types of mappings we handle in the MAPPINGS table:

- S : a usual schema mapping
- C : a canonical template mapping
- L : a canonical template mapping with laconic repairs (if laconic enabled)
- CP : a template mapping with equalities (first-level variant obtained as a positive repair of a canonical template mapping)
- CN : a template mapping with inequalities (first-level variant obtained with a negative repair of a canonical template mapping)
- CH : a template mapping with equalities and inequalities (first-level variant obtained with a hybrid repair of a canonical mapping)
- CPV : a template mapping generated as a second-level variant of a positive repair of a canonical mapping
- CNV : a template mapping generated as a second-level variant of a negative repair of a canonical mapping
- CHV : a template mapping generated as a second-level variant of a hybrid repair of a canonical mapping
- LV : a template mapping generated as a second-level variant of a laconic mapping (if laconic enabled)
- CV : a template mapping generated as a second-level variant of a canonical mapping (if it didn't need a repair)

Organization of the repository
-------------------------------

  - / : contains the source code.
    - \<package\>_package.sql is the spec of package <package>
    - \<package\>.sql is the body of \<package\>
  - DDL/ : contains the DDL scripts to create the relations of Gaia metamodel and the sequences
  - EXAMPLES/ : contains the examples, in files \<example\>.sql
  - EXAMPLES/DDL : contains the DDL to create database source and target schemas

TODO
----

* Attention: LAC mappings should have < and not <= (just correct the string,
	the check is now ok)

* Indexing
  - index the mappings in the repository with <=s (Arenas)
  - index the mappings in the repository with <=t (Arenas)

* Search
  - given a source e-schema, propose all the applicable template schema mappings
  - given a target e-schema, propose all the applicable template schema mappings
  - given a source and a target e-schema, propose all the applicable template schema mappings
  
Structure of a file \<example\>.sql
-----------------------------------

This is the structure of an example file for testing the encoding.

```
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
    -- Second-level variants
    V_ENABLE_SECOND_LEVEL_VARIANTS boolean := FALSE;
    -- LAC OPTIMIZATION
    V_LAC_OPTIMIZE boolean := TRUE;
    
BEGIN
    GAIA.encode(V_MAPPING_LIST,V_SOURCE_SCHEMA,V_TARGET_SCHEMA,v_mapping_set_out,V_ENABLE_SECOND_LEVEL_VARIANTS,V_LAC_OPTIMIZE);
END;
```

Launch this block and wait for the completion.
In the output log GAIA shows the id of final mapping sets it has created.
To inspect the generating mapping run this query:

```
select *
from mappings
where id in (
  select mapping
  from mapping_sets
  where id = <final mapping set id>
)
