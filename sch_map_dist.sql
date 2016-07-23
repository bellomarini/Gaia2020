--------------------------------------------------------
--  File created - Saturday-July-23-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body SCH_MAP_DIST
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "GAIA"."SCH_MAP_DIST" AS

  -- returns a normalized distance between 0 and 1 between two features
  function num_dist(v_a number, v_b number) return number as
  begin
    
    if v_a = 0 and v_b = 0 
        then return 0; 
    end if;
    
    if v_a >= v_b then
        return (v_a - v_b) / v_a;
    else
        return (v_b - v_a) / v_b;
    end if;
  
  end num_dist;
  
  -- scales a number x in a range between 0 and 1 to a new interval [a,b].
  -- This function is useful to weigh features.
  function feature_scale(v_x number, v_a number, v_b number) return number as
  begin
    return v_a + v_x * (v_b - v_a);
  end feature_scale;
  
  -- combines two probability measures by applying a formula
  -- derived from Naive Bayes (paulgarham.com/naivebayes.html)
  function garham(v_f1 number, v_f2 number) return number as
  begin
  
    -- 0 threshold to avoid division by 0
    if (v_f1 * v_f2 + (1-v_f1)*(1-v_f2) ) < 0.000000001
        then
            return 0;
    end if;
    
    return (v_f1 * v_f2) / ((v_f1 * v_f2) + ((1-v_f1)*(1-v_f2)) );
  end garham;

  function distance(v_in_mapping_id in varchar2, v_in_mapping_eschema in varchar2, v_target_mapping_id in varchar2) 
        return number AS
    
    v_outcome integer := 0;
    
    -- features for structural comparison
    -- of the transformation and the mapping
    v_l_rel_in number;
    v_l_rel_out number;
    v_r_rel_in number;
    v_r_rel_out number;
    v_l_exist_in number;
    v_l_exist_out number;
    v_l_join_in number;
    v_l_join_out number;
    v_r_join_in number;
    v_r_join_out number;
    v_l_cart_in number;
    v_l_cart_out number;
    v_l_join_fk_in number;
    v_l_join_fk_out number;
    v_l_cart_fk_in number;
    v_l_cart_fk_out number;
    v_r_join_fk_in number;
    v_r_join_fk_out number;
    v_r_cart_fk_in number;
    v_r_cart_fk_out number;
    v_l_join_key_in number;
    v_l_join_key_out number;
    v_var_copied_in number;
    v_var_copied_out number;
    v_var_joined_in number;
    v_var_joined_out number;
    v_var_disjoint_in number;
    v_var_disjoint_out number;
    v_var_normalized_in number;
    v_var_normalized_out number;
    v_var_denormalized_in number;
    v_var_denormalized_out number;
    
    v_jaccard number;
    
    v_l_rel_dist number;
    v_r_rel_dist number;
    v_l_exist_dist number;
    v_l_join_dist number;
    v_r_join_dist number;
    v_l_cart_in_dist number;
    v_l_join_fk_dist number;
    v_l_cart_fk_dist number;
    v_r_join_fk_dist number;
    v_r_cart_fk_dist number;
    v_l_join_key_dist number;
    v_car_copied_dist number;
    v_var_joined_dist number;
    v_var_disjoint_dist number;
    v_var_normalized_dist number;
    v_var_denormalized_dist number;
    
    
    v_feature_comb number;
  
  BEGIN

    -- the query is already scored
    
    -- loads the structural features of the input mapping
    select
         nvl(l1.l_rel,0),
         nvl(l1.r_rel,0),
         nvl(l1.exist,0),
         nvl(l1.l_join,0), 
         nvl(l1.r_join,0),
         nvl(l1.l_cart,0),
         nvl(l1.l_join_fk,0),
         nvl(l1.l_cart_fk,0),
         nvl(l1.r_join_fk,0),
         nvl(l1.r_cart_fk,0),
         nvl(l1.l_join_key,0), 
         nvl(l1.var_copied,0), 
         nvl(l1.var_joined,0),
         nvl(l1.var_disjoint,0),
         nvl(l1.var_normalized,0),
         nvl(l1.var_denormalized,0)
    into
    v_l_rel_in,
    v_r_rel_in, 
    v_l_exist_in, 
    v_l_join_in,
    v_r_join_in, 
    v_l_cart_in,
    v_l_join_fk_in,
    v_l_cart_fk_in, 
    v_r_join_fk_in,
    v_r_cart_fk_in,
    v_l_join_key_in, 
    v_var_copied_in, 
    v_var_joined_in,
    v_var_disjoint_in, 
    v_var_normalized_in, 
    v_var_denormalized_in 
    from laconic_index l1
    where mapping = v_in_mapping_id;
    
     -- loads the structural features of the output mapping
    select
         nvl(l1.l_rel,0),
         nvl(l1.r_rel,0),
         nvl(l1.exist,0),
         nvl(l1.l_join,0), 
         nvl(l1.r_join,0),
         nvl(l1.l_cart,0),
         nvl(l1.l_join_fk,0),
         nvl(l1.l_cart_fk,0),
         nvl(l1.r_join_fk,0),
         nvl(l1.r_cart_fk,0),
         nvl(l1.l_join_key,0), 
         nvl(l1.var_copied,0), 
         nvl(l1.var_joined,0),
         nvl(l1.var_disjoint,0),
         nvl(l1.var_normalized,0),
         nvl(l1.var_denormalized,0)
    into
    v_l_rel_out,
    v_r_rel_out, 
    v_l_exist_out, 
    v_l_join_out,
    v_r_join_out, 
    v_l_cart_out,
    v_l_join_fk_out,
    v_l_cart_fk_out, 
    v_r_join_fk_out,
    v_r_cart_fk_out,
    v_l_join_key_out, 
    v_var_copied_out, 
    v_var_joined_out,
    v_var_disjoint_out, 
    v_var_normalized_out, 
    v_var_denormalized_out 
    from laconic_index l1
    where mapping = v_target_mapping_id;
    
    -- we calculate the structural similarity between mappings
    -- with a Jaccard index on constants attributed to relations and attributes
    -- for this we need the schema encoding

    -- selects the names of the schema
    with SCHEMA_SYMBOLS as (
        select 'RELATION', r.name 
        from attributes a join relations r on (a.relation = r.id)
        where eschema = v_in_mapping_eschema
        union 
        select 'ATTRIBUTE', a.name 
        from attributes a join relations r on (a.relation = r.id)
        where eschema = v_in_mapping_eschema
    ),
    -- selects the names within a template mapping (from the conditions)
     MAPPING_SYMBOLS as (
        select distinct a.name, c.value
        from mappings m join variables v on (m.id = v.mapping)
            join variables_atoms va on (va.variable = v.id)
            left outer join conditions c on (c.variable = v.id)
            join atoms a on (a.id = va.atom)
        where m.id= v_target_mapping_id and c.cond_type in ('EQ','NEQ')
    ), INTER_CARD as ( 
        select count(*) as cnt from 
            (select * from MAPPING_SYMBOLS intersect select * from SCHEMA_SYMBOLS)
        )
    , UNION_CARD as (
        select count(*) as cnt from
            (select * from MAPPING_SYMBOLS union select * from SCHEMA_SYMBOLS)
    ) select case when (ic.cnt = 0 or uc.cnt = 0) then 0 else ic.cnt / uc.cnt end Jaccard into v_jaccard
    from INTER_CARD ic, UNION_CARD uc;
    
    -- all the features at the beginning are neutral
    v_feature_comb := 0.5;
    
    -- calculating the distances and scaling the features
    v_l_rel_dist := feature_scale(1-num_dist(v_l_rel_in,v_l_rel_out),0.4,0.75);
    v_r_rel_dist := feature_scale(1-num_dist(v_r_rel_in,v_r_rel_out),0.4,0.60);
    v_l_exist_dist := feature_scale(1-num_dist(v_l_exist_in,v_l_exist_out),0.4,0.60);
    v_l_join_dist := feature_scale(1-num_dist(v_l_join_in,v_l_join_out),0.5,0.5);
    v_r_join_dist := feature_scale(1-num_dist(v_r_join_in,v_r_join_out),0.5,0.55);
    v_l_cart_in_dist := feature_scale(1-num_dist(v_l_cart_in,v_l_cart_out),0.5,0.55);
    v_l_join_fk_dist := feature_scale(1-num_dist(v_l_join_fk_in,v_l_join_fk_out),0.5,0.55);
    v_l_cart_fk_dist := feature_scale(1-num_dist(v_l_cart_fk_in,v_l_cart_fk_out),0.5,0.55);
    v_r_join_fk_dist := feature_scale(1-num_dist(v_r_join_fk_in,v_r_join_fk_out),0.5,0.55);
    v_r_cart_fk_dist := feature_scale(1-num_dist(v_r_cart_fk_in,v_r_cart_fk_out),0.5,0.55);
    v_l_join_key_dist := feature_scale(1-num_dist(v_l_join_key_in,v_l_join_key_out),0.5,0.55);
    v_car_copied_dist := feature_scale(1-num_dist(v_var_copied_in,v_var_copied_out),0.5,0.65);
    v_var_joined_dist := feature_scale(1-num_dist(v_var_joined_in,v_var_joined_out),0.5,0.55);
    v_var_disjoint_dist := feature_scale(1-num_dist(v_var_disjoint_in,v_var_disjoint_out),0.5,0.55);
    v_var_normalized_dist := feature_scale(1-num_dist(v_var_normalized_in,v_var_normalized_out),0.5,0.55);
    v_var_denormalized_dist := feature_scale(1-num_dist(v_var_denormalized_in ,v_var_denormalized_out),0.5,0.55);
    
    v_jaccard := feature_scale(v_jaccard,0.40,0.85);
           
    -- combining the features with garham
    
    LOG_UTILS.log_me('GARHAM (initial): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_l_rel_dist);
    LOG_UTILS.log_me('GARHAM (v_l_rel): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_r_rel_dist);
    LOG_UTILS.log_me('GARHAM (v_r_rel): ' || v_feature_comb);    
    v_feature_comb := garham(v_feature_comb,v_l_exist_dist);
    LOG_UTILS.log_me('GARHAM (v_l_exist): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_l_join_dist);
    LOG_UTILS.log_me('GARHAM (v_l_join): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_r_join_dist);
    LOG_UTILS.log_me('GARHAM (v_r_join): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_l_cart_in_dist);
    LOG_UTILS.log_me('GARHAM (v_l_cart): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_l_join_fk_dist);
    LOG_UTILS.log_me('GARHAM (v_l_join_fk): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_l_cart_fk_dist);
    LOG_UTILS.log_me('GARHAM (v_l_cart_fk): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_r_join_fk_dist);
    LOG_UTILS.log_me('GARHAM (v_r_join_fk): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_r_cart_fk_dist);
    LOG_UTILS.log_me('GARHAM (v_r_cart_fk): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_l_join_key_dist);
    LOG_UTILS.log_me('GARHAM (v_l_join_key): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_car_copied_dist);
    LOG_UTILS.log_me('GARHAM (v_var_copied): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_var_joined_dist);
    LOG_UTILS.log_me('GARHAM (v_var_joined): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_var_disjoint_dist);
    LOG_UTILS.log_me('GARHAM (v_var_disjoint): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_var_normalized_dist);
    LOG_UTILS.log_me('GARHAM (v_var_normalized): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_var_denormalized_dist);
    LOG_UTILS.log_me('GARHAM (v_var_denormalized): ' || v_feature_comb);
    v_feature_comb := garham(v_feature_comb,v_jaccard);
    LOG_UTILS.log_me('GARHAM (v_jaccard): ' || v_feature_comb);

    
    LOG_UTILS.log_me('Score for ' || v_in_mapping_id || ' to ' || v_target_mapping_id || '--> ' ||
    'l_rel_dist:' || v_l_rel_dist || '; ' ||
    'r_rel_dist: ' || v_r_rel_dist || '; ' ||
    'l_exist_dist: ' || v_l_exist_dist || '; ' ||
    'l_join_dist: ' || v_l_join_dist || '; ' ||
    'r_join_dist: ' || v_r_join_dist || '; ' ||
    'l_cart_dist: ' || v_l_cart_in_dist || '; ' ||
    'l_join_fk: ' || v_l_join_fk_dist || '; ' ||
    'l_cart_fk: ' || v_l_cart_fk_dist || '; ' ||
    'r_join_fk: ' || v_r_join_fk_dist || '; ' ||
    'r_cart_fk: ' || v_r_cart_fk_dist || '; ' ||
    'l_join_key: ' || v_l_join_key_dist || '; ' ||
    'car_copied: ' || v_car_copied_dist || '; ' ||
    'var_joined: ' || v_var_joined_dist || '; ' ||
    'var_disjoint: ' || v_var_disjoint_dist || '; ' || 
    'var_normalized: ' || v_var_normalized_dist || '; ' ||
    'var_denormalized: ' || v_var_denormalized_dist || '; ' ||
    'jaccard: ' || v_jaccard || '; ' ||
    'TOTAL: ' || v_feature_comb);
    
    return v_feature_comb;
        
  END distance;

END SCH_MAP_DIST;

/
