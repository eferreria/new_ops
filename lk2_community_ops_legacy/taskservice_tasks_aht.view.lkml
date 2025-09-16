view: taskservice_tasks_aht {
  view_label: "Task Average Handling Time"
  derived_table: {
    sql:
      SELECT
        batch,
        batch_checkout_at,
        task_id,
        user,
        queue,
        queue_id,
        avg_duration_sec,
        total_duration_sec,
        batch_size,
        id,
        roster.sheet_location AS sheet_location,
        roster.workday_location AS workday_location,
        roster.sheet_language_fulfilled AS sheet_language_fulfilled,
        roster.sheet_position AS sheet_position,
        roster.workday_title AS workday_title
      FROM [sc-analytics:report_customer_ops.taskservice_tasks_average_handling_time] aht
      LEFT JOIN ${custops_fte_vendor_users.SQL_TABLE_NAME} AS roster ON roster.email = aht.user
      WHERE {% condition taskservice_taskhistories.date_filter %} aht._PARTITIONTIME {% endcondition %} ;;
  }

  dimension: batch {
    type: string
    description: "Batch ID"
    label: "Batch ID"
  }

  dimension: primary_key {
    type: string
    sql: CONCAT(${batch}, ${task_id})  ;;
    primary_key: yes
    hidden: yes
  }

  dimension_group: batch_checkout_at {
    type: time
    description: "Timestamp the task was checked-out"
  }

  dimension: task_id {
    type: string
  }

  dimension: id {
    type: string
  }

  dimension: user {
    type: string
    description: "The user completing the task"
  }

  dimension: queue {
    type: string
  }

  dimension: queue_id {
    type: string
    hidden: yes
  }

  dimension: avg_handling_time_sec {
    type: number
    sql: ${TABLE}.avg_duration_sec ;;
    description: "Average duration to process (route or close) the task"
  }

  dimension: total_duration_sec {
    type: number
    description: "How long the entire batch of tasks took to process (route or close)"
  }

  dimension: batch_size {
    type: number
    description: "How many tasks were claimed in the batch"
  }

  dimension: user_workday_location {
    type: string
    description: "Agent's Location as defined by Workday"
    sql: ${TABLE}.workday_location ;;
  }

  dimension: user_roster_sheet_location {
    type: string
    description: "Agent's Location as defined by the Roster File Spreadsheet"
    sql: ${TABLE}.sheet_location ;;
  }

  dimension: user_roster_sheet_language_fulfilled {
    type: string
    description: "Agent's Language fulfilled as defined by the Roster File Spreadsheet"
    sql: ${TABLE}.sheet_language_fulfilled ;;
  }

  dimension: agent_position {
    type: string
    group_label: "Agent Attributes"
    label: "Agent Position (Sheet)"
    description: "The business title/position/role of agent in Roster Gsheet"
    sql: ${TABLE}.sheet_position;;
  }

  dimension: agent_position_ {
    type: string
    group_label: "Agent Attributes"
    label: "Agent Position (Workday)"
    description: "The business title/position/role of agent in Workday"
    sql: ${TABLE}.workday_position;;
  }

  dimension: tier_category {
    type: string
    group_label: "Customized Tier"
    hidden: yes
    sql:
        CASE WHEN (${TABLE}.queue IN ('Public User Stories - Remote', 'Maps', 'Maps - Remote', 'Spotlight UGC - Remote', 'Search', 'Topic Story - Remote', 'Accenture Escalations')
             or ${TABLE}.queue CONTAINS 'Remote')
             THEN 'Tier1'
             WHEN ${TABLE}.queue NOT IN ('Remote','Map','Search','LEO','NCMEC','Accenture Escalations')
             THEN 'Tier2'
             WHEN ( ${TABLE}.queue  CONTAINS 'NCMEC' OR  ${TABLE}.queue  CONTAINS 'LEO' OR ${TABLE}.queue = 'Lead Escalation')
             THEN 'Tier3'
             END
    ;;
  }

  measure: total_duration_sec_sum {
    type: sum_distinct
    sql: ${TABLE}.total_duration_sec ;;
    drill_fields: [details*]
    sql_distinct_key: ${batch} ;;
  }

  measure: total_handled_tasks {
    type: sum_distinct
    description: "Sum of all batch sizes"
    sql: ${TABLE}.batch_size ;;
    sql_distinct_key: ${batch} ;;
    drill_fields: [details*]
  }

  measure: avg_handling_time_sec_avg {
    type: number
    sql: ${total_duration_sec_sum} / ${total_handled_tasks} ;;
    value_format_name: "decimal_1"
    drill_fields: [details*]
  }

  measure: avg_handling_time_sec_p50 {
    type: percentile
    percentile: 50
    sql: ${avg_handling_time_sec} ;;
    value_format_name: "decimal_1"
    drill_fields: [details*]
  }

  measure: avg_handling_time_sec_p90 {
    type: percentile
    percentile: 90
    sql: ${avg_handling_time_sec} ;;
    value_format_name: "decimal_1"
    drill_fields: [details*]
  }

  set: details {
    fields: [
      batch,
      id,
      task_id,
      avg_handling_time_sec,
      batch_size,
      total_duration_sec,
      queue
    ]
  }

}
