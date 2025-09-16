# most active contributor jbabra@snapchat.com
view: persona_v3 {

  derived_table: {
    sql:
        SELECT
        ghost_user_id,
        Persona

     FROM `sc-analytics.user_persona_v3.user_persona_v3_20*`
    WHERE _TABLE_SUFFIX = (select max(_TABLE_SUFFIX) from  `sc-analytics.user_persona_v3.user_persona_v3_20*`)
         ;;
  }


#Dimensions


  dimension: ghost_user_id {
    type: string
    primary_key: yes
  }


  dimension: Persona {
    type: string
    label: "User Persona"
    description: "V3 Persona"
  }

#Measures

  measure: count {
    type: count_distinct
    label: "Count Unique GhostIDs"
    sql: COALESCE(${ghost_user_id},NULL) ;;
    drill_fields: [Persona,ghost_user_id]
  }












  }
