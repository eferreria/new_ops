view: taskservice_incremental_turnaround_times {
  derived_table: {
    sql: SELECT itt.task_id AS task_id,
                itt.event_start AS event_start,
                itt.event_end AS event_end,
                itt.eval_start AS eval_start,
                itt.eval_end AS eval_end,
                itt.user_start AS user_start,
                itt.user_end AS user_end,
                itt.queue_start AS queue_start,
                itt.queue_end AS queue_end,
                itt.id_start AS id_start,
                itt.id_end AS id_end,
                itt.turnaround_duration_sec AS turnaround_duration_sec,
                roster.sheet_location AS sheet_location,
                roster.workday_location AS workday_location,
                roster.sheet_language_fulfilled AS sheet_language_fulfilled,
                roster.sheet_position AS sheet_position,
                roster.workday_title AS workday_title
         FROM
             [sc-analytics:report_customer_ops.taskservice_incremental_turnaround_times] itt
         LEFT JOIN ${custops_fte_vendor_users.SQL_TABLE_NAME} AS roster
        ON roster.email = itt.user_end ;;
                }

  parameter: n_hours {
    type: number
    default_value: "3"
    description: "User this fitler when applying a TAT within N hours"
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

  dimension: task_id {
    type: string
  }

  dimension: event_start {
    type: string
    description: "Event starting the review"
  }

  dimension: event_end {
    type: string
    description: "Event ending the review"
  }

  dimension_group: evaluation_start_at {
    type: time
    description: "UTC"
    sql: ${TABLE}.eval_start ;;
  }

  dimension_group: evaluation_end_at {
    type: time
    description: "UTC"
    sql: ${TABLE}.eval_end ;;
  }

  dimension: user_start {
    type: string
    description: "User starting the review"
  }

  dimension: user_end {
    type: string
    description: "User ending the review"
  }

  dimension: queue_start {
    type: string
    description: "Queue where review started"
  }

  dimension: queue_end {
    type: string
    description: "Queue where review ended"
  }

  dimension: id_start {
    primary_key: yes
    hidden: yes
  }

  dimension: id_end {
    hidden: yes
  }

  dimension: turnaround_duration_hr {
    type: number
    sql: ${TABLE}.turnaround_duration_sec / 60 / 60 ;;
    hidden: yes
    value_format: "0.00"
  }

  dimension_group: turnaround_duration_hr_grouped {
    type: duration
    intervals: [hour]
    sql_start: ${TABLE}.eval_start ;;
    sql_end: ${TABLE}.eval_end ;;
  }

  dimension: is_advertiser_experience_event {
    type: yesno
    sql: ${addressed_from_create} OR (${agent_addressed_reopen} AND ${queue_start} NOT IN ('Snap Ads - Escalation User Flagged Re-Review', 'Snap Ads - Escalation URL Re-Review')) ;;
  }

  dimension: is_user_end_cw {
    type: yesno
    sql: ${user_end} CONTAINS '@c.snap.com' ;;
  }

  dimension: agent_addressed {
    label: "Agent Addressed"
    description: "Closing actions performed by agents upon an open task where the review is initiated by the system"
    type: yesno
    sql: (${user_end} CONTAINS '@snapchat.com' OR ${user_end} CONTAINS '@c.snap.com')
      AND ((NOT ${user_start} CONTAINS '@snapchat.com' OR NOT ${user_start} CONTAINS '@c.snap.com') OR ${user_start} IS NULL) ;;
  }

  dimension: agent_overturn_addressed {
    label: "Agent Redecide Addressed"
    description: "Task is reopened by agent and closed by agent"
    type: yesno
    sql: (${user_end} CONTAINS '@snapchat.com' OR ${user_end} CONTAINS '@c.snap.com')
      AND (${user_start} CONTAINS '@snapchat.com' OR ${user_start} CONTAINS '@c.snap.com') ;;
  }

  dimension: addressed_from_reopen {
    type: yesno
    sql: ${event_start} = 'CHANGE_TASK_STATUS' ;;
  }

  dimension: agent_addressed_reopen {
    description: "Closing actions performed by agents upon a previously system-reoepened task"
    type: yesno
    sql: ${agent_addressed} AND ${addressed_from_reopen} ;;
  }

  dimension: agent_addressed_from_create {
    description: "Closing actions performed by agents upon a previously system-created task"
    type: yesno
    sql: ${agent_addressed} AND ${event_start} IN ('CREATE','ENABLE_TASK') ;;
  }

  dimension: addressed_from_create {
    type: yesno
    description: "Closing actions performed by any actor (agent or system) upon a previously system-created task"
    sql: ${event_start} IN ('CREATE','ENABLE_TASK') ;;
  }

  measure: turnaround_duration_hr_p50 {
    group_label: "Other TATs"
    type: percentile
    percentile: 50
    sql: ${turnaround_duration_hr} ;;
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: turnaround_duration_hr_p90 {
    group_label: "Other TATs"
    type: percentile
    percentile: 90
    sql: ${turnaround_duration_hr} ;;
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: count_advertiser_experience_within_2hr {
    type: count
    group_label: "Advertiser Experience Measures"
    filters: {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    filters: {
      field: turnaround_duration_hr
      value: "<=2"
    }
    hidden: yes
  }

  measure: count_advertiser_experience_within_2hr_cw {
    type: count
    group_label: "Advertiser Experience Measures"
    filters: {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    filters: {
      field: turnaround_duration_hr
      value: "<=2"
    }
    filters: {
      field: is_user_end_cw
      value: "Yes"
    }
    hidden: yes
  }

  measure: count_advertiser_experience_within_8hr {
    type: count
    group_label: "Advertiser Experience Measures"
    filters: {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    filters: {
      field: turnaround_duration_hr
      value: "<=8"
    }
    hidden: yes
  }

  measure: count_advertiser_experience_within_n_hr {
    type: sum
    group_label: "Advertiser Experience Measures"
    sql: IF(${turnaround_duration_hr} <= {% parameter n_hours %}, 1, 0) ;;
    filters: {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    description: "Count of tasks with advertiser experience review time less than or equal to N hours"
    drill_fields: [details*]
  }

  measure: pct_advertiser_experience_within_2hr {
    type: number
    sql: ${count_advertiser_experience_within_2hr} / ${count_advertiser_experience_event} ;;
    group_label: "Advertiser Experience Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }

  measure: pct_advertiser_experience_within_2hr_cw {
    type: number
    sql: ${count_advertiser_experience_within_2hr_cw} / ${count_advertiser_experience_event} ;;
    group_label: "Advertiser Experience Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }


  measure: pct_advertiser_experience_within_2hr_cw_both {
    type: number
    sql: ${count_advertiser_experience_within_2hr_cw} / ${count_advertiser_experience_event_cw} ;;
    group_label: "Advertiser Experience Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }


  measure: pct_advertiser_experience_within_8hr {
    type: number
    sql: ${count_advertiser_experience_within_8hr} / ${count_advertiser_experience_event} ;;
    group_label: "Advertiser Experience Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }

  measure: pct_advertiser_experience_within_n_hr {
    type: number
    sql: ${count_advertiser_experience_within_n_hr} / ${count_advertiser_experience_event} ;;
    group_label: "Advertiser Experience Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }

  measure: advertiser_experience_turnaround_duration_hr_p50 {
    type: percentile
    group_label: "Advertiser Experience Measures"
    percentile: 50
    sql: ${turnaround_duration_hr} ;;
    filters:  {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: advertiser_experience_turnaround_duration_hr_p100 {
    type: max
    group_label: "Advertiser Experience Measures"
    sql: ${turnaround_duration_hr} ;;
    filters:  {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: advertiser_experience_turnaround_duration_hr_p99 {
    type: percentile
    group_label: "Advertiser Experience Measures"
    percentile: 99
    sql: ${turnaround_duration_hr} ;;
    filters:  {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: advertiser_experience_turnaround_duration_hr_p95 {
    type: percentile
    group_label: "Advertiser Experience Measures"
    percentile: 95
    sql: ${turnaround_duration_hr} ;;
    filters:  {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: advertiser_experience_turnaround_duration_hr_p90 {
    type: percentile
    group_label: "Advertiser Experience Measures"
    percentile: 90
    sql: ${turnaround_duration_hr} ;;
    filters:  {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: advertiser_experience_turnaround_duration_hr_p75 {
    type: percentile
    group_label: "Advertiser Experience Measures"
    percentile: 75
    sql: ${turnaround_duration_hr} ;;
    filters:  {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: agent_addressed_turnaround_duration_hr_p50 {
    type: percentile
    percentile: 50
    sql: ${turnaround_duration_hr} ;;
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    group_label: "Agent-only Measures"
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: agent_addressed_turnaround_duration_hr_p90 {
    type: percentile
    percentile: 90
    sql: ${turnaround_duration_hr} ;;
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    group_label: "Agent-only Measures"
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: count_agent_addressed_within_2hr {
    type: count
    approximate_threshold: 10000000
    group_label: "Agent-only Measures"
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    filters: {
      field: turnaround_duration_hr
      value: "<=2"
    }
    # sql:  ;;
    hidden: yes
  }

  measure: count_agent_addressed_within_8hr {
    type: count
    group_label: "Agent-only Measures"
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    filters: {
      field: turnaround_duration_hr
      value: "<=8"
    }
    hidden: yes
  }

  measure: pct_agent_addressed_within_2hr {
    type: number
    sql: ${count_agent_addressed_within_2hr} / ${count_agent_addressed} ;;
    group_label: "Agent-only Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }

  measure: pct_agent_addressed_within_8hr {
    type: number
    sql: ${count_agent_addressed_within_8hr} / ${count_agent_addressed} ;;
    group_label: "Agent-only Measures"
    value_format: "0.00%"
    drill_fields: [details*]
  }

  measure: agent_addressed_from_create_turnaround_duration_hr_p50 {
    type: percentile
    percentile: 50
    sql: ${turnaround_duration_hr} ;;
    filters: {
      field: agent_addressed_from_create
      value: "Yes"
    }
    group_label: "Agent-only Measures"
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: agent_addressed_from_create_turnaround_duration_hr_p90 {
    type: percentile
    percentile: 90
    sql: ${turnaround_duration_hr} ;;
    filters: {
      field: agent_addressed_from_create
      value: "Yes"
    }
    group_label: "Agent-only Measures"
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: agent_addressed_reopen_turnaround_duration_hr_p50 {
    type: percentile
    percentile: 50
    sql: ${turnaround_duration_hr} ;;
    filters: {
      field: agent_addressed_reopen
      value: "Yes"
    }
    group_label: "Agent-only Measures"
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: agent_addressed_reopen_turnaround_duration_hr_p90 {
    type: percentile
    percentile: 90
    sql: ${turnaround_duration_hr} ;;
    filters: {
      field: agent_addressed_reopen
      value: "Yes"
    }
    group_label: "Agent-only Measures"
    value_format: "0.00"
    drill_fields: [details*]
  }

  measure: addressed_from_create_turnaround_duration_hr_p50 {
    group_label: "Other TATs"
    type: percentile
    percentile: 50
    sql: ${turnaround_duration_hr} ;;
    value_format: "0.00"
    drill_fields: [details*]
    filters: {
      field: addressed_from_create
      value: "yes"
    }
  }

  measure: addressed_from_create_turnaround_duration_hr_p90 {
    group_label: "Other TATs"
    type: percentile
    percentile: 90
    sql: ${turnaround_duration_hr} ;;
    value_format: "0.00"
    drill_fields: [details*]
    filters: {
      field: addressed_from_create
      value: "yes"
    }
  }

  measure: count_addressed {
    description: "Addressed by Agent or Automation"
    label: "Addressable Volume"
    type: count_distinct
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    drill_fields: [details*]
  }

  measure: count_advertiser_experience_event {
    type: count_distinct
    group_label: "Advertiser Experience Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: is_advertiser_experience_event
      value: "Yes"
    }
  }


  measure: count_advertiser_experience_event_cw {
    type: count_distinct
    group_label: "Advertiser Experience Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: is_advertiser_experience_event
      value: "Yes"
    }
    filters: {
      field: is_user_end_cw
      value: "Yes"
    }
  }

  measure: count_agent_addressed {
    type: count_distinct
    group_label: "Agent-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    drill_fields: [details*]
  }

  measure: count_agent_addressed_vendor {
    type: count_distinct
    group_label: "Agent-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    filters: {
      field: user_end
      value: "%@c.snap.com"
    }
    drill_fields: [details*]
    description: "Items actioned by vendors (@c.snap.com)"
  }

  measure: count_agent_addressed_rft {
    type: count_distinct
    label: "Count Agent Addressed RFT"
    group_label: "Agent-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: agent_addressed
      value: "Yes"
    }
    filters: {
      field: user_end
      value: "%@snapchat.com"
    }
    drill_fields: [details*]
    description: "Items actioned by regular full time employees (@snapchat.com)"
  }

  measure: count_agent_addressed_from_create {
    type: count_distinct
    group_label: "Agent-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: addressed_from_create
      value: "Yes"
    }
    filters: {
      field: agent_addressed
      value: "Yes"
    }
  }

  measure: count_automation_addressed_from_create {
    type: count_distinct
    group_label: "Automation-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: addressed_from_create
      value: "Yes"
    }
    filters: {
      field: agent_addressed
      value: "No"
    }
  }

  measure: count_automation_addressed {
    type: count_distinct
    drill_fields: [details*]
    group_label: "Automation-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: agent_addressed
      value: "No"
    }
  }

  measure: count_automation_addressed_from_reopen {
    type: count_distinct
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    group_label: "Automation-only Measures"
    filters: {
      field: addressed_from_create
      value: "No"
    }
    filters: {
      field: agent_addressed
      value: "No"
    }
  }

  measure: count_agent_addressed_reopen {
    type: count_distinct
    group_label: "Agent-only Measures"
    approximate_threshold: 10000000
    sql: ${id_start} ;;
    filters: {
      field: agent_addressed_reopen
      value: "Yes"
    }
    drill_fields: [details*]
  }

  set: details {
    fields: [
      task_id,
      event_start,
      user_start,
      user_end,
      evaluation_start_at_time,
      evaluation_end_at_time,
      turnaround_duration_hr
    ]
  }

}
