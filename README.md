Gaia 2020
=========

The project includes libraries for:
-----------------------------------

  - GAIA.PARSE_MAPPING : parsing a schema mapping expressed as a string into GAIA metamodel
  - GAIA.MAPPING\_TO\_STRING\_BY\_ID: producing the string representation of a mapping stored in GAIA metamodel
  - GAIA.GENERATE_ESCHEMAS : encoding schema mappings acting on Oracle source and target schemas into eschemas
  - GAIA.GET\_CANONICAL\_TEMPLATE_MAPPING : generating canonical template schema mappings for a pair of source/target eschemas
  - genenerating canonical template schema mappings for a set of pairs of source/target exchemas
  - given a canonical template schema mapping, generate all the variants
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
  
