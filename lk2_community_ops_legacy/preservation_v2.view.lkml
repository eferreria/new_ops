# most active contributor null
view: preservation_v2 {
  derived_table: {
    sql: SELECT
          v2.job_id,
          v2.data_source,
          v1.operational_time AS v1_time,
          (v2.last_update_timestamp - v2.creation_timestamp) AS v2_time,
          LOWER(v1.status) AS v1_status,
          v2.status AS v2_status,
          v2.pubsub_id AS trace_id,
          v2.event_timestamp AS ts
        FROM (
        SELECT
          preservation_id,
          data_source,
          MAX(p2id) AS p2id,
          MAX(status) AS status,
          SUM(operational_time) AS operational_time,
          COUNT(*) AS num_of_page
        FROM (
          SELECT
            CONCAT(preservation_v2_id, "_v2") AS p2id,
            CASE
            WHEN source_type IN ('PreserveChatTask', 'PreserveChatMediaTask') THEN 'chat'
            WHEN source_type IN ('PreserveGroupChatTask', 'PreserveGroupChatMediaTask') THEN 'group_chat'
            ELSE 'unknown'
          END
            AS data_source,
            *
          FROM
            [feelinsonice-hrd:leo_preservations.preservation_status_log]
          WHERE
            {% condition date_filter %} _PARTITIONTIME {% endcondition %}
            AND source_type IN ('PreserveChatTask', 'PreserveChatMediaTask', 'PreserveGroupChatTask', 'PreserveGroupChatMediaTask')
          )
        GROUP BY preservation_id, data_source) AS v1
        JOIN (
        SELECT * FROM
        [murphy-gae:leo_preservations.preservation_v2_logs]
        WHERE {% condition date_filter %} _PARTITIONTIME {% endcondition %}) AS v2
        ON
          v1.p2id = v2.job_id
          AND v1.data_source = v2.data_source
       ;;
  }

  filter: date_filter {
    type: date
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: v2_job_id {
    type: string
    sql: ${TABLE}.v2_job_id ;;
  }

  dimension: v2_data_source {
    type: string
    sql: ${TABLE}.v2_data_source ;;
  }

  dimension: v1_time {
    type: number
    sql: ${TABLE}.v1_time ;;
  }

  dimension: v2_time {
    type: number
    sql: ${TABLE}.v2_time ;;
  }

  dimension: v1_status {
    type: string
    sql: ${TABLE}.v1_status ;;
  }

  dimension: v2_status {
    type: string
    sql: ${TABLE}.v2_status ;;
  }

  dimension: trace_id {
    type: string
    sql: ${TABLE}.trace_id ;;
  }

  dimension: ts {
    type: number
    sql: ${TABLE}.ts ;;
  }

  set: detail {
    fields: [
      v2_job_id,
      v2_data_source,
      v1_time,
      v2_time,
      v1_status,
      v2_status,
      trace_id,
      ts
    ]
  }
}
