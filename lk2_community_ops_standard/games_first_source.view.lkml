# most active contributor jbabra@snapchat.com
view: games_first_source {

  derived_table: {
    sql:
        SELECT
        ghost_user_id,
        first_source,
        cognac_id
          FROM `sc-analytics.report_growth.cognac_games_first_source_202*`
          ;;
  }
#        WHERE
#         _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE("America/Los_Angeles"), INTERVAL 1 DAY))


  dimension: ghost_user_id {
    type: string
    sql: ${TABLE}.ghost_user_id ;;
    case_sensitive: no
    hidden: yes
  }

  dimension: first_source {
    type: string
    sql: ${TABLE}.first_source ;;
    case_sensitive: no
  }


  }
