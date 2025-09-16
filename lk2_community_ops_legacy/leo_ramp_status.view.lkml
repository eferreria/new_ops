view: leo_ramp_status {
  label: "LEO Ramp Status"
  derived_table: {
    sql: SELECT
          *
          FROM (
            SELECT
            *,
            CASE WHEN Workflow IS NULL AND date_type = "Hire" THEN "Hire"
              ELSE Workflow END AS contact_reason,
            MAX(CASE
            WHEN date_type LIKE 'Hire' THEN Notes
            ELSE null
            END) OVER (PARTITION BY Emails) AS hire_date,
            MAX(CASE
              WHEN date_type LIKE 'Training' THEN Notes
              ELSE null
              END) OVER (PARTITION BY Workflow, Emails) AS training_date,
            MIN(CASE
              WHEN date_type LIKE 'Certification' THEN Notes
              ELSE null
              END) OVER (PARTITION BY Workflow, Emails) AS original_cert_date,
            MAX(CASE
              WHEN date_type LIKE 'Certification' THEN Notes
              WHEN date_type LIKE 'Recertification' THEN Notes
              ELSE null
              END) OVER (PARTITION BY Workflow, Emails) AS cert_date,
            MAX(CASE
              WHEN date_type LIKE 'Decertification' THEN Notes
              ELSE null
              END) OVER (PARTITION BY Workflow, Emails) AS decert_date,
            ROW_NUMBER() OVER (PARTITION BY Workflow, Emails) AS rn
            FROM [platform-integrity:ops.leo_ramp_status])
          WHERE rn = 1  ;;
  }

  dimension: team {
    description: "LEO Functional Team"
    type:  string
    sql: ${TABLE}.team ;;
  }

  dimension: email {
    type:  string
    sql: ${TABLE}.emails ;;
  }

  dimension: leo_role {
    label: "Role"
    description: "Team member's role"
    type:  string
    sql: ${TABLE}.roles ;;
  }

  dimension: leo_workflow {
    label: "LEO Workflow"
    description: "LEO Contact Reason/Workflow trained on / certified in"
    type:  string
    sql: CASE
          WHEN ${TABLE}.contact_reason = 'Subpoenas' THEN 'Subpoena / Summons'
          WHEN ${TABLE}.contact_reason = 'Preservations' THEN 'Preservation'
          WHEN ${TABLE}.contact_reason = 'ICTE' THEN 'Imminent Customer Threat Escalation'
          ELSE ${TABLE}.contact_reason
        END ;;
  }

  dimension: date_type {
    description: "Hire/Training/Certification date type"
    type:  string
    sql: ${TABLE}.date_type ;;
  }

  dimension: date {
    description: "Date of action for Hire/Training/Certification"
    type:  date
    sql: TIMESTAMP(${TABLE}.date) ;;
  }

  dimension: date_remediation {
    description: "Assigning a date value to those that don't have dates"
    hidden: yes
    type:  date
    sql: CAST(${TABLE}.notes AS DATE) ;;
  }

  dimension: active {
    label: "Active Agent?"
    description: "Based on the off-boarding date of the agent in the LEO Roster. If the date is before today, the agent is considered not active."
    sql: CASE
          WHEN ${TABLE}.active LIKE "Y" THEN true
          WHEN ${TABLE}.active LIKE "N" THEN false
        END ;;
    type: yesno
  }

  dimension: certified_agent {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.cert_date IS NULL THEN false
          WHEN ${TABLE}.decert_date > ${TABLE}.cert_date THEN false
          ELSE true
        END ;;
  }

  dimension_group: hire_date {
    type: time
    label: "Hire"
    sql: CAST(${TABLE}.hire_date AS TIMESTAMP) ;;
  }

  dimension_group: training_date {
    type: time
    label: "Training"
    sql: CAST(${TABLE}.training_date AS TIMESTAMP) ;;
  }

  dimension_group: cert_date {
    type: time
    label: "Certification"
    sql: CAST(${TABLE}.cert_date AS TIMESTAMP) ;;
  }

  dimension_group: original_cert_date {
    type: time
    sql: CAST(${TABLE}.original_cert_date AS TIMESTAMP) ;;
  }

  dimension: days_since_hire {
    label: "Days from Hire to Date"
    description: "Calendar days between Hire and the listed date for row entry"
    type: number
    sql: IF(DATEDIFF(${date_remediation},${hire_date_date})<=0,null,DATEDIFF(${date_remediation},${hire_date_date})) ;;
  }

  dimension: days_hire_to_cert {
    label: "Days from Hire to Certification"
    description: "Calendar days between Hire and original certification in a workflow"
    type: number
    sql: IF(DATEDIFF(${original_cert_date_date},${hire_date_date})<=0,null,DATEDIFF(${original_cert_date_date},${hire_date_date})) ;;
  }

  dimension: days_training_to_cert {
    label: "Days from Training to Certification"
    description: "Calendar days between Training in a workflow and original certification"
    type: number
    sql: IF(DATEDIFF(${original_cert_date_date},${training_date_date})<=0,null,DATEDIFF(${original_cert_date_date},${training_date_date})) ;;
  }

  measure: count_agents {
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [drill_fields*]
  }

  measure: days_hire_to_date {
    label: "Days from Hire to Date"
    type: number
    sql: ${days_since_hire} ;;
    drill_fields: [drill_fields*]
  }

  measure: avg_days_hire_to_cert {
    label: "Average Days from Hire to Certification"
    type: average
    value_format: "0.00"
    sql: ${days_since_hire} ;;
    drill_fields: [drill_fields*]
  }

  measure: avg_days_training_to_cert {
    label: "Average Days from Training to Certification"
    type: average
    value_format: "0.00"
    sql: ${days_training_to_cert} ;;
    drill_fields: [drill_fields*]
  }

  measure: median_days_hire_to_cert {
    label: "Median Days from Hire to Certification"
    group_label: "P50 Metrics"
    type: median
    value_format: "0.00"
    sql: ${days_since_hire} ;;
    drill_fields: [drill_fields*]
  }

  measure: median_days_training_to_cert {
    label: "Median Days from Training to Certification"
    group_label: "P50 Metrics"
    type: median
    value_format: "0.00"
    sql: ${days_training_to_cert} ;;
    drill_fields: [drill_fields*]
  }

  measure: p90_days_hire_to_cert {
    label: "P90 Days from Hire to Certification"
    group_label: "P90 Metrics"
    type: percentile
    percentile: 90
    value_format: "0.00"
    sql: ${days_since_hire} ;;
    drill_fields: [drill_fields*]
  }

  measure: p90_days_training_to_cert {
    label: "P90 Days from Training to Certification"
    group_label: "P90 Metrics"
    type: percentile
    percentile: 90
    value_format: "0.00"
    sql: ${days_training_to_cert} ;;
    drill_fields: [drill_fields*]
  }

  set: drill_fields {
    fields: [
      email,
      hire_date_date,
      leo_workflow,
      training_date_date,
      cert_date_date,
      days_since_hire,
      days_training_to_cert,
      active
    ]
  }

}
