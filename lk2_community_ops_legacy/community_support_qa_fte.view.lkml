# most active contributor jbabra@snapchat.com
view: community_support_qa_fte {
  label: "Community Support QA FTE"
  derived_table: {
    sql: SELECT week_number,
                week_start,
                assignee,
                agent,
                agent_type,
                contact_type,
                zendesk_link,
                CAST(complete_response_score AS FLOAT) AS complete_response_score,
                CAST(grammar_tone_score AS FLOAT) AS grammar_tone_score,
                CAST(privacy_process_score AS FLOAT) AS privacy_process_score,
                CAST(triage_reporting_score AS FLOAT) AS triage_reporting_score,
                CAST(overall_score AS FLOAT) AS overall_score,
                notes
        FROM [sc-analytics:report_customer_ops.community_support_qa_fte]
        WHERE complete_response_score IS NOT NULL
       ;;
  }




#####################
#### DIMENSIONS ####
#####################

  dimension: week_number {
    description: "Week Number (1-52)"
    type: number
    sql: ${TABLE}.week_number;;
  }

  dimension_group: week_start {
    description: "Starting date of the week"
    type: time
    sql: ${TABLE}.week_start;;
  }

  dimension: assignee {
    description: "Name of person performing the QA on the ticket"
    type: string
    sql: ${TABLE}.assignee;;
  }

  dimension: agent {
    label: "Ticket Agent"
    description: "Email of agent who completed the ticket"
    type: string
    sql: ${TABLE}.agent;;
  }

  dimension: agent_type {
    description: "Employee type for the agent who completed the ticket (FTE or Contractor)"
    type: string
    sql: ${TABLE}.agent_type;;
  }

  dimension: contact_type {
    description: "Which flow the contact came from (Chat or Email)"
    type: string
    sql: ${TABLE}.contact_type;;
  }

  dimension: zendesk_link {
    description: "Zendesk Link"
    type: string
    sql: ${TABLE}.zendesk_link;;
  }

  dimension: complete_response_score {
    label: "Complete Response Score"
    type: number
    sql: ${TABLE}.complete_response_score;;
  }

  dimension: grammar_tone_score {
    label: "Grammar & Tone Score"
    type: number
    sql: ${TABLE}.grammar_tone_score;;
  }

  dimension: privacy_process_score {
    label: "Privacy & Process Score"
    type: number
    sql: ${TABLE}.privacy_process_score;;
  }

  dimension: triage_reporting_score {
    label: "Triage & Reporting Score"
    type: number
    sql: ${TABLE}.triage_reporting_score;;
  }

  dimension: overall_score {
    label: "Overall Score"
    type: number
    sql: ${TABLE}.overall_score;;
  }

  dimension: notes {
    label: "Notes"
    type: string
    sql: ${TABLE}.notes;;
  }

#####################
##### MEASURES #####
#####################
  measure: count_tickets_reviewed{
    type: count
  }




  measure: average_overall_score {
    label: "Average Overall Score"
    type: average
    sql: ${TABLE}.overall_score;;
    group_label: "Average Scores"
    value_format: "0.0"
  }

  measure: average_complete_response_score {
    label: "Average Complete Response Score"
    type: average
    sql: ${TABLE}.complete_response_score;;
    group_label: "Average Scores"
    value_format: "0.0"
  }

  measure: average_grammar_tone_score {
    label: "Average Grammar & Tone Score"
    type: average
    sql: ${TABLE}.grammar_tone_score;;
    group_label: "Average Scores"
    value_format: "0.0"
  }

  measure: average_privacy_process_score {
    label: "Average Privacy & Process Score"
    type: average
    sql: ${TABLE}.privacy_process_score;;
    group_label: "Average Scores"
    value_format: "0.0"
  }

  measure: average_triage_reporting_score {
    label: "Average Triage & Reporting Score"
    type: average
    sql: ${TABLE}.triage_reporting_score;;
    group_label: "Average Scores"
    value_format: "0.0"
  }



#EOF
}
