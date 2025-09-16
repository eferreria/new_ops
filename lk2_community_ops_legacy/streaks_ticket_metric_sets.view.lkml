# most active contributor jbabra@snapchat.com
view: streaks_ticket_metric_sets {

  derived_table: {
    sql: SELECT
                *
          FROM TABLE_QUERY([sc-analytics:report_zendesk_snapstreaks], "table_id IN
                (SELECT table_id FROM [sc-analytics:report_zendesk_snapstreaks.__TABLES__]
                WHERE REGEXP_MATCH(table_id, r'^ticket_metric_sets_distinct_[0-9]{8}')
                ORDER BY table_id
                DESC LIMIT 1)") ;;

    }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_solved_yesterday {
    type: count
    filters: {
      field: solved_at_date
      value: "yesterday"
    }
    drill_fields: [detail*]
  }

  measure: count_solved_last_7_days{
    type: count
    filters: {
      field: solved_at_date
      value: "7 days ago for 7 days"
    }
    drill_fields: [detail*]
  }

  measure: count_created_last_7_days{
    type: count
    filters: {
      field: created_at_date
      value: "7 days ago for 7 days"
    }
    drill_fields: [detail*]
  }

  measure: count_solved_days {
    type: number
    sql:  COUNT(DISTINCT DATE(${TABLE}.solved_at), 10000) ;;
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    hidden:  yes
    sql: ${TABLE}.id ;;
  }

  dimension: ticket_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.ticket_id ;;
  }

  dimension: url {
    type: string
    sql: CONCAT('https://snapchat.zendesk.com/agent/tickets/',STRING(${TABLE}.ticket_id)) ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension_group: assignee_updated_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.assignee_updated_at,-7,"HOUR") ;;
  }

  dimension_group: requester_updated_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.requester_updated_at,-7,"HOUR") ;;
  }

  dimension_group: status_updated_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.status_updated_at,-7,"HOUR") ;;
  }

  dimension_group: initially_assigned_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.initially_assigned_at,-7,"HOUR") ;;
  }

  dimension_group: assigned_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.assigned_at,-7,"HOUR") ;;
  }

  dimension_group: solved_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.solved_at,-7,"HOUR") ;;
  }

  dimension_group: latest_comment_added_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.latest_comment_added_at,-7,"HOUR") ;;
  }

  dimension_group: created_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.created_at,-7,"HOUR") ;;
  }

  dimension_group: updated_at {
    type: time
    description: "PST"
    sql: DATE_ADD(${TABLE}.updated_at,-7,"HOUR") ;;
  }

  dimension_group: first_solved_at  {
    type: time
    description: "PST"
    sql: DATE_ADD(${created_at_time}, ${TABLE}.first_resolution_time_in_minutes_calendar, "MINUTE") ;;
  }

  dimension_group: first_solved_at_timestamp  {
    type: time
    timeframes: [date]
    hidden: yes
    description: "PST. Do not remove. Used for important calculation in zendesk_ticket view for LEO."
    sql: DATE_ADD(${created_at_time}, ${TABLE}.first_resolution_time_in_minutes_calendar, "MINUTE") ;;
  }

  dimension: ticket_replies {
    type: number
    sql: ${TABLE}.replies ;;
  }

  dimension: full_resolution_time_in_minutes_calendar {
    type: number
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
  }

  dimension: agent_wait_time_in_minutes_calendar {
    type: number
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
  }

  dimension: first_resolution_time_in_minutes_calendar {
    type: number
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
  }

  dimension: requester_wait_time_in_minutes_calendar {
    type: number
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
  }


  dimension: reply_time_in_minutes_calendar {
    type: number
    sql:  ${TABLE}.reply_time_in_minutes_calendar;;
    drill_fields: [detail*]
  }

  measure: group_stations_average {
    type: average
    value_format: "0.00"
    group_label: "Average Metrics"
    sql: ${TABLE}.group_stations ;;
    drill_fields: [detail*]
  }

  measure: assignee_stations_average {
    type: average
    value_format: "0.00"
    group_label: "Average Metrics"
    sql: ${TABLE}.assignee_stations ;;
    drill_fields: [detail*]
  }

  measure: reopens_average {
    type: average
    value_format: "0.00"
    group_label: "Average Metrics"
    sql: ${TABLE}.reopens ;;
    drill_fields: [detail*]
  }

  measure: replies_average {
    type: average
    value_format: "0.00"
    group_label: "Average Metrics"
    sql: ${TABLE}.replies ;;
    drill_fields: [detail*]
  }

  measure: first_resolution_time_in_minutes_calendar_average {
    type: average
    group_label: "Average Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: first_resolution_time_in_minutes_business_average {
  #   type: average
  #   group_label: "Average Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: reply_time_in_minutes_calendar_average {
    type: average
    group_label: "Average Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_average {
  #   type: average
  #   group_label: "Average Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_average {
    type: average
    group_label: "Average Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_average {
  #   type: average
  #   group_label: "Average Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_average {
    type: average
    group_label: "Average Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_average {
  #   type: average
  #   group_label: "Average Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_average {
    type: average
    group_label: "Average Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_average {
  #   type: average
  #   group_label: "Average Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: group_stations_median {
    type: median
    label: "Group Stations P50"
    group_label: "P50 Metrics"
    value_format: "0.00"
    sql: ${TABLE}.group_stations ;;
    drill_fields: [detail*]
  }

  measure: assignee_stations_median {
    type: median
    label: "Assignee Stations P50"
    group_label: "P50 Metrics"
    value_format: "0.00"
    sql: ${TABLE}.assignee_stations ;;
    drill_fields: [detail*]
  }

  measure: replies_median {
    type: median
    label: "Replies P50"
    group_label: "P50 Metrics"
    value_format: "0.00"
    sql: ${TABLE}.replies ;;
    drill_fields: [detail*]
  }

  measure: first_resolution_time_in_minutes_calendar_median {
    type: median
    label: "First Resolution Time In Minutes Calendar P50"
    group_label: "P50 Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: first_resolution_time_in_minutes_business_median {
  #   type: median
  #   label: "First Resolution Time In Minutes Business P50"
  #   group_label: "P50 Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: reply_time_in_minutes_calendar_median {
    type: median
    description: "Time to First Reply"
    label: "Reply Time In Minutes Calendar P50"
    group_label: "P50 Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_median {
  #   type: median
  #   description: "Time to First Reply"
  #   label: "Reply Time In Minutes Business P50"
  #   group_label: "P50 Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_median {
    type: median
    label: "Full Resolution Time In Minutes Calendar P50"
    group_label: "P50 Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_median {
  #   type: median
  #   label: "Full Resolution Time In Minutes Business P50"
  #   group_label: "P50 Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_median {
    type: median
    label: "Agent Wait Time in Minutes Calendar P50"
    group_label: "P50 Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_median {
  #   type: median
  #   label: "Agent Wait Time in Minutes Business P50"
  #   group_label: "P50 Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_median {
    type: median
    label: "Requester Wait Time in Minutes Calendar P50"
    group_label: "P50 Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_median {
  #   type: median
  #   label: "Requester Wait Time in Minutes Business P50"
  #   group_label: "P50 Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: group_stations_p95 {
    type: percentile
    percentile: 95
    group_label: "P95 Metrics"
    value_format: "0.00"
    sql: ${TABLE}.group_stations ;;
    drill_fields: [detail*]
  }

  measure: first_resolution_time_in_minutes_calendar_p95 {
    type: percentile
    percentile: 95
    group_label: "P95 Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: first_resolution_time_in_minutes_business_p95 {
  #   type: percentile
  #   percentile: 95
  #   group_label: "P95 Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: reply_time_in_minutes_calendars_p95 {
    type: percentile
    percentile: 95
    group_label: "P95 Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_p95 {
  #   type: percentile
  #   percentile: 95
  #   group_label: "P95 Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_p95 {
    type: percentile
    percentile: 95
    group_label: "P95 Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_p95 {
  #   type: percentile
  #   percentile: 95
  #   group_label: "P95 Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_p95 {
    type: percentile
    percentile: 95
    group_label: "P95 Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_p95 {
  #   type: percentile
  #   percentile: 95
  #   group_label: "P95 Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_p95 {
    type: percentile
    percentile: 95
    group_label: "P95 Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_p95 {
  #   type: percentile
  #   percentile: 95
  #   group_label: "P95 Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: first_resolution_time_in_minutes_calendar_p90 {
    type: percentile
    percentile: 90
    group_label: "P90 Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: first_resolution_time_in_minutes_business_p90 {
  #   type: percentile
  #   percentile: 90
  #   group_label: "P90 Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: reply_time_in_minutes_calendars_p90 {
    type: percentile
    percentile: 90
    group_label: "P90 Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_p90 {
  #   type: percentile
  #   percentile: 90
  #   group_label: "P90 Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_p90 {
    type: percentile
    percentile: 90
    group_label: "P90 Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_p90 {
  #   type: percentile
  #   percentile: 90
  #   group_label: "P90 Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_p90 {
    type: percentile
    percentile: 90
    group_label: "P90 Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_p90 {
  #   type: percentile
  #   percentile: 90
  #   group_label: "P90 Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_p90 {
    type: percentile
    percentile: 90
    group_label: "P90 Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_p90 {
  #   type: percentile
  #   percentile: 90
  #   group_label: "P90 Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  # measure: first_resolution_time_in_minutes_business_p75 {
  #   type: percentile
  #   percentile: 75
  #   group_label: "P75 Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: first_resolution_time_in_minutes_calendar_p75 {
    type: percentile
    percentile: 75
    group_label: "P75 Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  measure: reply_time_in_minutes_calendars_p75 {
    type: percentile
    percentile: 75
    group_label: "P75 Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_p75 {
  #   type: percentile
  #   percentile: 75
  #   group_label: "P75 Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_p75 {
    type: percentile
    percentile: 75
    group_label: "P75 Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_p75 {
  #   type: percentile
  #   percentile: 75
  #   group_label: "P75 Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_p75 {
    type: percentile
    percentile: 75
    group_label: "P75 Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_p75 {
  #   type: percentile
  #   percentile: 75
  #   group_label: "P75 Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_p75 {
    type: percentile
    percentile: 75
    group_label: "P75 Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_p75 {
  #   type: percentile
  #   percentile: 75
  #   group_label: "P75 Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  # measure: first_resolution_time_in_minutes_business_p25 {
  #   type: percentile
  #   percentile: 25
  #   group_label: "P25 Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: first_resolution_time_in_minutes_calendar_p25 {
    type: percentile
    percentile: 25
    group_label: "P25 Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  measure: reply_time_in_minutes_calendars_p25 {
    type: percentile
    percentile: 25
    group_label: "P25 Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_p25 {
  #   type: percentile
  #   percentile: 25
  #   group_label: "P25 Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_p25 {
    type: percentile
    percentile: 25
    group_label: "P25 Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_p25 {
  #   type: percentile
  #   percentile: 25
  #   group_label: "P25 Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_p25 {
    type: percentile
    percentile: 25
    group_label: "P25 Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_p25 {
  #   type: percentile
  #   percentile: 25
  #   group_label: "P25 Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_p25 {
    type: percentile
    percentile: 25
    group_label: "P25 Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_p25 {
  #   type: percentile
  #   percentile: 25
  #   group_label: "P25 Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  # measure: first_resolution_time_in_minutes_business_p99 {
  #   type: percentile
  #   percentile: 99
  #   group_label: "P99 Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: first_resolution_time_in_minutes_calendar_p99 {
    type: percentile
    percentile: 99
    group_label: "P99 Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  measure: reply_time_in_minutes_calendars_p99 {
    type: percentile
    percentile: 99
    group_label: "P99 Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_p99 {
  #   type: percentile
  #   percentile: 99
  #   group_label: "P99 Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_p99 {
    type: percentile
    percentile: 99
    group_label: "P99 Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_p99 {
  #   type: percentile
  #   percentile: 99
  #   group_label: "P99 Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_p99 {
    type: percentile
    percentile: 99
    group_label: "P99 Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_p99 {
  #   type: percentile
  #   percentile: 99
  #   group_label: "P99 Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_p99 {
    type: percentile
    percentile: 99
    group_label: "P99 Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_p99 {
  #   type: percentile
  #   percentile: 99
  #   group_label: "P99 Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: group_stations_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.group_stations ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  measure: assignee_stations_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.assignee_stations ;;
    drill_fields: [detail*]
  }

  measure: reopens_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.reopens ;;
    drill_fields: [detail*]
  }

  dimension: reopens {
    type: number
    sql: ${TABLE}.reopens;;
    drill_fields: [detail*]
  }

  dimension: reopened_ {
    type: yesno
    sql: ${TABLE}.reopens >= 1 ;;
  }

  measure: reopened {
    type: sum
    label: "Reopened Sum"
    sql: ${TABLE}.reopens >= 1 ;;
    drill_fields: [detail*]
  }

  dimension: reopens_filter {
    type: string
    sql: IF(${reopened_},${reopens}-1,0) ;;
    hidden: yes
  }

  measure: reopens_minus_first {
    type: sum
    sql: ${reopens_filter} ;;
    drill_fields: [detail*]
  }

  #tickets with 1 public agent replies

  dimension: first_contact_resolution_tickets {
    description: "Tickets with no Re-opens"
    type: yesno
    sql: CASE WHEN ${reopens} = 0 THEN TRUE
         ELSE FALSE
        END;;
  }

  measure: first_contact_resolution_tickets_count {
    type: count
    description: "Count of tickets with no Re-opens"
    filters: {
      field: first_contact_resolution_tickets
      value: "yes"
    }
    drill_fields: [detail*]
  }

  measure: first_contact_resolution_tickets_percent {
    type: number
    description: "Percent of tickets with no Re-opens"
    value_format_name: percent_1
    sql: ${first_contact_resolution_tickets_count}/${count} ;;
    drill_fields: [detail*]
  }

  measure: count_tickets_first_resolution_time_within_48hr {
    type: count
    filters: {
      field: first_resolution_time_in_minutes_calendar
      value: "<=2880"
    }
    drill_fields: [detail*]
  }

  measure: percent_tickets_first_resolution_time_within_48hr {
    type: number
    sql: ${count_tickets_first_resolution_time_within_48hr}/${count} ;;
    value_format_name: percent_0
    drill_fields: [detail*]
  }

  measure: count_tickets_first_resolution_time_within_24hr {
    type: count
    filters: {
      field: first_resolution_time_in_minutes_calendar
      value: "<=1440"
    }
    drill_fields: [detail*]
  }

  measure: percent_tickets_first_resolution_time_within_24hr {
    type: number
    sql: ${count_tickets_first_resolution_time_within_24hr}/${count} ;;
    value_format_name: percent_0
    drill_fields: [detail*]
  }

  measure: count_tickets_first_resolution_time_within_12hr {
    type: count
    filters: {
      field: first_resolution_time_in_minutes_calendar
      value: "<=720"
    }
    drill_fields: [detail*]
  }

  measure: percent_tickets_first_resolution_time_within_12hr {
    type: number
    sql: ${count_tickets_first_resolution_time_within_12hr}/${count} ;;
    value_format_name: percent_0
    drill_fields: [detail*]
  }

  measure: replies_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.replies ;;
    drill_fields: [detail*]
  }

  measure: first_resolution_time_in_minutes_calendar_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: first_resolution_time_in_minutes_business_sum {
  #   type: sum
  #   group_label: "Sum Metrics"
  #   sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: reply_time_in_minutes_calendar_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.reply_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: reply_time_in_minutes_business_sum {
  #   type: sum
  #   group_label: "Sum Metrics"
  #   sql: ${TABLE}.reply_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: full_resolution_time_in_minutes_calendar_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: full_resolution_time_in_minutes_business_sum {
  #   type: sum
  #   group_label: "Sum Metrics"
  #   sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: agent_wait_time_in_minutes_calendar_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: agent_wait_time_in_minutes_business_sum {
  #   type: sum
  #   group_label: "Sum Metrics"
  #   sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  measure: requester_wait_time_in_minutes_calendar_sum {
    type: sum
    group_label: "Sum Metrics"
    sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
    drill_fields: [detail*]
    value_format: "0"
  }

  # measure: requester_wait_time_in_minutes_business_sum {
  #   type: sum
  #   group_label: "Sum Metrics"
  #   sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
  #   drill_fields: [detail*]
  #   value_format: "0"
  # }

  dimension: row_order {
    type: number
    hidden: yes
    sql: ${TABLE}.row_order ;;
  }

  set: detail {
    fields: [
      ticket_id,
      url,
      group_stations_average,
      assignee_stations_average,
      reopens_average,
      replies_average,
      first_resolution_time_in_minutes_calendar_median,
      reply_time_in_minutes_calendar_median,
      full_resolution_time_in_minutes_calendar_median,
      agent_wait_time_in_minutes_calendar_median,
      requester_wait_time_in_minutes_calendar_median,
    ]
  }


  # UNION QUERY BELOW

#   SELECT *
# from  [sc-analytics:report_zendesk_snapstreaks.ticket_metric_sets_distinct_20210917]
# ,
# (SELECT
# m.id as id,
# m.ticket_id as ticket_id,
# m.url as url,
# m.group_stations as group_stations,
# m.assignee_stations as assignee_stations,
# m.reopens as reopens,
# m.replies as replies,
# m.assignee_updated_at as assignee_updated_at,
# m.requester_updated_at as requester_updated_at,
# m.status_updated_at as status_updated_at,
# m.initially_assigned_at as initially_assigned_at,
# m.assigned_at as assigned_at,
# m.solved_at as solved_at,
# m.latest_comment_added_at as latest_comment_added_at,
# m.first_resolution_time_in_minutes_calendar as first_resolution_time_in_minutes_calendar,
# m.first_resolution_time_in_minutes_business as first_resolution_time_in_minutes_business,
# m.reply_time_in_minutes_calendar as reply_time_in_minutes_calendar,
# m.reply_time_in_minutes_business as reply_time_in_minutes_business,
# m.full_resolution_time_in_minutes_calendar as full_resolution_time_in_minutes_calendar,
# m.full_resolution_time_in_minutes_business as full_resolution_time_in_minutes_business,
# m.agent_wait_time_in_minutes_calendar as agent_wait_time_in_minutes_calendar,
# m.agent_wait_time_in_minutes_business as agent_wait_time_in_minutes_business,
# m.requester_wait_time_in_minutes_calendar as requester_wait_time_in_minutes_calendar,
# m.requester_wait_time_in_minutes_business as requester_wait_time_in_minutes_business,
# m.created_at as created_at,
# m.updated_at as updated_at,
# m.execution_date as execution_date,

# FROM [sc-analytics:report_zendesk.ticket_metric_sets_distinct_20210917]  m
# left join [sc-analytics:report_zendesk.ticket_distinct] t
# on m.ticket_id = t.id
# left join  [sc-analytics:report_zendesk.ticket_forms_20210916] f
# on f.id = t.ticket_form_id

# where t.ticket_form_id = 149423
# )


  }
