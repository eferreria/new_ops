view: zendesk_ticket_trendfinder_group {
  sql_table_name: [platform-integrity:trendfinder_support_site.zendesk_ticket_llm_group] ;;

# Dimensions

  dimension: zendesk_ticket_id {
    label: "Zendesk Ticket ID"
    type: number
    sql: ${TABLE}.zendesk_ticket_id ;;
  }

  dimension_group: created_at {
    type: time
    datatype: timestamp
    timeframes: [time, date, week, month, quarter, year]
    sql: TIMESTAMP(${TABLE}.zendesk_tickets_v2_groups_explore_created_at_date) ;;
    convert_tz: no
  }

  dimension: uuid {
    label: "Group ID"
    type: string
    sql: ${TABLE}.zendesk_tickets_v2_groups_uuid ;;
  }

  dimension: group_description {
    label: "Group LLM Description"
    type: string
    sql: ${TABLE}.zendesk_tickets_v2_groups_review ;;
  }

  dimension: variability {
    label: "Variability"
    type: number
    description: "A weighted score for how similar the reports in a group are to each other in that group."
    value_format_name: percent_2
    sql: ${TABLE}.variability ;;
  }

  dimension: importance {
    label: "Importance (Weighted)"
    type: number
    description: "A weighted score for how similar the reports in a group are to the group summary."
    value_format_name: percent_2
    sql: ${TABLE}.importance ;;
  }

# Measures
  measure: count {
    group_label: "Count"
    type: count
    drill_fields: [zendesk_ticket_id, uuid, created_at_date, group_description, variability, importance]
  }

  measure: tickets {
    group_label: "Count"
    label: "Count tickets"
    type: count_distinct
    sql: ${zendesk_ticket_id} ;;
    drill_fields: [zendesk_ticket_id, created_at_date, uuid, group_description]
  }

  measure: avg_variability {
    label: "Avg Variability"
    type: average
    sql: ${variability} ;;
    value_format_name: percent_2
  }

  measure: avg_importance {
    label: "Avg Importance"
    type: average
    sql: ${importance} ;;
    value_format_name: percent_2
  }
}
