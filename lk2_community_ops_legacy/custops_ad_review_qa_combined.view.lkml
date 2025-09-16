# most active contributor gcheung@snapchat.com
view: custops_ad_review_qa_combined {
  derived_table: {
    sql: SELECT * FROM
      (
      SELECT
        TIMESTAMP(date) AS primary_qa_date,
        LTRIM(RTRIM(primary_qa_score_code)) AS primary_qa_score_code,
        link AS link,
        LTRIM(RTRIM(secondary_qa_score_code)) AS secondary_qa_score_code,
        secondary_qa_notes AS secondary_qa_notes,
        LTRIM(RTRIM(LOWER(secondary_qa_email))) AS secondary_qa_email,
        TIMESTAMP(secondary_qa_date) AS secondary_qa_date,
        business_product AS business_product,
        team AS team,
        work_flow AS work_flow
      FROM (
        SELECT
          STRING(date) AS date,
          score_code AS primary_qa_score_code,
          link AS link,
          secondary_qa_score_code AS secondary_qa_score_code,
          secondary_qa_notes AS secondary_qa_notes,
          secondary_qa_reviewer AS secondary_qa_email,
          STRING(secondary_qa_date) AS secondary_qa_date,
          'Snap Ads' AS business_product,
          'Accenture' AS team,
          'Ad Review' AS work_flow
        FROM [sc-analytics:report_customer_ops.ad_review_snap_ads_qa_acn],
             [sc-analytics:report_customer_ops.ad_review_snap_ads_qa_acn_archive]),
      (
        SELECT
          STRING(date) AS date,
          score_code AS primary_qa_score_code,
          link AS link,
          secondary_qa_score_code AS secondary_qa_score_code,
          secondary_qa_notes AS secondary_qa_notes,
          secondary_qa_email AS secondary_qa_email,
          secondary_qa_date AS secondary_qa_date,
          'On-Demand Geofilters' AS business_product,
          'Contingent Worker' AS team,
          'Ad Review' AS work_flow
        FROM [sc-analytics:report_customer_ops.ad_review_odg_qa_cw]),
      (
        SELECT
          STRING(date) AS date,
          score_code AS primary_qa_score_code,
          link AS link,
          secondary_qa_score_code AS secondary_qa_score_code,
          secondary_qa_notes AS secondary_qa_notes,
          secondary_qa_email AS secondary_qa_email,
          STRING(secondary_qa_date) AS secondary_qa_date,
          'On-Demand Geofilters' AS business_product,
          'Accenture' AS team,
          'Ad Review' AS work_flow
        FROM [sc-analytics:report_customer_ops.ad_review_odg_qa_acn],
             [sc-analytics:report_customer_ops.ad_review_odg_qa_acn_archive]),
      (
        SELECT
          STRING(date) AS date,
          score_code AS primary_qa_score_code,
          link AS link,
          secondary_qa_score_code AS secondary_qa_score_code,
          secondary_qa_notes AS secondary_qa_notes,
          secondary_qa_email AS secondary_qa_email,
          STRING(secondary_qa_date) AS secondary_qa_date,
          'Snap Ads' AS business_product,
          'Accenture' AS team,
          'Tagging Review' AS work_flow
        FROM [sc-analytics:report_customer_ops.ad_review_snap_ads_tagging_acn],
        [sc-analytics:report_customer_ops.ad_review_snap_ads_tagging_acn_archive])
      )
      WHERE (NOT (secondary_qa_score_code = 'Secondary QA Score Code') OR secondary_qa_score_code IS NULL)
       ;;

  }

  dimension: primary_qa_score_code {
    type: string
    sql: ${TABLE}.primary_qa_score_code ;;
  }

  dimension: link {
    type: string
    sql: ${TABLE}.link ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: secondary_qa_score_code {
    type: string
    sql: ${TABLE}.secondary_qa_score_code ;;
  }

  dimension: secondary_qa_notes {
    type: string
    sql: ${TABLE}.secondary_qa_notes ;;
  }

  dimension: secondary_qa_email {
    type: string
    sql: ${TABLE}.secondary_qa_email ;;
  }

  dimension_group: secondary_qa_date {
    type: time
    sql: ${TABLE}.secondary_qa_date ;;
  }

  dimension_group: primary_qa_date {
    type: time
    sql: ${TABLE}.primary_qa_date ;;
  }

  dimension: business_product {
    type: string
    sql: ${TABLE}.business_product ;;
    suggestions: ["Snap Ads","On-Demand Geofilters"]
  }

  dimension: team {
    type: string
    sql: ${TABLE}.team ;;
    suggestions: ["Accenture","TaskUs","Contingent Worker"]
  }

  dimension: work_flow {
    type: string
    sql: ${TABLE}.work_flow ;;
    suggestions: ["Ad Review","Tagging Review"]
  }

  dimension: secondary_qa_agreement {
    type: yesno
    sql: LOWER(${primary_qa_score_code}) = LOWER(${secondary_qa_score_code}) ;;
  }

  dimension: has_secondary_qa {
    type: yesno
    sql: ${TABLE}.secondary_qa_date IS NOT NULL ;;
  }

  measure: primary_qa_count {
    type: count
    drill_fields: [detail*]
  }

  measure: secondary_qa_count {
    type: count
    filters: {
      field: has_secondary_qa
      value: "yes"
    }
    drill_fields: [detail*]
  }

  measure: secondary_qa_of_primary_qa_pct {
    description: "What percent of Primary QA is Reviewed by Secondary QA?"
    type: number
    value_format: "0.0%"
    sql: ${secondary_qa_count} / ${primary_qa_count} ;;
  }

  measure: secondary_qa_agreement_count {
    type: count
    filters: {
      field: secondary_qa_agreement
      value: "yes"
    }
    drill_fields: [detail*]
  }

  measure: secondary_qa_agreement_pct {
    type: number
    value_format: "0.0%"
    sql: ${secondary_qa_agreement_count} / ${secondary_qa_count} ;;
  }

  set: detail {
    fields: [
      primary_qa_score_code,
      link,
      secondary_qa_score_code,
      secondary_qa_notes,
      secondary_qa_email,
      secondary_qa_date_time,
      business_product,
      team,
      work_flow
    ]
  }
}
