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
  - GAIA.SEARCH\_TRANSFORMATION : from a database schema and a conjunctive query denoting a part of it, we individuate all the laconic schema mappings that are best suited for that. In particular, we pick up a sample of the available schema mappings and calculate the number of homomorphisms from the LHS and the RHS to each of those mappings. We then individuate the profile that is most similar to the calculated sample profile. For the so individuated profile, we report all the schema mappings, ranked according to the number of homomorphisms. The ones with less homomorphisms are assumed to be more suitable.
  - GAIA.SEARCH\_TRANSFORMATION\_INDEX : from a source and target databases, represented by a conjunctive query on an existing database schema, we individuate all the  schema mappings (laconic and not) that are best suited for it. 
  In particular, we define a number of structural features that can be calculated both on template mappings and on input source and target schemas. For the template mappings in the repository, we calculate the values of these features and store them in an index. For the input source and target schema, we calculate these features on line. They include: number of relations, number of attributes, number of joins ... (shown in the table below). Given an input source and target schema, we proceed to choose the best mappings by evaluating a score in two steps: a. we compute a structural similarity; b. we compute a measure of the shared constants. For the structural similarity: 1. we compute a [0,1] normalized distance between the various features, and a score 1-d, out of this distance; 2. we scale these scores between parametric ranges [a,b], defined for each feature, by applying a Feature Scaling formula (this allows to tune the contribution of the single feature [0.5, 0.5] neutral, [0.5,>0,5] only positive, [<0.5,0.5] only negative, [<0.5,>0.5] positive and negative... with all the intermediate ranges). For weighing the contribution to the score of the shared constants, we  adopt Jaccard index on relation and attribute names and apply Feature Scaling on this index as well. All the scores (structural and shared constants) are combined with a technique derived from Naive Bayes Classifiers (Garham formula http://www.paulgraham.com/naivebayes.html). Finally, template mappings having a score greather than a given threshold are returned, ranked by the score itself.

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

INDEX
-----

The following table describes the structural features, used to evaluate similarity between
mappings and schemas.

|  parameter   	    | description | similarity score |
|-------------------|----------------------------------|----------------- |
| L\_REL 	    | number of relations in the LHS | 
| R\_REL       | number of relations in the RHS | 
| EXIST  	    | number of existentially quantified variables |
| L\_JOIN      | number of joins in the LHS (i.e. number of unique pairs of atoms with at least one variable in common) |
| R\_JOIN      | number of joins in the RHS (i.e. number of unique pairs of atoms with at least one variable in common) |
| L\_CART	    | number of cartesian products in the LHS (i.e. number of unique pairs of atoms without any variable in common) |
| R\_CART	    | number of cartesian products in the RHS (i.e. number of unique pairs of atoms without any variable in common) |
| L\_JOIN\_FK  | number of joins along a FK in the LHS (i.e. number of unique pairs of atoms with such a join) |
| L\_CART\_FK  | number of cartesian products along a FK in the LHS (i.e. number of unique pairs of atoms linked by a FK, without any variable in common) |	
| R\_JOIN\_FK  | number of joins along a FK in the RHS (i.e. number of unique pairs of atoms with such a join)|
| R\_CART\_FK  | number of cartesian products along a FK in the RHS (i.e. number of unique pairs of atoms with such a join)|
| L\_JOIN\_KEY | number of joins along a KEY in the LHS |
| R\_JOIN\_KEY | number of joins along a KEY in the RHS |
| VAR\_COPIED  | number of distinct variables copied from the LHS to the RHS |
| VAR\_JOINED | number of unique pairs of variables in distinct relations, without FKs in the LHS, copied to the same relation or into relations with a FK in the RHS |
| VAR\_DISJOINT | number of unique pairs of variables in the same relation in the LHS, or in relations with FKs, copied to distinct relations in the RHS, without a FK |
| VAR\_NORMALIZED | number of unique pairs of variables in the same relation in the LHS, copied to distinct relations in the RHS with a FK |
| VAR\_DENORMALIZED | number of unique pair of variables in distinct relations in the LHS with a FK, copied to the same relation in the RHS |

Organization of the repository
-------------------------------

  - / : contains the source code.
    - \<package\>_package.sql is the spec of package <package>
    - \<package\>.sql is the body of \<package\>
  - DDL/ : contains the DDL scripts to create the relations of Gaia metamodel and the sequences
  - EXAMPLES/ : contains the examples, in files \<example\>.sql
  - EXAMPLES/DDL : contains the DDL to create database source and target schemas

Structure of a file \<example\>.sql
-----------------------------------

This is the structure of an example file for encoding a transformation.

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
```

Structure of a file \<profile\_query\>.sql
-----------------------------------

This is the structure of an example file for profiling a conjunctive query.

```
    BEGIN
        GAIA.profile_transformation('BANK1(x,y,z),BANK100(x,m,k,q)', 'BILANA', 'SOURCE');
    END;
```

Structure of a file \<search\_query\>.sql
------------------------------------------

This is the structure of an example file for searching the best
mappings for a transformation using the profiles.

```
    BEGIN
        GAIA.search_transformation('BANK1(x,y,z)', 'BILANA', 'SOURCE');
    END;
```

Structure of a file \<index\_search\_query\>.sql
-------------------------------------------------

This is the structure of an example file for searching the best mapping for a transformation
using the index.

```
declare
    begin
        GAIA.search_transformation_index('BANK0(x,y,z,k,u),BANK1(x,a,b)', 'BILANA');    
    end;
    
```

TODO
----

* Attention: LAC mappings should have < and not <= (just correct the string,
	the check is now ok)


