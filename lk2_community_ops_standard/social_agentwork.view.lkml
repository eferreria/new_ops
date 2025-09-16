# most active contributor abenharosh@snapchat.com
view: social_agentwork {
view_label: "Social Handle Time"
  derived_table: {

    sql:  SELECT
                id,
                work_item_id,
                handle_time,
                accept_date_time,
                active_time,
                agent_capacity_when_declined,
                cancel_date_time,
                capacity_percentage,
                capacity_weight,
                created_by_id,
                created_date,
                decline_date_time,
                decline_reason,
                last_modified_date,
                request_date_time,
                speed_to_answer,
                system_modstamp,
                user_id,
                assigned_date_time

          FROM
           `sc-analytics.prod_metadata_crm_co.agent_work_20240221`

          UNION ALL

          SELECT
                ht.CASE_ID_DIM_0 as id,
                ht.CASE_ID_DIM_0 as work_item_id,
                CAST(ht.M_CaseProcessingSLAReport_AVERAGE_CASE_HANDLE_TIME2282_0/1000 as STRING) as handle_time,
                NULL as accept_date_time,
                NULL as active_time,
                NULL as agent_capacity_when_declined,
                NULL as cancel_date_time,
                NULL as capacity_percentage,
                NULL as capacity_weight,
                NULL as created_by_id,
                NULL as created_date,
                NULL as decline_date_time,
                NULL as decline_reason,
                NULL as last_modified_date,
                NULL as request_date_time,
                NULL as speed_to_answer,
                NULL as system_modstamp,
                NULL as user_id,
                CAST(TIMESTAMP_MILLIS(CAST(hs.min_assigned_time as INT64)) AS STRING) as assigned_date_time


          FROM
           `sc-sprinklr.prod_metadata_sprinklr.cases_handle_time` AS ht
          LEFT JOIN (SELECT
                      CASE_NUMBER_0 as case_id,
                      MIN(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4) as min_assigned_time
                      FROM `sc-sprinklr.prod_metadata_sprinklr.case_history`
                      WHERE 1=1
                      AND CUSTOM_PROPERTY_FIELD_NAME_2='Status'
                      AND CUSTOM_PROPERTY_VALUE_3='Assigned'
                      GROUP BY 1)  AS hs on hs.case_id=ht.CASE_ID_DIM_0



--WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', CURRENT_DATE("America/Los_Angeles"))
          ;;
    }

  dimension_group: accept_date_time {
    type: time
    label: "Accept date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.accept_date_time AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: active_time {
    group_label: "Metrics"
    sql: CAST(${TABLE}.active_time AS FLOAT64) ;;
    description: "The amount of time an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    type: number
    hidden: yes
  }

  dimension: agent_capacity_when_declined {
    group_label: "Metrics"
    sql: CAST(${TABLE}.agent_capacity_when_declined AS FLOAT64) ;;
    description: ""
    type: number
    hidden: yes
  }

  dimension_group: assigned_date_time {
    type: time
    label: "Assigned date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.assigned_date_time AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: no
    convert_tz: no
  }

  dimension_group: cancel_date_time {
    type: time
    label: "Cancel date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.cancel_date_time AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: capacity_percentage {
    group_label: "Metrics"
    sql: CAST(${TABLE}.capacity_percentage AS FLOAT64) ;;
    description: ""
    type: number
    hidden: yes
  }

  dimension: capacity_weight {
    group_label: "Metrics"
    sql: CAST(${TABLE}.capacity_weight AS FLOAT64) ;;
    description: "The amount of an agent’s capacity for work items that’s consumed by a work item from this service channel."
    type: number
    hidden: yes
  }

  dimension_group: close_date_time {
    type: time
    label: "Close date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.close_date_time AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: created_by_id {
    type: string
    sql: ${TABLE}.created_by_id ;;
    hidden: yes
  }

  dimension_group: created_date {
    type: time
    label: "Created date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension_group: decline_date_time {
    type: time
    label: "Decline date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.decline_date_time AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: decline_reason {
    type: string
    sql: ${TABLE}.decline_reason ;;
    case_sensitive: no
    hidden: yes
  }

  dimension: handle_time {
    sql: round(CAST(${TABLE}.handle_time AS FLOAT64),0) ;;
    label: "Handle Time (Seconds)"
    value_format: "0"
    description: "The amount of time in seconds an agent had the work item open."
    type: number
  }

  dimension: handle_time_miutes {
    sql: round(${handle_time}/60,1) ;;
    label: "Handle Time (Minutes)"
    value_format: "0.0"
    description: "The amount of time in minutes an agent had the work item open."
    type: number
  }

  dimension: handle_time_inclusion {
    type: yesno
    hidden: no
    sql: CASE WHEN CAST(${TABLE}.handle_time AS FLOAT64) < 3600 THEN TRUE ELSE FALSE END ;;
    label: "Handle Time Inclusion"
    description: "filter to exclude handle times over 60 minutes from Sprinklr due to issue of handle time counters continuing to record after case is solved"
  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: is_deleted {
    hidden: yes
  }

  dimension: last_modified_by_id {
    hidden: yes
  }

  dimension_group: last_modified_date {
    type: time
    label: "Last Modified date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.last_modified_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: name {
    hidden: yes
  }

  dimension_group: request_date_time {
    type: time
    label: "Last Modified date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.request_date_time AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: routing_model {
    hidden: yes
  }

  dimension: routing_priority {
    hidden: yes
  }

  dimension: routing_type {
    hidden: yes
  }

  dimension: service_channel_id {
    hidden: yes
  }

  dimension: should_skip_capacity_check {
    hidden: yes
  }

  dimension: speed_to_answer {
    group_label: "Metrics"
    sql: CAST(${TABLE}.speed_to_answer AS FLOAT64) ;;
    description: "The amount of time in seconds between when the work was requested and when an agent accepted it."
    type: number
    hidden: yes
  }

  dimension: status {
    hidden: yes
  }

  dimension_group: system_modstamp {
    type: time
    label: "System date PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.system_modstamp AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
    hidden: yes
    convert_tz: no
  }

  dimension: user_id {
    hidden: yes
  }

  dimension: work_item_id {
    label: "Case ID"
    hidden: no
  }

#MEASURES

  measure: count {
    type: count_distinct
    sql: ${TABLE}.work_item_id;;
  }

# SUM
  measure: sum_active_time {
    type: sum
    group_label: "Sum"
    label: "Active Time"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${active_time} ;;
    description: "The amount of time in seconds an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: sum_handle_time {
    type: sum
    group_label: "Sum"
    label: "Handle Time (Seconds) Sum"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time} ;;
    description: "The sum of time in seconds an agent had the work item open."
  }

  measure: sum_speed_to_answer {
    type: sum
    group_label: "Sum"
    label: "Speed to Answer"
    value_format: "0"
    sql: ${speed_to_answer} ;;
    description: "Sum time in seconds between when the work was requested and when an agent accepted it."
    hidden: yes
  }

  #SUM HOURS

  measure: sum_active_time_hrs {
    type: sum
    group_label: "Sum"
    label: "Active Time Hrs"
    value_format: "0"
    sql: ${active_time}/3600 ;;
    description: "The amount of time in hrs an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: sum_handle_time_hrs {
    type: sum
    group_label: "Sum"
    label: "Handle Time (Hours) Sum"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time}/3600 ;;
    description: "The sum amount of time in hrs an agent had the work item open."
  }

  measure: sum_speed_to_answer_hrs {
    type: sum
    group_label: "Sum"
    label: "Speed to Answer Hrs"
    value_format: "0"
    sql: ${speed_to_answer}/3600 ;;
    description: "Sum time in hrs between when the work was requested and when an agent accepted it."
    hidden: yes
  }


# AVG

  measure: avg_active_time {
    type: average
    group_label: "Average"
    label: "Active Time"
    value_format: "0"
    sql: ${active_time} ;;
    description: "The amount of time in seconds an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: avg_handle_time {
    type: average
    group_label: "Average"
    label: "Handle Time (Seconds) Average"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time} ;;
    description: "The average amount of time in seconds an agent had the work item open."

  }

  measure: avg_speed_to_answer {
    type: average
    group_label: "Average"
    label: "Speed to Answer"
    value_format: "0"
    sql: ${speed_to_answer} ;;
    description: "AVG time in seconds between when the work was requested and when an agent accepted it."
    hidden: yes
  }


# AVG MINUTES

  measure: avg_active_time_m {
    type: average
    group_label: "Average"
    label: "Active Time minutes"
    value_format: "0"
    sql: ${active_time}/60 ;;
    description: "The amount of time in minutes an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: avg_handle_time_m {
    type: average
    group_label: "Average"
    label: "Handle Time (Minutes) Average"
    value_format: "0.0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time}/60 ;;
    description: "The averae amount of time in minutes an agent had the work item open."

  }

  measure: avg_speed_to_answer_m {
    type: average
    group_label: "Average"
    label: "Speed to Answer minutes"
    value_format: "0"
    sql: ${speed_to_answer}/60 ;;
    description: "AVG time in minutes between when the work was requested and when an agent accepted it."
    hidden: yes
  }

  #MEDIAN

  measure: mdn_active_time {
    type: median
    group_label: "Median"
    label: "Active Time"
    value_format: "0"
    sql: ${active_time} ;;
    description: "The amount of time in seconds an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: mdn_handle_time {
    type: median
    group_label: "Median"
    label: "Handle Time (Seconds) Median"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time} ;;
    description: "The median of time in seconds an agent had the work item open."
  }

  measure: mdn_speed_to_answer {
    type: median
    group_label: "Median"
    label: "Speed to Answer"
    value_format: "0"
    sql: ${speed_to_answer} ;;
    description: "Median time in seconds between when the work was requested and when an agent accepted it."
    hidden: yes
  }

  #MEDIAN MINUTES

  measure: mdn_active_time_m {
    type: median
    group_label: "Median"
    label: "Active Time minutes"
    value_format: "0"
    sql: ${active_time}/60 ;;
    description: "The amount of time in minutes an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: mdn_handle_time_m {
    type: median
    group_label: "Median"
    label: "Handle Time (Minutes) Median"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time}/60 ;;
    description: "The median amount of time in minutes an agent had the work item open."
  }

  measure: mdn_speed_to_answer_m {
    type: median
    group_label: "Median"
    label: "Speed to Answer minutes"
    value_format: "0"
    sql: ${speed_to_answer}/60 ;;
    description: "Median time in minutes between when the work was requested and when an agent accepted it."
    hidden: yes
  }

  #P90

  measure: p90_active_time {
    type: percentile
    percentile: 90
    group_label: "P90"
    label: "Active Time"
    value_format: "0"
    sql: ${active_time} ;;
    description: "The amount of time in minutes an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: p90_handle_time {
    type: percentile
    percentile: 90
    group_label: "P90"
    label: "Handle Time (Seconds) P90"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time} ;;
    description: "The P90 value of time in seconds an agent had the work item open."
  }

  measure: p90_speed_to_answer {
    type: percentile
    percentile: 90
    group_label: "P90"
    label: "Speed to Answer"
    value_format: "0"
    sql: ${speed_to_answer} ;;
    description: "P90 time in seconds between when the work was requested and when an agent accepted it."
    hidden: yes
  }

 # P 90 MINUTES

  measure: p90_active_time_minutes {
    type: percentile
    percentile: 90
    group_label: "P90"
    label: "Active Time minutes"
    value_format: "0"
    sql: ${active_time}/60 ;;
    description: "The amount of time, minutes, an agent actively worked on the work item. It tracks when the item is open and in focus in the agent’s console"
    hidden: yes
  }

  measure: p90_handle_time_minutes {
    type: percentile
    percentile: 90
    group_label: "P90"
    label: "Handle Time (Minutes) P90"
    value_format: "0"
    filters: [handle_time_inclusion: "Yes"]
    sql: ${handle_time}/60 ;;
    description: "The P90 amount of time in minutes an agent had the work item open."
  }

  measure: p90_speed_to_answer_minutes {
    type: percentile
    percentile: 90
    group_label: "P90"
    label: "Speed to Answer minutes"
    value_format: "0"
    sql: ${speed_to_answer}/60 ;;
    description: "P90 time in minutes between when the work was requested and when an agent accepted it."
    hidden: yes
  }


}
