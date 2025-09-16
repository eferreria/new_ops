# most active contributor abenharosh@snapchat.com
view: social_comment {
label: "Social Comment (SF Only)"
  derived_table: {
    sql:
    SELECT
    *
    FROM `sc-analytics.prod_metadata_crm_co.case_comment_*`
    WHERE
    _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', CURRENT_DATE("America/Los_Angeles"))
    ;;
  }



  dimension: comment_body {
    type: string
    sql: ${TABLE}.comment_body ;;
    case_sensitive: no
  }

  dimension_group: created_date {
    type: time
    label: "Comment Created PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time]
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
     hidden: yes
  }

  dimension: parent_id {
    type: string
    sql: ${TABLE}.parent_id ;;
    hidden: yes
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.created_by_id ;;
  }

  measure: count_notes {
    type: count
  }


}
