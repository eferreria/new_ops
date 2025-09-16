# most active contributor gcheung@snapchat.com
view: custops_review_odg_qa_fte {
  label: "ODG Review QA FTE"
  derived_table: {
    sql: SELECT CAST(date AS date) AS action_date,
                email AS agent_email,
                link AS task_link,
                score_code,
                notes,
                CAST(score AS INTEGER) AS score,
                other_notes
        FROM [sc-analytics:report_customer_ops.ad_review_odg_qa_fte]
       ;;
  }

#####################
#### DIMENSIONS ####
#####################


  dimension_group: action_date {
    description: "Date the original review took place"
    type: time
    sql: ${TABLE}.action_date;;
  }

  dimension: agent_email {
    label: "Ticket Agent"
    description: "Email of agent who completed the review"
    type: string
    sql: ${TABLE}.agent_email;;
  }

  dimension: task_link {
    description: "Task Link"
    type: string
    sql: ${TABLE}.task_link;;
  }

  dimension: score_code {
    type: string
    sql: ${TABLE}.score_code;;
  }

  dimension: score {
    label: "Score"
    type: number
    sql: ${TABLE}.score;;
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
    description: "Will only count the number of tickets that have a score, will ignore 'DUPLICATE' Score Code or anythign that has yet to be reviewed"
    type: count
    filters: {
      field: score
      value: "NOT NULL"
    }
  }

  measure: count_distinct_agents {
    type: count_distinct
    sql: ${agent_email} ;;
  }

  measure: average_score {
    type:  average
    value_format: "0.00"
    sql: ${score} ;;
  }




#EOF
}
