view: zendesk_ticket_events {
  derived_table: {
    sql: SELECT *, JSON_EXTRACT(child_json,'$.added_tags') as a_t FROM [sc-analytics:report_zendesk.ticket_events]
           WHERE {% condition partition_filter %} _PARTITIONTIME {% endcondition %}
          ;;
  }

###################
##   FILTERS     ##
###################
  filter: partition_filter {
    label: "Event Date Filter"
    type: date
    default_value: "7 days ago for 7 days"
  }

###################
##   DIMENSIONS  ##
###################
  dimension: id {
    hidden: yes
  }

  dimension: agent_email {
    sql: ${zendesk_agent.email} ;;
  }

  dimension: agent_tags {
    sql: ${zendesk_agent.tags} ;;
  }

  dimension: updater_id {
    hidden: yes
  }

  dimension: event_type {
    type: string
  }

  dimension: via {
    type: string
  }

  dimension_group: updated_at  {
    type: time
    description: "UTC"
  }

  dimension_group: updated_at_pst  {
    type: time
    description: "PST (-7)"
    sql: DATE_ADD(${TABLE}.updated_at, -7, "HOUR" ) ;;
  }

  dimension: tenure_bucket {
    description: "Tenure based on hire date (3 months, 6 months, 12 months, 18 months or more)"
    case: {
      when: {
        label: "<3 months"
        sql: DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) < 30*3 ;;
      }
      when: {
        label: "3-6 months"
        sql: DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) >= 30*3
          AND DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) < 30*6 ;;
      }
      when: {
        label: "6-12 months"
        sql: DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) >= 30*6
          AND DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) < 30*12 ;;
      }
      when: {
        label: "12-18 months"
        sql: DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) >= 30*12
          AND DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) < 30*18 ;;
      }
      when: {
        label: "18+ months"
        sql: DATEDIFF(DATE(${TABLE}.updated_at),${custops_fte_vendor_users.hire_date}) >= 30*18 ;;
      }
    }
    type: string
  }

  dimension: _updated_at  {
    type: string
    hidden: yes
  }

  dimension: created_at {
    hidden: yes
  }

  dimension: ticket_id {
    type: number
  }

  dimension: event_id {
    type: number
    sql: ${id} ;;
  }

  dimension: url {
    type: string
    label: "Ticket URL"
    sql: CONCAT('https://snapchat.zendesk.com/agent/tickets/',STRING(${TABLE}.ticket_id)) ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: child_id {
    primary_key: yes
  }

  dimension: child_event_type {
    type: string
  }

  dimension: child_via_reference_id {
    hidden: yes
  }

  dimension: child_via {
    type: string
  }

  dimension: child_json {
    type: string
  }

  dimension: added_tags {
    description: "List of tags that were added"
    type: string
    sql: JSON_EXTRACT(${child_json},'$.added_tags') ;;
  }

  dimension: a_t {
    description: "List of tags that were added"
    type: string
    hidden: yes
  }

  dimension: removed_tags {
    description: "List of tags that were removed"
    type: string
    sql: JSON_EXTRACT(${child_json},'$.removed_tags') ;;
  }

  dimension: turnaround_action_duration_sec {
    type: number
    sql: TIMESTAMP_TO_SEC(TIMESTAMP(${TABLE}.updated_at)) - TIMESTAMP_TO_SEC(TIMESTAMP(${zendesk_ticket.created_utc_time})) ;;
  }

  dimension: turnaround_action_duration_days {
    type: number
    sql: ${turnaround_action_duration_sec}/60/60/24 ;;
  }

  dimension: time_spent_since_last_update_seconds {
    type: number
    hidden: yes
    sql: CAST(JSON_EXTRACT_SCALAR(${child_json}, '$.custom_ticket_fields.24945586') AS INTEGER) ;;
  }

  dimension: turnaround_action_duration_hr {
    type: number
    sql: ${turnaround_action_duration_sec}/60/60 ;;
  }

  dimension: finite_ndo_expiration_date {
    type: date
    label: "Finite NDO Expiration Date"
    group_label: "LEO Dimensions"
    sql: CAST(JSON_EXTRACT_SCALAR(${child_json}, '$.custom_ticket_fields.360017358552') AS DATE) ;;
  }

  dimension: lp_date {
    type: date
    label: "LP Date"
    group_label: "LEO Dimensions"
    sql: CAST(JSON_EXTRACT_SCALAR(${child_json}, '$.custom_ticket_fields.360000198503') AS DATE) ;;
  }

  dimension: federal_agency_name {
    type: string
    label: "US Federal Agency Name"
    group_label: "LEO Dimensions"
    sql: (CAST(JSON_EXTRACT_SCALAR(${child_json}, '$.custom_ticket_fields.360000223463') AS STRING)) ;;
  }

  dimension: action_type {
    type: string
    case: {
      when: {
        label: "SOLVED"
        sql: ${child_json} LIKE '%"status": "solved"%';;
      }
      when: {
        label: "PENDING"
        sql: ${child_json} LIKE '%"status": "pending"%';;
      }
      when: {
        label: "OPENED"
        sql: ${child_json} LIKE '%"status": "open"%';;
      }
      when: {
        label: "HOLD"
        sql: ${child_json} LIKE '%"status": "hold"%';;
      }
      when: {
        label: "CLOSED"
        sql: ${child_json} LIKE '%"status": "closed"%';;
      }
      when: {
        label: "DELETED"
        sql: ${child_json} LIKE '%"status": "deleted"%';;
      }
      when: {
        label: "EXTERNAL_COMMENT"
        sql: ${child_json} LIKE '%"comment_public": true%' ;;
      }
      when: {
        label: "INTERNAL_COMMENT"
        sql: ${child_json} LIKE '%"comment_public": false%' ;;
      }
      when: {
        label: "ROUTE"
        sql: ${child_json} LIKE '%"group_id": %' ;;
      }
    }
  }

  dimension: leo_case_status_action {
    type: string
    case: {
      when: {
        label: "Solved - Followup"
        sql: ${added_tags} LIKE '%leo-case-status-ac-solved-fu-%';;
      }
      when: {
        label: "Solved"
        sql: ${added_tags} LIKE '%leo-case-status-ac-solved%';;
      }
      when: {
        label: "Ready for QA"
        sql: ${added_tags} LIKE '%leo-case-status-bd-need-qa%';;
      }
      when: {
        label: "Classified"
        sql: ${added_tags} LIKE '%leo-case-status-bc-classified%';;
      }
      when: {
        label: "LE Verified"
        sql: ${added_tags} LIKE '%leo-case-status-bb-leverified%';;
      }
      when: {
        label: "Triaged"
        sql: ${added_tags} LIKE '%leo-case-status-ba-triaged%';;
      }
    }
  }

  dimension: ticket_is_classified {
    type: yesno
    hidden: no
    sql: if(${added_tags} LIKE '%leo-case-status-classified%' OR ${added_tags} LIKE '%leo-case-status-bc-classified%',true,false) ;;
  }

  dimension: ts_fte_roster_email{
    type: string
    label: "TS FTE Roster Email"
    group_label: "TS FTE Attributes"
    sql: ${ts_fte_roster_spreadsheet.email};;
  }

  dimension: ts_fte_roster_name{
    type: string
    label: "TS FTE Roster Name"
    group_label: "TS FTE Attributes"
    sql: ${ts_fte_roster_spreadsheet.name};;
  }

  dimension: ts_fte_roster_location{
    type: string
    label: "TS FTE Roster Location"
    group_label: "TS FTE Attributes"
    sql: ${ts_fte_roster_spreadsheet.location};;
  }

  dimension: ts_fte_roster_team{
    type: string
    label: "TS FTE Roster Team"
    group_label: "TS FTE Attributes"
    sql: ${ts_fte_roster_spreadsheet.team};;
  }

  dimension: ts_fte_roster_level_role{
    type: string
    label: "TS FTE Roster Level/Role"
    group_label: "TS FTE Attributes"
    sql: ${ts_fte_roster_spreadsheet.level_role};;
  }

  dimension: ts_fte_roster_active_inactive{
    type: string
    label: "TS FTE Roster Active/Inactive"
    group_label: "TS FTE Attributes"
    sql: ${ts_fte_roster_spreadsheet.active_inactive};;
  }

###################
##   MEASURES    ##
###################

  measure: count_classified_tickets {
    group_label: "LEO Measures"
    type: count_distinct
    sql: if(${ticket_is_classified}=true,${ticket_id},null) ;;
    drill_fields: [drill_fields*]
  }

  measure: count {
    type: count
    drill_fields: [drill_fields*]
  }

  measure: count_updates {
    type: count_distinct
    sql: ${id} ;;
    approximate_threshold: 10000
    drill_fields: [drill_fields*]
  }

  measure: count_unique_solved {
    description: "Unique Count of Tickets that were put in solved"
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: action_type
      value: "SOLVED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_unique_ready_qa {
    description: "(LEO) Unique Count of Tickets that were staged for QA using LEO Case Status"
    label: "Count Unique Tickets Ready QA"
    group_label: "LEO Measures"
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: leo_case_status_action
      value: "Ready for QA"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_unique_solved_2 {
    description: "(LEO) Unique Count of Tickets that Solved using LEO Case Status"
    label: "Count Unique Tickets Solved"
    group_label: "LEO Measures"
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: leo_case_status_action
      value: "Solved"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_unique_triaged {
    description: "(LEO) Unique Count of Tickets that were Triaged using LEO Case Status"
    label: "Count Unique Tickets Triaged"
    group_label: "LEO Measures"
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: leo_case_status_action
      value: "Triaged"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_unique_classified {
    description: "(LEO) Unique Count of Tickets that were Triaged using LEO Case Status"
    label: "Count Unique Tickets Classified"
    group_label: "LEO Measures"
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: leo_case_status_action
      value: "Classified"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_unique_leverified {
    description: "(LEO) Unique Count of Tickets that were LE Verified using LEO Case Status"
    label: "Count Unique Tickets LE Verified"
    group_label: "LEO Measures"
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: {
      field: leo_case_status_action
      value: "LE Verified"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_solved {
    description: "Count of how many times a ticket was put in solved"
    type: count
    filters: {
      field: action_type
      value: "SOLVED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_pending {
    description: "Count of how many times a ticket was put in pending"
    type: count
    filters: {
      field: action_type
      value: "PENDING"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_hold {
    description: "Count of how many times a ticket was put on hold"
    type: count
    filters: {
      field: action_type
      value: "HOLD"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_closed {
    description: "Count of how many times a ticket was closed"
    type: count
    filters: {
      field: action_type
      value: "CLOSED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_ticket {
    type: count_distinct
    sql: ${ticket_id} ;;
    approximate_threshold: 1000000
    drill_fields: [drill_fields*]
  }

  measure: count_opened {
    description: "Count of how many times a ticket was opened"
    type: count
    filters: {
      field: action_type
      value: "OPENED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_status_change {
    description: "Count of how many times status changed on a ticket"
    type: count
    filters: {
      field: action_type
      value: "OPENED,SOLVED,CLOSED,HOLD,PENDING,DELETED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_external_comment {
    description: "Count of agent external comments"
    type: count
    filters: {
      field: action_type
      value: "EXTERNAL_COMMENT"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_internal_comment {
    description: "Count of agent internal comments"
    type: count
    filters: {
      field: action_type
      value: "INTERNAL_COMMENT"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_user_only_comments {
    description: "Count of comments made by the user only"
    type: count
    filters: [action_type: "EXTERNAL_COMMENT", child_via: "Mail, Web service", child_event_type: "Comment", agent_email: "NULL"]
    drill_fields: [drill_fields*]
  }

  measure: count_agent_only_comments {
    description: "Count of external comments made by the agent only"
    type: number
    sql: ${count_external_comment} - ${count_user_only_comments} ;;
    drill_fields: [drill_fields*]
  }

  measure: count_tickets_internal_comment {
    description: "Count of unique tickets with an agent internal comment"
    type: number
    sql: COUNT(DISTINCT IF(${action_type}="INTERNAL_COMMENT",${ticket_id},NULL)) ;;
    drill_fields: [drill_fields*]
  }

  measure: count_tickets_external_comment {
    description: "Count of unique tickets with an agent external comment"
    type: number
    sql: COUNT(DISTINCT IF(${action_type}="EXTERNAL_COMMENT",${ticket_id},NULL)) ;;
    drill_fields: [drill_fields*]
  }

  measure: count_comment {
    description: "Count of any agent comments (external & internal)"
    type: count
    filters: {
      field: action_type
      value: "INTERNAL_COMMENT,EXTERNAL_COMMENT"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_route {
    description: "Count of how many times a ticket changed groups"
    type: count
    filters: {
      field: action_type
      value: "ROUTE"
    }
    drill_fields: [drill_fields*]
  }

  dimension: productive_action {
    type: yesno
    sql: ${action_type} IN ("SOLVED","ROUTE") ;;
  }

  measure: count_productive_actions {
    type: number
    description: "Count of Route and Solves"
    sql: SUM(CASE when ${productive_action} = true then 1 else null end) ;;
  }

  dimension: agent_date {
    type: string
    hidden: yes
    sql: concat(${agent_email},${updated_at_date}) ;;
  }

  dimension: agent_hour {
    type: string
    hidden: yes
    sql: concat(${agent_email},${updated_at_hour}) ;;
  }

  measure: avg_daily_agent_throughput {
    type: number
    value_format_name: decimal_1
    description: "Avg Throughput Per Agent Per Day (Productive Actions / Working Days)"
    sql: ${count_productive_actions}/${working_days} ;;
  }

  measure: avg_hourly_agent_throughput {
    type: number
    value_format_name: decimal_1
    description: "Avg Throughput Per Agent Per Day (Productive Actions / Working Days)"
    sql: ${count_productive_actions}/${working_hours} ;;
  }

  measure: working_days {
    type: number
    description: "Counts the unique working days (distinct count of days and agents)"
    sql: count(distinct CASE WHEN ${productive_action} = true THEN ${agent_date} else null end)  ;;
  }

  measure: working_hours {
    type: number
    description: "Counts the unique working days (distinct count of days and agents)"
    sql: count(distinct CASE WHEN ${productive_action} = true THEN ${agent_hour} else null end)  ;;
  }

  measure: average_handle_time_seconds {
    type: number
    group_label: "Handle Time Metrics"
    description: "Time spent on ticket since last update"
    value_format: "0.00"
    sql: SUM(${time_spent_since_last_update_seconds}) / ${count_ticket} ;;
  }

  measure: average_handle_time_minutes {
    type: number
    group_label: "Handle Time Metrics"
    description: "Time spent on ticket since last update"
    value_format: "0.00"
    sql: SUM(${time_spent_since_last_update_seconds}) / ${count_ticket} / 60 ;;
  }

  measure: total_handle_time_seconds {
    type: number
    group_label: "Handle Time Metrics"
    description: "Time spent on ticket since last update"
    value_format: "#,##0"
    sql: SUM(${time_spent_since_last_update_seconds}) ;;
  }

  measure: total_handle_time_hours {
    type: number
    group_label: "Handle Time Metrics"
    description: "Time spent on ticket since last update"
    value_format: "#,##0"
    sql: SUM(${time_spent_since_last_update_seconds}) / 60 / 60 ;;
  }

  measure: turnaround_action_duration_sec_ {
    type: sum
    sql: ${turnaround_action_duration_sec} ;;
  }

  measure: turnaround_action_duration_hr_ {
    type: sum
    value_format: "0.00"
    sql: ${turnaround_action_duration_hr} ;;
  }

  measure: turnaround_action_duration_days_ {
    type: sum
    value_format: "0.00"
    sql: ${turnaround_action_duration_days};;
  }

  measure: turnaround_action_duration_days_p50 {
    type: percentile
    percentile: 50
    value_format: "0.00"
    sql: ${turnaround_action_duration_days} ;;
  }

  measure: turnaround_action_duration_days_p75 {
    type: percentile
    percentile: 75
    value_format: "0.00"
    sql: ${turnaround_action_duration_days} ;;
  }

  measure: turnaround_action_duration_days_p90 {
    type: percentile
    percentile: 90
    value_format: "0.00"
    sql: ${turnaround_action_duration_days} ;;
  }

  measure: turnaround_action_duration_hr_p50 {
    type: percentile
    percentile: 50
    value_format: "0.00"
    sql: ${turnaround_action_duration_hr} ;;
  }

  measure: turnaround_action_duration_hr_p75 {
    type: percentile
    percentile: 75
    value_format: "0.00"
    sql: ${turnaround_action_duration_hr} ;;
  }

  measure: turnaround_action_duration_hr_p90 {
    type: percentile
    percentile: 90
    value_format: "0.00"
    sql: ${turnaround_action_duration_hr} ;;
  }

  measure: event_handle_time_seconds_p90 {
    type: percentile
    percentile: 90
    value_format: "0.00"
    group_label: "Handle Time Metrics"
    description: "90th percentile of time spent on ticket since last update"
    sql: ${time_spent_since_last_update_seconds} ;;
  }

  measure: tickets_per_agent_per_hr {
    type: number
    description: "Count of tickets solved per agent per hour"
    sql: (${count_solved} + ${count_route} + ${count_comment}  + ${count_pending} + ${count_hold} + ${count_opened})/ COUNT (distinct CONCAT(${agent_email}, ${updated_at_hour})) ;;
    drill_fields: [drill_fields*]
    value_format: "0"
  }

  set: drill_fields {
    fields: [
      url,
      ticket_id,
      event_type,
      child_event_type,
      action_type,
      agent_email,
      updated_at_time,
      child_json
    ]
  }

}
