# most active contributor jbabra@snapchat.com
view: persona {

  derived_table: {
    sql: (SELECT
        ghost_user_id,
        cluster
            FROM TABLE_QUERY([sc-analytics:user_persona_v2],
                "table_id IN (SELECT table_id FROM [sc-analytics:user_persona_v2.__TABLES__]
                WHERE REGEXP_MATCH(table_id, r'^user_persona_v2_[0-9]{8}$')
                ORDER BY table_id
                DESC LIMIT 1)")) ;;

    }

#Dimensions


    dimension: ghost_user_id {
      type: string
    primary_key: yes
    }


    dimension: cluster {
      type: string
      label: "User Persona"
      description: "V2 Persona"
    }

#Measures

  measure: count {
    type: count_distinct
    label: "Count Unique GhostIDs"
    sql: COALESCE(${ghost_user_id},NULL) ;;
    drill_fields: [cluster,ghost_user_id]
    approximate_threshold: 1000000000
  }


  }
