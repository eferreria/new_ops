# most active contributor gcheung@snapchat.com
view: custops_review_snap_ads_qa_fte {
  label: "Snap Ads Review QA FTE"
  derived_table: {
    sql: SELECT * FROM (
            SELECT
              date AS date,
              email AS email,
              link AS link,
              score_code AS score_code,
              CASE
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Approved Correctly') THEN 2
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Approved Incorrectly (Should be rejected)') THEN 0
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected Correctly') THEN 2
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected Incorrectly (Should be approved)') THEN 0
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected for incorrect reasons') THEN 0
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected for missing reasons') THEN 1
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Should have flagged (Decision is out of scope)') THEN 0
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Should have escalated (Decision is out of scope)') THEN 0
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Should have esclated (Decision is out of scope)') THEN 0
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Escalated Correctly') THEN 2
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Escalated Incorrectly') THEN 1
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Fatal Error') THEN -1
                WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Missing Notes') THEN 1
                ELSE NULL
              END AS score,
              notes AS notes,
              error_category AS error_category,
              reviewer AS reviewer,
              review_date AS review_date
            FROM [sc-analytics:report_customer_ops.ad_review_snap_ads_qa_fte]),
            (
              SELECT
                date AS date,
                email AS email,
                link AS link,
                score_code AS score_code,
                CASE
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Approved Correctly') THEN 2
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Approved Incorrectly (Should be rejected)') THEN 0
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected Correctly') THEN 2
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected Incorrectly (Should be approved)') THEN 0
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected for incorrect reasons') THEN 0
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Rejected for missing reasons') THEN 1
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Should have flagged (Decision is out of scope)') THEN 0
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Should have escalated (Decision is out of scope)') THEN 0
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Should have esclated (Decision is out of scope)') THEN 0
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Escalated Correctly') THEN 2
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Escalated Incorrectly') THEN 1
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Fatal Error') THEN -1
                  WHEN RTRIM(LTRIM(LOWER(score_code))) = LOWER('Missing Notes') THEN 1
                  ELSE NULL
                END AS score,
                notes AS notes,
                error_category AS error_category
              FROM [sc-analytics:report_customer_ops.ad_review_snap_ads_qa_fte_2018Q1Q2])
       ;;
  }

#####################
#### DIMENSIONS ####
#####################

  dimension_group: action_date {
    description: "Starting date of the week"
    type: time
    sql: TIMESTAMP(${TABLE}.date);;
  }

  dimension: agent_email {
    label: "Ticket Agent"
    description: "Email of agent who completed the review"
    type: string
    sql: ${TABLE}.email;;
  }

  dimension: task_link {
    description: "Task Link"
    type: string
    sql: ${TABLE}.link;;
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

  dimension: extra_notes {
    label: "Extra Notes"
    type: string
    sql: ${TABLE}.extra_notes;;
  }

  dimension: error_category {
    label: "Error Category"
    type: string
    sql: ${TABLE}.error_category;;
  }

  dimension: reviewer {
    label: "Reviewer"
    type: string
    sql: ${TABLE}.reviewer;;
  }

  dimension: review_date {
    label: "Review Date"
    type: date
    sql: TIMESTAMP(${TABLE}.review_date);;
  }

#####################
##### MEASURES #####
#####################
  measure: count_tickets_reviewed {
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
