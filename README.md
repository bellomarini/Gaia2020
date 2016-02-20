Gaia 2020
=========

The project includes libraries for:
-----------------------------------

  - MAPPINGS\_UTILS.PARSE_MAPPING : parsing a schema mapping expressed as a string into GAIA metamodel
  - MAPPINGS\_UTILS.MAPPING\_TO\_STRING\_BY\_ID: producing the string representation of a mapping stored in GAIA metamodel
    
  - GAIA.GENERATE_ESCHEMAS : encoding schema mappings acting on Oracle source and target schemas into eschemas
  - GAIA.GET\_CANONICAL\_TEMPLATE_MAPPING : generating canonical template schema mappings for a pair of source/target eschemas
  - GAIA.GET\_REPAIRED\_TEMPLATE\_MAPPINGS : given a canonical template mapping, we generate the set of all the possible repairs with equalities and inequalities to make it correct with respect to its e-schemas.
  
  - merging two canonical template schema mappings into a set of template mappings
  - given a set of canonical template schema mapping, generate all the variants
  - given a source schema, propose all the applicable template schema mappings
  - given a target schema, propose all the applicable template schema mappings
  - given a template schema mapping, generate the corresponding schema mapping
  
Organization of the repository:
-------------------------------

  - / : contains the source code.
    - \<package\>_package.sql is the spec of package <package>
    - \<package\>.sql is the body of \<package\>
  - DDL/ : contains the DDL scripts to create the relations of Gaia metamodel and the sequences
  - EXAMPLES/ : contains the examples

Structure of a file \<example\>.sql
---------------------------------

- DDL to create the source schema (to be run as admin)
  - e.g. CREATE USER ...
  - CREATE TABLE ( ... )
  - CREATE UNIQUE INDEX ...
  - ALTER TABLE .. ADD CONSTRAINT ...

- DDL to create the source schema (to be run as admin)
  - e.g. CREATE USER ...
  - CREATE TABLE ( ... )
  - CREATE UNIQUE INDEX ...
  - ALTER TABLE .. ADD CONSTRAINT ...

- set of mappings (with the following syntax):
  - INPUT\_TABLE(a,x,y),CHILD\_TABLE(y,z)->OUTPUT_TABLE(a,z)

  
