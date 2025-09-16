# most active contributor abenharosh@snapchat.com
view: social_agent {
  view_label: "Social Agents"
  derived_table: {
    sql:
        SELECT
                id,
                city,
                alias,
                country,
                created_date,
                department,
                email,
                first_name,
                last_name,
                is_active,
                language_locale_key,
                last_login_date,
                employee_number,
                name,
                profile_id,
                queue_id__c,
                title,
                'Salesforce' AS platform_record

          FROM `sc-analytics.prod_metadata_crm_co.user_20240221`

           UNION ALL

          SELECT
                EMAIL_1 AS id,
                USER_CUSTOM_PROPERTY_5 AS city,
                NULL AS alias,
                NULL AS country,
                CAST(TIMESTAMP_MILLIS(CAST(USER_CREATED_TIME_0 AS INT64)) AS STRING) AS created_date,
                USER_CUSTOM_PROPERTY_6 AS department,
                EMAIL_1 AS email,
                NULL AS first_name,
                NULL AS last_name,
                CASE WHEN USER_STATE_3="1" THEN "True" Else "False" END AS is_active,
                NULL AS language_locale_key,
                NULL AS last_login_date,
                NULL AS employee_number,
                USER_ID_2 AS name,
                NULL AS profile_id,
                NULL AS queue_id__c,
                USER_CUSTOM_PROPERTY_4 AS title,
                'Sprinklr' AS platform_record

          FROM `sc-sprinklr.prod_metadata_sprinklr.user`

--          WHERE
--        _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', CURRENT_DATE("America/Los_Angeles"))
          ;;
  }


  # DIMENSIONS

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
    group_label: "Agent Info"
    hidden: no
  }

  dimension: platform_record {
    type: string
    sql: ${TABLE}.platform_record ;;
    hidden: no
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    case_sensitive: no
    group_label: "Location Info"
    hidden: no
  }

  dimension: alias {
    type: string
    sql: ${TABLE}.alias ;;
    case_sensitive: no
    group_label: "Agent Info"
    hidden: yes
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
    case_sensitive: no
    group_label: "Location Info"
    hidden: yes
  }

  dimension_group: created_date {
    type: time
    label: "Agent Created PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time]
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
    case_sensitive: no
    group_label: "Team Info"
    hidden: no
  }

  dimension: email {
    type: string
    sql:   ${TABLE}.email ;;
    case_sensitive: no
    group_label: "Agent Info"
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    case_sensitive: no
    group_label: "Agent Info"
    hidden: yes
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    case_sensitive: no
    group_label: "Agent Info"
    hidden: yes
  }

  dimension: is_active {
    type: string
    sql: ${TABLE}.is_active ;;
    case_sensitive: no
    group_label: "Agent Info"
    hidden: no
  }

  dimension: language_locale_key {
    type: string
    sql: ${TABLE}.language_locale_key ;;
    case_sensitive: no
    group_label: "Location Info"
    hidden: yes
  }

  dimension_group: last_login_date {
    type: time
    label: "Last Login PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.last_login_date AS TIMESTAMP), INTERVAL -7 HOUR);;
    timeframes: [date, time]
    hidden: yes
  }

  dimension: employee_number {
    type: string
    sql: CAST(${TABLE}.employee_number AS INT64) ;;
    case_sensitive: no
    hidden: yes
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    case_sensitive: no
    group_label: "Agent Info"
  }

  dimension: profile_id {
    type: string
    sql: ${TABLE}.profile_id ;;
    group_label: "Agent Info"
    hidden: yes
  }

  dimension: queue_id__c {
    type: string
    sql: ${TABLE}.queue_id__c ;;
    group_label: "Agent Info"
    hidden: yes
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    case_sensitive: no
    group_label: "Agent Info"
    hidden: no
  }




  # MEASURES


  measure: count_agents {
    type: count_distinct
    sql: ${TABLE}.id ;;
    drill_fields: [jango*]
  }

  set: jango {
    fields: [
      id, email, name, title, created_date_date, city
    ]
  }


 }
