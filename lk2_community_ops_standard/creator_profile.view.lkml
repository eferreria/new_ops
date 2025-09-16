view: creator_profile {
  view_label: "Creator Profile"
  derived_table: {
    sql:

  SELECT
  PARSE_DATE('%Y%m%d', CONCAT('20',c._TABLE_SUFFIX)) AS date_pst,
  u.ghostId as creator_ghost_user_id,
  max(COALESCE(creator_tier__tier,'TIER_UNKNOWN')) as creator_tier__tier,
  max(COALESCE(creator_tier__subtier, 'SUBTIER_UNKNOWN')) as creator_tier__subtier,
  max(COALESCE(creator_tier__is_real_creator, False)) as creator_tier__is_real_creator,
  FROM `context-pii.creator_profile.creator_profile_v1_prod_20*` c
  join `snap-atlas-prod.user_identity.user_id_mapping_20*` u
  on c.creator_user_id = u.userId and c._TABLE_SUFFIX = u._TABLE_SUFFIX
  where CONCAT('20',c._TABLE_SUFFIX) >= FORMAT_TIMESTAMP("%Y%m%d", TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 day))
  and CONCAT('20',u._TABLE_SUFFIX) >= FORMAT_TIMESTAMP("%Y%m%d", TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 day))
  group by 1, 2
      ;;
  }

  dimension_group: date_pst {
    type: time
    sql: TIMESTAMP(${TABLE}.date_pst);;
  }

  dimension: creator_ghost_user_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.creator_ghost_user_id ;;
  }

  dimension: creator_type_tier {
    type: string
    sql: ${TABLE}.creator_tier__tier ;;
  }

  dimension: creator_type_subtier {
    type: string
    sql: ${TABLE}.creator_tier__subtier ;;
  }

  dimension: creator_type_is_real_creator {
    type: string
    sql: ${TABLE}.creator_tier__is_real_creator ;;
  }

}
