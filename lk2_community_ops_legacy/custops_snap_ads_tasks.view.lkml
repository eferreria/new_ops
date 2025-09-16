view: custops_snap_ads_tasks {
  derived_table: {
    sql:  SELECT
            tasks.id AS id,
            tasks.payload AS payload,
            tasks.created_at AS created_at,
            tasks._ad_id AS ad_id,
            tasks.updated_at AS updated_at,
            tasks.tags_rules_engine_action AS tags_rules_engine_action,
            tasks.tagging_creative_content_type AS tagging_creative_content_type,
            tasks.creative_id AS creative_id,
            tasks.attachment_type AS attachment_type,
            tasks.review_type AS review_type,
            tasks.has_tagged AS has_tagged
          FROM (
            SELECT
              tasks.id AS id,
              tasks.payload AS payload,
              tasks.created_at AS created_at,
              tasks.updated_at AS updated_at,
              CASE
                WHEN tasks.source = 'Tagging'
                  AND JSON_EXTRACT_SCALAR(tasks.payload, "$.creative_tagging_properties.review_action") IS NOT NULL
                  THEN 'Ad Review'
                WHEN tasks.source = 'Tagging'
                  THEN 'Tagging Review'
                ELSE 'Ad Review'
              END AS review_type,
              JSON_EXTRACT_SCALAR(tasks.payload, "$.ad_id") AS _ad_id,
              JSON_EXTRACT_SCALAR(tasks.payload, "$.creative_tagging_properties.review_action") IS NOT NULL
                  OR JSON_EXTRACT_SCALAR(tasks.payload, "$.creative_tagging_properties.tagging_status") IS NOT NULL AS has_tagged,
              JSON_EXTRACT_SCALAR(tasks.payload, "$.creative_tagging_properties.review_action") AS tags_rules_engine_action,
              JSON_EXTRACT_SCALAR(tasks.payload, "$.creative_content_type") AS tagging_creative_content_type,
              JSON_EXTRACT_SCALAR(tasks.payload, "$.creative_id") AS creative_id,
              JSON_EXTRACT_SCALAR(tasks.payload, "$.attachment_type") AS attachment_type
            FROM [sc-analytics:report_customer_ops.taskservice_tasks_distinct] tasks
            WHERE creator IN ('c4923584-e8a3-4190-a2a3-c1d7932d00bd','994106806927-compute@developer.gserviceaccount.com')
            AND tasks.is_trusted_set_task = '0') tasks
       ;;
  }

######################
##### DIMENSIONS #####
######################

  dimension: task_id {
    type: string
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: task_link {
    type: string
    sql: CONCAT('https://sc-review-tool.appspot.com/en-US/task/',${TABLE}.id);;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: priority {
    type: string
    sql: ${TABLE}.priority ;;
  }

  dimension: automation_type {
    type: string
    sql: ${lego_reviews.automation_type} ;;
  }

  dimension: is_auto_reviewed {
    type: yesno
    sql: ${lego_reviews.is_auto_reviewed} ;;
  }

  dimension: review_status {
    type: string
    sql: ${lego_reviews.review_status} ;;
  }

  dimension: targeting_language {
    type: string
    sql: ${custops_snap_ads_task_meta.languages_targeted};;
    label : "Targeting Language(s)"
    description: "Listed Targeting Languages in Ad, otherwise inferred by country targeted"
  }

  dimension: creative_id {
    type: string
  }

  dimension: payload {
    type: string
    sql: ${TABLE}.payload ;;
  }

  dimension: web_view_properties_url {
    label: "Associated URL(s)"
    description: "Combines urls found across web_view properties or collection properties, including deep link"
    type: string
    sql: COALESCE(
          JSON_EXTRACT_SCALAR(${payload}, '$.creative.collection_properties.web_view_properties.url'),
          JSON_EXTRACT_SCALAR(${payload}, '$.creative.web_view_properties.url'),
          JSON_EXTRACT_SCALAR(${payload}, '$.creative.collection_properties.deep_link_properties.deep_link_uri'),
          JSON_EXTRACT_SCALAR(${payload}, '$.creative.collection_properties.deep_link_properties.web_view_fallback_url')
          );;
  }

  dimension: top_level_domain {
    label: "Top Level Domain (Associated URL)"
    sql: TLD(${web_view_properties_url}) ;;
  }

  dimension: domain {
    label: "Domain (Associated URL)"
    sql: DOMAIN(${web_view_properties_url}) ;;
  }

  dimension: ad_id {
    type: string
  }

  dimension: tags_rules_engine_action {
    description: "The result of the tagging rules engine review"
    type: string
  }

  dimension: review_type {
    description: "Ad Review or Tagging Review"
    type: string
    suggestions: ["Ad Review","Tagging Review"]
  }

  dimension: targeting_country_code {
    type: string
    label: "Targeting Country Code(s)"
    description: "Listed Targeting Country Codes"
    map_layer_name: countries
    sql: ${custops_snap_ads_task_meta.targeting_country_code} ;;
  }

  dimension: attachment_type {
    type: string
    description: "Ad Review Attachment Type / Tagging Creative Content Type"
    sql: COALESCE(${TABLE}.attachment_type,${TABLE}.tagging_creative_content_type) ;;
  }

  dimension: has_tagged {
    type: yesno
  }

  dimension_group: updated_at {
    type: time
    sql: ${TABLE}.updated_at ;;
  }

#########################
#### DATE DIMENSIONS ####
#########################

  dimension_group: task_created_date_utc {
    label: "Created At (UTC)"
    description: "Timestamp of when the task was created in UTC"
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: task_created_date_pst {
    label: "Created At (PST)"
    description: "Timestamp of when the task was created in PST. This is not a perfect metric because of DST"
    type: time
    sql: DATE_ADD(${TABLE}.created_at, -8, "HOUR");;
  }

###################
#### MEASURES #####
###################

  measure: task_count {
    type: count
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: ad_review_count {
    type: count
    filters: {
      field: review_type
      value: "Ad Review"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: ad_review_of_tagged_count {
    type: count
    filters: {
      field: review_type
      value: "Ad Review"
    }
    filters: {
      field: has_tagged
      value: "Yes"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: tagging_review_count {
    type: count
    filters: {
      field: review_type
      value: "Tagging Review"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: rules_engine_reject_count {
    type: count
    filters: {
      field: tags_rules_engine_action
      value: "REJECT"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: rules_engine_escalate_count {
    type: count
    filters: {
      field: tags_rules_engine_action
      value: "ESCALATE"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: rules_engine_tier1_review_count {
    type: count
    filters: {
      field: tags_rules_engine_action
      value: "NO_ACTION,TIER1_REVIEW"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

  measure: rules_engine_approve_count {
    type: count
    filters: {
      field: tags_rules_engine_action
      value: "APPROVE"
    }
    approximate_threshold: 1000000
    drill_fields: [detail*]
  }

################
#### DETAIL ####
################

  set: detail {
    fields: [
      task_id,
      task_created_date_utc_time,
      payload
    ]
  }
}
