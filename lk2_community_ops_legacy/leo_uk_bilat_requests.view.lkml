view: leo_uk_bilat_requests {
  label: "LEO UK Bilat Requests"
  derived_table: {
    sql: SELECT * FROM [platform-integrity:ops.leo_uk_bilat_requests]
        WHERE processing_agent <> "handled above"
          AND processing_agent <> " "
          AND processing_agent <> "X" ;;
  }

  dimension_group: date {
    sql: ${TABLE}.date ;;
    label: "Processing "
    type: time
    description: "Date which a task was initiated"
  }

  dimension_group: termination_date {
    sql: ${TABLE}.termination_date ;;
    label: "Termination "
    type: time
    description: "Date which a task was terminated"
  }

  dimension: total_identifiers {
    type: number
  }

  dimension: count_of_full_production {
    label: "Count of Full Production"
    type: number
  }

  dimension:  count_of_no_production {
    label: "Count of No Production"
    type: number
  }

  dimension: count_of_partial_production  {
    label: "Count of Partial Production"
    type: number
  }

  dimension: processing_agent {
    sql: ${TABLE}.processing_agent ;;
    label: "Processing Agent"
    description: "The agent who completed the initiation task"
  }

  dimension: tt_processing_agent {
    label: "Termination Task Processing Agent"
    description: "The agent who completed the termination task"
  }

  dimension: processing_agent_email {
    type: string
    label: "Processing Agent Email"
    description: "The agent's email who completed the initiation task"
  }

  dimension: termination_task_agent_email {
    type: string
    label: "Termination Task Agent Email"
    description: "The agent's email who completed the termination task"
  }

  measure: sum_no_production {
    type: sum
    sql: ${count_of_no_production} ;;
  }

  measure: sum_full_production {
    type: sum
    sql: ${count_of_full_production} ;;
  }

  measure: sum_partial_production {
    type: sum
    sql: ${count_of_partial_production} ;;
  }

}
