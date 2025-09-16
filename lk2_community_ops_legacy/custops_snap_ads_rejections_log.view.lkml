# most active contributor gcheung@snapchat.com
view: custops_snap_ads_rejections_log {
  derived_table: {
    sql: SELECT * FROM [sc-analytics:report_customer_ops.taskservice_snapads_rejections_log]
      ;;
  }

  measure: count_rejections {
    type: count
    description: "Count of each (one or more) rejection type applied to review. If rejection was part of a list, then this is split into a unique record"
    drill_fields: [detail*]
  }

  measure: count_task_rejections {
    type: count_distinct
    approximate_threshold: 1000000
    description: "Count of distinct tasks containing rejection"
    sql: ${TABLE}.taskid;;
    drill_fields: [detail*]
  }

  dimension: id {
    description: "The Task History ID this rejection type occurred."
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: task_id {
    type: string
    description: "The Task Id this rejection type was applied to."
    sql: ${TABLE}.taskid ;;
  }

  dimension_group: updated_at {
    type: time
    description: "The time this rejection was applied."
    sql: ${TABLE}.updatedAt ;;
  }

  dimension: action {
    description: "The full recorded Task History Action."
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension: rejection_type {
    type: string
    description: "The rejection type; this is split into unique record if the rejection is part of a list."
    sql: ${TABLE}.rejectionType ;;
  }

  dimension: rejection_types_list {
    type: string
    description: "The list of rejections this Rejection Type was part of (if applicable)."
    sql: ${TABLE}.rejectionTypesList ;;
  }

  dimension: primary_key {
    type: string
    sql: CONCAT(${TABLE}.rejectionType,${TABLE}.id,${TABLE}.taskid) ;;
    primary_key: yes
    hidden: yes
  }

  set: detail {
    fields: [
      id,
      task_id,
      updated_at_time,
      action,
      rejection_type,
      rejection_types_list
    ]
  }
}

view: top_rej {
  derived_table: {
    sql:  SELECT
            custops_snap_ads_rejections_log.rejectionType  AS rejection_type,
            COUNT(CONCAT(custops_snap_ads_rejections_log.rejectionType,custops_snap_ads_rejections_log.id,custops_snap_ads_rejections_log.taskid) ) AS custops_snap_ads_rejections_log_count_rejections
          FROM (SELECT * FROM [sc-analytics:report_customer_ops.taskservice_snapads_rejections_log]
                ) AS custops_snap_ads_rejections_log
          WHERE
            {% condition date_filter_top_n %} custops_snap_ads_rejections_log.updatedAt {% endcondition %}
          GROUP BY 1
          ORDER BY 2 DESC
          LIMIT {% parameter top_n %}  ;;
  }

  dimension: rejection_type {
    hidden: yes
  }

  filter: date_filter_top_n {
    hidden: no
    type: date
    default_value: "this month"
  }

  parameter: top_n {
    hidden: no
    default_value: "10"
    type: number
  }

}
