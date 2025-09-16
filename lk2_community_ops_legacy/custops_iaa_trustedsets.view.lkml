# most active contributor gcheung@snapchat.com
view: custops_iaa_trustedsets {
  derived_table: {
    sql: SELECT
          id,
          agentId,
          email,
          trustedSetTaskId,
          INTEGER(hasSeen) AS hasSeen,
          responseId,
          createdAt,
          updatedAt,
          taskId,
          creator,
          FLOAT(score) AS score
         FROM TABLE_QUERY([sc-analytics:report_customer_ops], "table_id IN (SELECT table_id FROM [sc-analytics:report_customer_ops.__TABLES__] WHERE REGEXP_MATCH(table_id, r'^taskservice_agent_trustedset_meta_distinct_[0-9].*') ORDER BY table_id DESC LIMIT 1)")
         WHERE creator IN ('49023598-9e9c-45c0-a671-6daa7ac31eee','fsn-lca-issuer@feelinsonice-hrd.iam.gserviceaccount.com', '728376088307-compute@developer.gserviceaccount.com') ;;

    #sql_trigger_value: SELECT HOUR(NOW()) ;;
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: agent_id {
    type: string
    sql: ${TABLE}.agentId ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: trusted_set_task_id {
    type: string
    sql: ${TABLE}.trustedSetTaskId ;;
  }

  dimension: has_seen {
    type: yesno
    sql: ${TABLE}.hasSeen ;;
  }

  dimension: has_seen_raw {
    type: number
    hidden: yes
    sql: INTEGER(${TABLE}.hasSeen) ;;
  }

  dimension: response_id {
    type: string
    sql: ${TABLE}.responseId ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.createdAt ;;
  }

  dimension_group: updated_at {
    type: time
    sql: ${TABLE}.updatedAt ;;
  }

  dimension: task_id {
    type: string
    sql: ${TABLE}.taskId ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  measure: raw_score {
    type: sum
    sql: ${TABLE}.score ;;
    drill_fields: [detail*]
  }

  measure: score_pct {
    type: number
    description: "Raw Score divided by Total Seen"
    sql: SUM(${TABLE}.score) / SUM(IF(${TABLE}.hasSeen > 0,1,0)) ;;
    value_format: "0.0%"
    drill_fields: [detail*]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: seen_count {
    type: count
    filters: {
      field: has_seen_raw
      value: "1"
    }
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      agent_id,
      email,
      trusted_set_task_id,
      raw_score,
      has_seen,
      response_id,
      created_at_time,
      updated_at_time,
      task_id,
      creator
    ]
  }
}
