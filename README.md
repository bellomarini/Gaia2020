Gaia 2020

The project includes libraries for:
  - parsing schema mappings
  - encoding schema mappings acting on Oracle schemas into eschemas
  - encoding Oracle relations into eschemas
  - generating canonical schema mappings for a pair of source/target eschemas
  - genenerating canonical schema mappings for a set of pairs of source/target exchemas
  - given a canonical schema mapping, generate all the variants
  
Organization of the repository:
  - root : contains the source code.
    - \<package\>_package.sql is the spec of package <package>
    - \<package\>.sql is the body of \<package\>
  - DDL : contains the DDL scripts to create the relations of Gaia metamodel and the sequences
  
