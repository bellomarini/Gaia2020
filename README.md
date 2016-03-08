Gaia 2020
=========


GAIA encoding
-------------

GAIA.encode

We take as input a list of semicolon-separated schema mappings, all from S to T and do the following:

1)
schema mapping 1 --> canonical mapping 1 --> set 1 of repaired canonical mappings
schema mapping 2 --> canonical mapping 2 --> set 2 of repaired canonical mappings
...
schema mapping N --> canonical mapping N --> set N of repaired canonical mappings 

2)
set 1 +merge+ set 2 +merge+ ... +merge+ setN --> set M of merged canonical template mappings

3)
generate_variants(set M) --> set Q of the possible variants 

set M is the final output

The project includes libraries for:
-----------------------------------

  - MAPPINGS\_UTILS.PARSE_MAPPING : parsing a schema mapping expressed as a string into GAIA metamodel
  - MAPPINGS\_UTILS.MAPPING\_TO\_STRING\_BY\_ID: producing the string representation of a mapping stored in GAIA metamodel
  - TEMPLATE\_MAPPINGS\_UTILS.ALL\_POSSIBLE\_HOMOMORPHISMS : generating all the possible homomorphisms from the LHS or RHS of a template mapping to an e-schema
  - TEMPLATE\_MAPPINGS\_UTILS.EXTENSION\_TEST : verifying if a template mapping extends to another one
    
  - GAIA.GENERATE_ESCHEMAS : encoding schema mappings acting on Oracle source and target schemas into eschemas
  - GAIA.GET\_CANONICAL\_TEMPLATE_MAPPING : generating canonical template schema mappings for a pair of source/target eschemas
  - GAIA.GET\_REPAIRED\_TEMPLATE\_MAPPINGS : given a canonical template mapping, we generate the set of all the possible repairs with equalities and inequalities to make it correct with respect to its e-schemas
  - GAIA.MERGE\_MAPPING\_SETS : we merge two sets of template mappings
  - GAIA.GENERATE\_VARIANTS : we generate second-level variants
  - GAIA.ENCODE : encodes a given schema mapping
 
Organization of the repository:
-------------------------------

  - / : contains the source code.
    - \<package\>_package.sql is the spec of package <package>
    - \<package\>.sql is the body of \<package\>
  - DDL/ : contains the DDL scripts to create the relations of Gaia metamodel and the sequences
  - EXAMPLES/ : contains the examples, in files \<example\>.sql
  - EXAMPLES/DDL : contains the DDL to create database source and target schemas

TODO
----

  SEARCH
  ------
  - given a source schema, propose all the applicable template schema mappings
  - given a target schema, propose all the applicable template schema mappings
  - given a source and a target schema, propose all the applicable template schema mappings
  
  S-D PROCEDURE
  -------------
  - given a database schema, generate the corresponding e-schema
  - given a template schema mapping and an e-schema, generate the schema mapping for the database schema


Structure of a file \<example\>.sql
-----------------------------------





  
