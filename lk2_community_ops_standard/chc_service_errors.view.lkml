view: chc_service_errors {
  view_label: "Support Site Errors"
  derived_table: {
    sql:
      SELECT
        id,
        data AS json_data,
        NULL AS status_code,
        NULL AS error,
        timestamp,
        'processing_error' AS source
      FROM `support-site-prod.ticket_requests.processing_errors_*` as pe
      WHERE pe._TABLE_SUFFIX BETWEEN
        REPLACE(CAST({% date_start date_filter %} AS STRING), "-","")
        AND
        REPLACE(CAST({% date_end date_filter %} AS STRING), "-","")
      UNION ALL
      SELECT
        id,
        request AS json_data,
        status_code,
        error,
        timestamp,
        'request_failure' AS source
      FROM `support-site-prod.ticket_requests.request_failures_*` as rf
      WHERE rf._TABLE_SUFFIX BETWEEN
        REPLACE(CAST({% date_start date_filter %} AS STRING), "-","")
        AND
        REPLACE(CAST({% date_end date_filter %} AS STRING), "-","")
      UNION ALL
      SELECT
        id,
        data AS json_data,
        NULL AS status_code,
        NULL AS error,
        timestamp,
        'retry_error' AS source
      FROM `support-site-prod.ticket_requests.retry_errors_*` as pe
      WHERE pe._TABLE_SUFFIX BETWEEN
        REPLACE(CAST({% date_start date_filter %} AS STRING), "-","")
        AND
        REPLACE(CAST({% date_end date_filter %} AS STRING), "-","")
      ;;
}

  filter: date_filter {
    type: date
    default_value: "30 days"
    # sql: ${TABLE}.start_date ;;
  }


  dimension: error_id {
    label: "Error Id"
    sql: ${TABLE}.id;;
  }

  dimension: form {
    group_label: "Process/Retry Errors"
    label: "Form"
    description: "If the error is a processing or retry error, there will be a form value. If not, the value will be null."
    type: string
    sql: CASE WHEN source = 'processing_error' THEN JSON_EXTRACT_SCALAR(${TABLE}.json_data, '$.form_key')
        ELSE NULL
        END;;
  }

  dimension_group: error_date {
    type: time
    label: "Error"
    sql: PARSE_TIMESTAMP('%Y-%m-%d %H%M%S', CONCAT(SUBSTR(${TABLE}.timestamp, 1, 10), ' ', SUBSTR(${TABLE}.timestamp, 14)))  ;;
  }

  dimension: status_code {
    group_label: "Request Failure Errors"
    label: "Error Status Code"
    sql: ${TABLE}.status_code;;
  }

  dimension: error_description {
    group_label: "Request Failure Errors"
    label: "Error Description"
    sql: ${TABLE}.error;;
  }

  dimension: request_language {
    group_label: "Request Failure Errors"
    description: "If the error is a request failure error, there will be a language value. If not, the value will be null."
    label: "Locale"
    type: string
    sql: CASE WHEN source = 'request_failure' THEN JSON_EXTRACT_SCALAR(${TABLE}.json_data, '$.headers.Accept-Language')
          ELSE NULL
          END;;
  }

  measure: count_errors {
    type: count_distinct
    sql: ${error_id};;
  }
}
