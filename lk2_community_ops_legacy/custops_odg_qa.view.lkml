# most active contributor gcheung@snapchat.com
view: custops_odg_qa {
  derived_table: {
    sql: SELECT
          orders_id AS id,
          actions_username AS action_user,
          team AS team,
          location AS location,
          vendor AS vendor,
          subteams_combined AS subteams_combined,
          orders_approval_time AS approval_time,
          actions_action_timestamp_time AS action_time,
          orders_approval_status AS approval_status,
          orders_approver_email AS agent_email,
          language AS language,
          country AS country,
          actions AS action,
          orders_asset_image_filter_urls AS asset_image_filter_urls,
          indiv_pos_all AS position,
          is_resubmitted AS is_resubmitted
        FROM (
          SELECT
            orders.asset_image_filter_urls AS orders_asset_image_filter_urls,
            orders.id AS orders_id,
            actions.username AS actions_username,
            vendor_users.team AS team,
            vendor_users.location AS location,
            vendor_users.vendor AS vendor,
            vendor_users.subteams_combined AS subteams_combined,
            orders.approval_timestamp     AS orders_approval_time,
            actions.timestamp             AS actions_action_timestamp_time,
            orders.approval_status        AS orders_approval_status,
            orders.approver_email         AS orders_approver_email,
            orders.is_resubmitted         AS is_resubmitted,
            CASE
              WHEN orders.country IN ("SA","AE","KW","QA") THEN "Arabic"
              WHEN orders.country = "BR" THEN "Portuguese"
              WHEN orders.country = "NL" THEN "Dutch"
              WHEN orders.country IN ("FR","BE") THEN "French"
              WHEN orders.country IN ("MX","ES") THEN "Spanish"
              WHEN orders.country IN ("DE","AT") THEN "German"
              WHEN orders.country IN ("NO","SE","DK","FI") THEN "Nordic"
              ELSE "English/Other"
            END AS language,
            orders.country AS country,
            CASE
              WHEN actions.action LIKE '%IsFlagged: from false to true%' THEN "FLAGGED"
              WHEN actions.action LIKE '%ACCEPTED%' THEN "ACCEPTED"
              WHEN actions.action LIKE '%REJECTED%' THEN "REJECTED"
              WHEN actions.action LIKE '%REVOKED%' THEN "REVOKED"
              ELSE NULL
             END AS actions,
            RAND() AS rnd,
            ROW_NUMBER() OVER (PARTITION BY actions.username ORDER BY rnd) AS indiv_pos_all,
            ROW_NUMBER() OVER (PARTITION BY actions.username, language ORDER BY rnd) AS indiv_pos,
            ROW_NUMBER() OVER (PARTITION BY actions.username, actions ORDER BY rnd) AS indiv_pos_action,
            ROW_NUMBER() OVER (ORDER BY rnd) AS team_pos,
            COUNT(orders_id) OVER (PARTITION BY actions.username) AS tot
          FROM ${custops_odg_audit_log.SQL_TABLE_NAME} AS actions
          LEFT JOIN ${custops_odg_orders.SQL_TABLE_NAME} AS orders ON orders.id = actions.lineitem_id
          LEFT JOIN (
            SELECT
              email AS email,
              fte_contractor_or_vendor_name AS vendor,
              location AS location,
              team AS team,
              subteams_combined AS subteams_combined
            FROM ${custops_fte_vendor_users.SQL_TABLE_NAME}
          ) AS vendor_users ON vendor_users.email = actions.username
          WHERE {% condition actioned_time_filt %} actions.timestamp {% endcondition %}
          AND {% condition action_filter %}
                CASE WHEN actions.action LIKE '%IsFlagged: from false to true%' THEN "FLAGGED"
                  WHEN actions.action LIKE '%ACCEPTED%' THEN "ACCEPTED"
                  WHEN actions.action LIKE '%REJECTED%' THEN "REJECTED"
                  WHEN actions.action LIKE '%REVOKED%' THEN "REVOKED"
                  ELSE NULL
                END {% endcondition %}
          AND {% condition vendor_filter %} vendor_users.vendor {% endcondition %}
          AND {% condition subteam_filter %} vendor_users.subteams_combined {% endcondition %}
          AND {% condition user_name %} actions.username {% endcondition %}
          AND {% condition country_filter %} orders.country {% endcondition %}
          AND (actions.action LIKE '%IsFlagged: from false to true%'
                OR actions.action LIKE '%Approval: ACCEPTED%'
                OR actions.action LIKE '%Approval: REJECTED%'
                OR actions.action LIKE '%REVOKED%')
          GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,actions.username, language, actions)
          WHERE {% condition team_pos %} team_pos {% endcondition %}
          AND {% condition indiv_pos %} indiv_pos {% endcondition %}
          AND {% condition indiv_pos_action %} indiv_pos_action {% endcondition %}
          AND {% condition indiv_pos_all %} indiv_pos_all {% endcondition %};;
  }

#################
#### FILTERS ####
#################

  filter: team_pos {
    label: "Qty / Team"
    description: "Provides quantity of records up to the number specified across the whole team"
    type: number
  }

  filter: indiv_pos {
    label: "Qty / Agent / Language"
    description: "Provides quantity of records up to the number specified across each agent and language. Languages available: Arabic, Portuguese, English"
    type: number
  }

  filter: indiv_pos_action {
    label: "Qty / Agent / Action"
    description: "Provides quantity of records up to the number specified across each agent and action."
    type: number
  }

  filter: indiv_pos_all {
    label: "Qty / Agent"
    description: "Provides quantity of records up to the number specified across each agent."
    type: number
  }

  filter: actioned_time_filt {
    label: "Date Range Filter"
    type: date_time
    default_value: "7 days ago for 7 days"
  }

  filter: user_name {
    label: "User Filter"
    type: string
    case_sensitive: no
  }

  filter: action_filter {
    label: "Action Filter"
    type: string
    case_sensitive: no
  }

  filter: country_filter {
    label: "Country Filter"
    type: string
    case_sensitive: no
  }

  filter: vendor_filter {
    label: "Vendor Filter"
    description: "Vendor filter to include/exclude specific vendors"
    type: string
  }

  filter: subteam_filter {
    label: "Tier Filter"
    description: "Use to filter T1/T2"
    type: string
  }

####################
#### DIMENSIONS ####
####################

  dimension_group: action_time {
    type: time
    can_filter: no
    sql: ${TABLE}.action_time ;;
  }

  dimension: action_user {
    type: string
    can_filter:  no
    sql: ${TABLE}.action_user ;;
  }

  dimension: action {
    type: string
    can_filter:  no
    sql: ${TABLE}.action ;;
  }

  dimension: language {
    type: string
    can_filter:  no
    sql: ${TABLE}.language ;;
  }

  dimension_group: approval_time {
    type: time
    can_filter: no
    sql: ${TABLE}.approval_time ;;
  }

  dimension: approver_user {
    type: string
    can_filter: no
    sql: ${TABLE}.agent_email ;;
  }

  dimension: approval_status {
    type: string
    can_filter: no

    sql: ${TABLE}.approval_status ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
    can_filter: no
  }

  dimension: vendor {
    type: string
    can_filter:  no
  }

  dimension: subteams_combined {
    type: string
    label: "Subteams"
    can_filter:  no
  }

  dimension: location {
    type: string
    can_filter:  no
  }

  dimension: position {
    type: number
    sql: ${TABLE}.position ;;
  }

  dimension: link {
    type: string
    sql: CONCAT('https://approval-dot-geofilters-on-demand.appspot.com/geofilters-on-demand-approval/#/filters/filter/',${TABLE}.ID);;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a> ;;
    can_filter: no
  }

  dimension: country {
    type:  string
    sql: ${TABLE}.country;;
    can_filter: no
  }

  dimension: asset_image_filter_urls {
    type: string
    sql: ${TABLE}.asset_image_filter_urls ;;
  }

  dimension: images {
    sql:  ${TABLE}.asset_image_filter_urls ;;
    html: {% assign urls = value | split: ',' %}
            <p style="background-color: #D3D3D3;">
            {% for url in urls  %}
              <img src="{{ url }}" width="150px" />
            {% endfor %}
            </p> ;;
  }

  dimension: is_resubmitted {
    type: yesno
  }

  set: detail {
    fields: [
      approval_time_time,
      approver_user,
      approval_status,
      action_time_time,
      action_user,
      action,
      language,
      id,
      link,
      images
    ]
  }

}
