# most active contributor gcheung@snapchat.com
view: custops_support_qa_acn {
  label: "Business Support QA ACN"
  derived_table: {
    sql: SELECT week_number,
                TIMESTAMP(week_start) AS week_start,
                assignee,
                agent,
                agent_type,
                contact_type,
                zendesk_link,
                CAST(correct_response_score AS FLOAT) AS correct_response_score,
                CAST(grammar_tone_score AS FLOAT) AS grammar_tone_score,
                CAST(privacy_process_score AS FLOAT) AS privacy_process_score,
                CAST(tags_categories_score AS FLOAT) AS tags_categories_score,
                CAST(total_score AS FLOAT) AS overall_score,
                notes
        FROM [sc-analytics:report_customer_ops.business_support_qa_acn]
        WHERE correct_response_score IS NOT NULL
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

  dimension: correct_response_score {
    label: "Correct Response Score"
    type: number
    sql: ${TABLE}.correct_response_score;;
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

  dimension: tags_categories_score {
    label: "Tags & Categories Score"
    type: number
    sql: ${TABLE}.tags_categories_score;;
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

  measure: average_correct_response_score {
    label: "Average Correct Response Score"
    type: average
    sql: ${TABLE}.correct_response_score;;
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

  measure: average_tags_categories_score {
    label: "Average Tags & Category Score"
    type: average
    sql: ${TABLE}.tags_categories_score;;
    group_label: "Average Scores"
    value_format: "0.0"
  }



#EOF
}
