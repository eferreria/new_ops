# most active contributor gcheung@snapchat.com
view: custops_review_odg_qa_acn {
  label: "ODG Review QA"
  derived_table: {
    sql:
        SELECT
          qa.*,
          r.*,
          CASE
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Approved Correctly') THEN 2
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Approved Incorrectly (Should be rejected)') THEN 0
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Rejected Correctly') THEN 2
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Rejected Incorrectly (Should be approved)') THEN 0
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Rejected for incorrect reasons') THEN 0
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Rejected for missing reasons') THEN 1
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Should have flagged (Decision is out of scope)') THEN 0
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Should have esclated (Decision is out of scope)') THEN 0
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Should have escalated (Decision is out of scope)') THEN 0
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Escalated Correctly') THEN 2
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Escalated Incorrectly') THEN 1
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Fatal Error') THEN -1
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Missing Notes') THEN 1
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Approved Incorrectly (Should be A/W)') THEN 1
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('A/W Incorrectly (Should be approved)') THEN 1
            WHEN RTRIM(LTRIM(LOWER(_score_code))) = LOWER('Rejected Incorrectly (Should be A/W)') THEN 0
            ELSE NULL
          END AS score,
          _score_code AS final_score_code
        FROM (
          SELECT
            *,
            IF(DATE(qa.date) > DATE('2018-08-10'),IFNULL(secondary_qa_score_code,score_code),score_code) AS _score_code
          FROM (
            SELECT
              *,
              LOWER(email) AS __key__
            FROM
              [sc-analytics:report_customer_ops.ad_review_odg_qa_acn],
              [sc-analytics:report_customer_ops.ad_review_odg_qa_acn_archive],
              [sc-analytics:report_customer_ops.ad_review_odg_qa_cw]) qa
          LEFT JOIN (
            SELECT
              *,
              LOWER(email) AS __key__
            FROM
              ${custops_fte_vendor_users.SQL_TABLE_NAME}) r
          ON
            r.__key__ = qa.__key__
          WHERE
            qa.date <> 'Date'
        )
       ;;

      persist_for: "12 hours"
    }

#####################
#### DIMENSIONS ####
#####################

    dimension_group: action_date {
      description: "Starting date of the week"
      type: time
      sql: TIMESTAMP(qa_date);;
    }

    dimension: agent_email {
      label: "Agent"
      description: "Email of agent who completed the review"
      type: string
      sql: qa_email;;
    }

    dimension: task_link {
      description: "Task Link"
      type: string
      sql: qa_link;;
    }

    dimension: score_code {
      type: string
      label: "Primary QA Score Code"
      sql: qa_score_code;;
    }

    dimension: final_score_code {
      type: string
      description: "Takes Secondary Score Code if different than Primary Score Code"
      sql: ${TABLE}.final_score_code ;;
    }

    dimension: score {
      label: "Score"
      type: number
      sql: ${TABLE}.score;;
    }

    dimension: notes {
      label: "Notes"
      type: string
      sql: qa_notes;;
    }

    dimension: error_category {
      type: string
      sql: qa_error_category;;
    }
    dimension: qa_of_qa {
      label: "Secondary QA Score Code"
      type: string
      sql: qa_secondary_qa_score_code;;
    }

    dimension: qa_of_qa_notes {
      label: "Secondary QA Notes"
      type: string
      sql: qa_secondary_qa_notes;;
    }

    dimension: fte {
      label: "Secondary QA Reviewer"
      type: string
      sql: qa_secondary_qa_reviewer;;
    }

    dimension_group: secondary_qa_date {
      label: "Secondary QA Date"
      type: time
      sql: TIMESTAMP(qa_secondary_qa_date);;
    }

    dimension: agent_type {
      label: "Agent Team"
      type: string
      sql: r_fte_contractor_or_vendor_name ;;
    }

    dimension: location {
      sql: r_location ;;
    }

#####################
##### MEASURES #####
#####################
    measure: count_reviewed {
      description: "Will only count the number of tickets that have a score, will ignore 'DUPLICATE' Score Code or anything that has yet to be reviewed"
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
