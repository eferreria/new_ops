# most active contributor jbabra@snapchat.com
view: custops_ad_product_quality_jira_detail {
  derived_table: {
    sql:
      SELECT issue_key,
             issue_id,
             parent_id,
             issue_type,
             summary,
             creator,
             reporter,
             assignee,
             priority,
             status,
             resolution,
             CAST(created_timestamp AS timestamp) AS created_timestamp,
             CAST(resolved_timestamp AS TIMESTAMP) AS resolved_timestamp,
             CAST(updated_timestamp AS TIMESTAMP) AS updated_timestamp,
             CAST(last_viewed_timestamp AS TIMESTAMP) AS last_viewed_timestamp,
             custom_field_source,
             description,
             components
      FROM [sc-analytics:report_customer_ops.ad_product_quality_jira_detail] jd

      ;;
  }
##TEST
######################
##### DIMENSIONS #####
######################


  dimension: issue_key {
    type: string
  }


  dimension: issue_id {
    type: string
  }

  dimension: parent_id {
    type: string
  }

  dimension: issue_type {
    type: string
  }

  dimension: summary {
    type: string
  }

  dimension: creator {
    type: string
  }

  dimension: reporter {
    type: string
  }

  dimension: assignee {
    type: string
  }

  dimension: priority {
    type: string
  }

  dimension: components {
    type: string
  }

  dimension: status {
    type: string
  }

  dimension: resolution {
    type: string
  }

  dimension_group: created_timestamp {
    type: time
  }

  dimension_group: resolved_timestamp {
    type: time
  }

  dimension_group: updated_timestamp {
    type: time
  }

  dimension_group: last_viewed_timestamp {
    type: time
  }

  dimension: custom_field_source  {
    type: string
  }

  dimension:  description {
    type: string
  }

  measure: count_distinct_jira_id {
    type: count_distinct
    sql: ${issue_key} ;;
  }

  dimension: highest_escalation_level {
    type: string
    sql: CASE WHEN ${issue_key} IS NOT NULL THEN "JIRA"
              WHEN ${issue_key} IS NULL AND (${zendesk_ticket.group_id} IN (360000300043,27913686) OR (${zendesk_ticket.tag} LIKE "%route_tech_support%") OR ${zendesk_ticket.tag} LIKE "%de-escalate_apq_l2%") THEN "Ad Product Quality" --no jira ticket and either in APQ Group or has APQ de-escalation tags
              WHEN ${issue_key} IS NULL AND (((${zendesk_ticket.group_id} IN (24929186,24624846) AND (${zendesk_ticket.tag} NOT LIKE "%route_tech_support%" OR ${zendesk_ticket.tag} LIKE "%de-escalate_apq_l2%"))) OR (${zendesk_ticket.tag} LIKE "%biz_route_l1%" OR ${zendesk_ticket.tag} LIKE "%odg-deescalate%")) THEN "Business/ODG Support L2" --no jira ticket and in biz support l2 group WIHTOUT APQ de-escalation tags or WITH l2 de-escalation tags
              WHEN ${issue_key} IS NULL AND (${zendesk_ticket.group_id} IN (360000252243, 23731746, 360000351683, 360000489803) AND (${zendesk_ticket.tag} NOT LIKE "%route_tech_support%" OR ${zendesk_ticket.tag} NOT LIKE "%de-escalate_apq_l2%" OR ${zendesk_ticket.tag} NOT LIKE "%biz_route_l1%%" OR ${zendesk_ticket.tag} NOT LIKE "%odg-deescalate%")) THEN "Business/ODG/Pixel Support L1" --no jira ticket and in biz support l1 group WITHOUT APQ/L2 de-escalation tags
              ELSE "Other"
         END;;
  }



}
