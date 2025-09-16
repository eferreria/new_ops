# most active contributor abenharosh@snapchat.com
view: social_cases {
view_label: "Social Cases"
  derived_table: {

    sql:  SELECT
            id,
            case_number,
            case_reopened_count,
            closed_date,
            contact_id,
            created_date,
            current_tier,
            tier,
            description,
            do_not_respond,
            first_response_date_time,
            full_resolution_time,
            agent_wait_time,
            first_resolution_time,
            requester_wait_time,
            last_Modified_date,
            owner_id,
            owner_location,
            response_time,
            time_since_last_modified,
            reporting_values,
            initial_reporting_values,
            NULL AS sprinklr_url,
            status,
            subject,
            qa_priority,
            secondary_response_value,
            null as case_automation

          FROM
           `sc-analytics.prod_metadata_crm_co.cases_20240221` -- 2024-02-21 was the last day of operation in SF Social Studio before Sprinklr migration
          WHERE CAST(created_date AS TIMESTAMP) <= CAST('2024-02-22' AS TIMESTAMP)

          UNION ALL

          SELECT
            C.CASE_ID_0 as id,
            C.CASE_ID_0 as case_number,
            NULLIF(C.UNIVERSAL_CASE_CUSTOM_PROPERTY_17, ' ') as case_reopened_count,
            CAST(F.full_resolution_time AS STRING) as closed_date,
            C.CASE_ID_0 as contact_id,
            CAST(TIMESTAMP_MILLIS(CAST(C.DATE_TYPE_CASE_CREATION_TIME_2 AS INT64)) AS STRING) as created_date,
            NULLIF(C.UNIVERSAL_CASE_CUSTOM_PROPERTY_14, ' ') as current_tier,
            NULLIF(C.UNIVERSAL_CASE_CUSTOM_PROPERTY_15, ' ') as tier,
            C.D_CASE_DESCRIPTION_PLAINTEXT_1 as description,
            NULL as do_not_respond,
            CAST(TIMESTAMP_MILLIS(CAST(NULLIF(C.FIRST_BRAND_RESPONSE_SN_CREATED_TIME_3, 'N/A') AS INT64)) AS STRING) as first_response_date_time,
            CAST(IFNULL(TIMESTAMP_DIFF(F.full_resolution_time, TIMESTAMP_MILLIS(CAST(C.DATE_TYPE_CASE_CREATION_TIME_2 AS INT64)) ,MINUTE),0) AS STRING) as full_resolution_time,
            NULL as agent_wait_time,
            CAST(IFNULL(TIMESTAMP_DIFF(F.first_resolution_time, TIMESTAMP_MILLIS(CAST(C.DATE_TYPE_CASE_CREATION_TIME_2 AS INT64)) ,MINUTE),0) AS STRING) as first_resolution_time,
            cast(round(R.M_CaseSLAReport_CASE_QUEUE_SLA_0/1000/60,2) as string) as requester_wait_time,
            CAST(L.max_timestamp AS STRING) as last_Modified_date,
            C.D_LAST_ENGAGED_USER_EMAIL_ADDR_0 as owner_id,
            NULL as owner_location,
            cast(((CAST(nullif(C.FIRST_BRAND_RESPONSE_SN_CREATED_TIME_3,"N/A") as NUMERIC) - CAST(C.DATE_TYPE_CASE_CREATION_TIME_2 AS NUMERIC))/1000/60) AS STRING) as response_time,
            NULL as time_since_last_modified,
            C.Primary_Reporting_Values_CSV_9 as reporting_values,
            C.Primary_Reporting_Value_Initial_CSV_11 as initial_reporting_values,
            C.CASE_ACCESS_LINK_1 as sprinklr_url,
            C.UNIVERSAL_CASE_CUSTOM_PROPERTY_8 as status,
            NULL as subject,
            NULLIF(C.UNIVERSAL_CASE_CUSTOM_PROPERTY_14, ' ') as qa_priority,
            C.Secondary_Reporting_Values_CSV_10  as secondary_response_value,
            C.UNIVERSAL_CASE_CUSTOM_PROPERTY_20 as case_automation


            FROM
              `sc-sprinklr.prod_metadata_sprinklr.cases` as C
              LEFT JOIN `sc-sprinklr.prod_metadata_sprinklr.cases_requester_wait_time` as R ON c.CASE_ID_0 = R.CASE_NUMBER_0
              LEFT JOIN (SELECT CASE_NUMBER_0 as case_id,
                          CAST(min(TIMESTAMP_MILLIS(CAST(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4 AS INT64))) as TIMESTAMP) as first_resolution_time,
                          CAST(max(TIMESTAMP_MILLIS(CAST(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4 AS INT64))) as TIMESTAMP) as full_resolution_time
                          FROM `sc-sprinklr.prod_metadata_sprinklr.case_history`
                          WHERE CUSTOM_PROPERTY_VALUE_3 IN ("Closed", "No Response Required","Auto-Closed")
                          group by 1) as F on c.CASE_ID_0 = F.case_id
              LEFT JOIN (SELECT CASE_NUMBER_0 as case_id,
                          CAST(min(TIMESTAMP_MILLIS(CAST(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4 AS INT64))) as TIMESTAMP) as min_timestamp,
                          CAST(max(TIMESTAMP_MILLIS(CAST(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4 AS INT64))) as TIMESTAMP) as max_timestamp
                          FROM `sc-sprinklr.prod_metadata_sprinklr.case_history`
                          group by 1) as L on c.CASE_ID_0 = L.case_id


              WHERE CAST(TIMESTAMP_MILLIS(CAST(DATE_TYPE_CASE_CREATION_TIME_2 AS INT64)) AS TIMESTAMP) >= CAST('2024-02-22' AS TIMESTAMP)

--          WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', CURRENT_DATE("America/Los_Angeles"))
              ;;




  }

  dimension: id {
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
    label: "Case ID"
    group_label: "Case Fields"
    description: "Unique case ID"
    link: {
      label: "Case Link"
      url: "{{ case_url }}"

    }
  }

  dimension: case_url {
    type: string
    group_label: "Case Fields"
    description: "The URL of the case in ther CRM tool"
    sql:  CASE WHEN ${case_origin}="Salesforce" THEN CONCAT('https://snapco.lightning.force.com/',(${id}))
                WHEN ${case_origin}="Sprinklr" THEN ${TABLE}.sprinklr_url
                ELSE NULL END
    ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: case_number {
    type: string
    hidden: yes
    sql: ${TABLE}.case_number ;;
    group_label: "Case Fields"
    description: "Easily readable case number, unique"
    link: {
      label: "Case Link"
      url: "{{ case_url }}"

    }
  }

  dimension: case_origin {
    type: string
    sql:
    CASE WHEN LENGTH(${TABLE}.id) = 18 THEN "Salesforce" ELSE "Sprinklr" END
    ;;
    label: "Case Origin"
    description: "Whether the case comes from Salesforce or Sprinklr"
  }

  dimension: reopens {
    type: number
    sql: IFNULL(CAST(${TABLE}.case_reopened_count AS FLOAT64), 0)
    ;;
    group_label: "Metrics"
    label: "Reopens"
    description: "Number of times a case gets reopened"
    value_format: "0"
  }

  dimension: reopens_range {
    type: string
    sql: CASE WHEN ${reopens} = 0 THEN "0"
              WHEN ${reopens} > 0 AND ${reopens} <=2 THEN "1-2"
              WHEN ${reopens} > 2 AND ${reopens} <=5 THEN "2-5"
              WHEN ${reopens} > 5 AND ${reopens} <=10 THEN "5-10"
              WHEN ${reopens} > 10 AND ${reopens} <=20 THEN "10-20"
              WHEN ${reopens} > 20 AND ${reopens} <=30 THEN "20-30"
              ELSE  "30+"
               END  ;;
    group_label: "Metrics"
    description: "Range of times a case gets reopened"
  }

  dimension: reopened_ {
    type: yesno
    sql: CAST(${TABLE}.case_reopened_count AS FLOAT64) >= 1 ;;
    group_label: "Metrics"
  }

  dimension: first_contact_resolution_cases {
    description: "Cases with no Re-opens"
    type: yesno
    sql: CASE WHEN ${reopens} = 0 AND ${closed_date} is NOT NULL THEN TRUE
         ELSE FALSE
        END;;
    group_label: "Metrics"
  }

  measure: first_contact_resolution_cases_count {
    type: count
    group_label: "First Contact Metrics"
    description: "Count of cases with no Re-opens"
    filters: {
      field: first_contact_resolution_cases
      value: "Yes"
    }
    drill_fields: [drill*]
  }

  measure: first_contact_resolution_cases_percent {
    type: number
    group_label: "First Contact Metrics"
    description: "Percent of cases with no Re-opens"
    value_format_name: percent_0
    sql: ${first_contact_resolution_cases_count}/NULLIF(${count_cases_with_closed_dates}, 0) ;;
  }

  dimension: cases_with_closed_dates {
    type: yesno
    sql: CASE
      WHEN ${closed_date} is  NULL THEN FALSE
      WHEN ${closed_date} = "" THEN FALSE
    ELSE TRUE
    END;;
    label: "Cases with Closed Dates"
    group_label: "Timestamps"
  }

  measure: count_cases_with_closed_dates {
    type: count
    hidden: yes
    filters: {
      field: cases_with_closed_dates
      value: "Yes"
    }
    group_label: "Count"
  }

  dimension: closed_date {
    type: date_minute
    convert_tz: no
    sql: TIMESTAMP_SUB(CAST(${TABLE}.closed_date AS TIMESTAMP), INTERVAL -7 HOUR) ;;
    group_label: "Timestamps"
    label: "Closed Date"
    description: "When the case was closed, in PST"
  }

  dimension: contact_id {
    type: string
    sql: ${TABLE}.contact_id ;;
    label: "Contact ID"
    group_label: "Case IDs"
    hidden: yes
  }

  dimension_group: created_utc {
    type: time
    convert_tz: no
    label: "Created UTC"
    sql:
         CAST(${TABLE}.created_date AS TIMESTAMP)

        ;;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter, week_of_year]
  }

  dimension_group: created_date_pst {
    type: time
    convert_tz: no
    label: "Created PST"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
  }

  dimension: week_number_sunday_start {
    type: number
    description: "Weeks begin on Sunday, so if January 1 is on a day other than Sunday, week 1 has fewer than 7 days and the first Sunday of the year is the first day of week 2."
    sql:  CAST(EXTRACT(WEEK FROM ${created_date_pst_date}) AS INT64) +1 ;;
    group_label: "Timestamps"
  }

  dimension: current_tier {
    type: string
    sql: ${TABLE}.current_tier ;;
    case_sensitive: no
    group_label: "Case Fields"
    description: "Case Tier"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    case_sensitive: no
    label: "Description"
    group_label: "Case Fields"
    description: "the text content of the customer's first inbound message"
    hidden: no
  }

  dimension: do_not_respond {
    hidden: yes
    type: string
    sql: ${TABLE}.do_not_respond ;;
    case_sensitive: no
  }

  dimension: first_response_date_time {
    type: date_minute
    convert_tz: no
    sql: CAST(${TABLE}.first_response_date_time AS TIMESTAMP) ;;
    label: "First Reply Timestamp UTC"
    description: "First response Timestamp"
    group_label: "Metrics"
  }

  dimension_group: first_reply_time {
    type: time
    convert_tz: no
    sql: TIMESTAMP_SUB(CAST(${TABLE}.first_response_date_time AS TIMESTAMP), INTERVAL -7 HOUR ) ;;
    description: "First Reply Timestamp"
    label: "First Reply Timestamp PST"
    timeframes: [date, time, hour_of_day, week, day_of_week, month]
  }

  dimension: full_resolution_time {
    type: number
    sql: ${TABLE}.full_resolution_time ;;
    group_label: "Metrics"
    label: "Full Resolution Time"
    description: "Number of minutes to the full resolution during calendar hours"
  }

  dimension: agent_wait_time {
    hidden: yes
    type: number
    sql: ${TABLE}.agent_wait_time ;;
    group_label: "Metrics"
    label: "Agent Wait Time"
    description: "Number of minutes the agent spent waiting during calendar hours"
  }

  dimension: first_resolution_time {
    type: number
    sql: ${TABLE}.first_resolution_time ;;
    group_label: "Metrics"
    label: "First Resolution Time"
    description: "Number of minutes to the first resolution time during calendar hours"
  }

  dimension: requester_wait_time {
    type: number
    sql: ${TABLE}.requester_wait_time ;;
    group_label: "Metrics"
    label: "Requester Wait Time"
    description: "Number of minutes the requester spent waiting during calendar hours"
  }

  dimension: high_follower_count {
    hidden: yes
  }

  dimension: is_closed {
    hidden: yes
  }

  dimension: is_deleted {
    hidden: yes
  }

  dimension: is_escalated {
    hidden: yes
  }

  dimension: language {
    hidden: yes
  }

  dimension_group: LastModifiedDate_utc {
    type: time
    convert_tz: no
    label: "Updated UTC"
    sql: CAST(${TABLE}.last_Modified_date AS TIMESTAMP) ;;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter]
  }

  dimension_group: LastModifiedDate_pst {
    type: time
    convert_tz: no
    label: "Updated PST"
    sql: TIMESTAMP_SUB(CAST(${TABLE}.last_Modified_date AS TIMESTAMP), INTERVAL -7 HOUR ) ;;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter]
  }

  dimension_group: closed_pst {
    type: time
    convert_tz: no
    label: "Closed PST"
    sql: TIMESTAMP_SUB(CAST(${TABLE}.closed_date AS TIMESTAMP), INTERVAL -7 HOUR ) ;;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter]
  }

  dimension: last_case_tier {
    hidden: yes
  }

  dimension: last_owned_tier {
    hidden: yes
  }

  dimension: orphan {
    hidden: yes
  }

  dimension: OwnerId {
    type: string
    label: "Case Owner ID"
    sql: ${TABLE}.owner_id ;;
    group_label: "Case Fields"
    description: "the email address of the last engaged agent on the case"
    #hidden: yes
  }

  dimension: owner_location {
    type: string
    sql: ${TABLE}.owner_location ;;
    description: "Case owner's physical location according to SF"
    hidden: yes
  }

  dimension: priority {
    group_label: "Case Fields"
    hidden: yes
  }

  dimension: parent_id {
    hidden: yes
  }

  dimension: qa_priority {
    label: "QA Priority"
    description: "In Sprinklr, this field corresponds to the Quality Audit Tier assigned to the case"
  }

  dimension: reason {
    hidden: yes
  }

  dimension: record_type_id {
    hidden: yes
  }

  dimension: reporting_values {
    group_label: "Issue Category"
  }

  dimension: higher_level_reporting_values {
    sql: CASE
        WHEN ${reporting_values} = "Spam Mention" THEN "Spam Mention"
        WHEN ${reporting_values} = "Account Recovery" THEN "Account Recovery"
        WHEN ${reporting_values} = "Other" THEN "Other"
        WHEN ${reporting_values} = "Outage" THEN "Outage"
        WHEN ${reporting_values} = "Foreign language" THEN "Foreign language"
        WHEN ${reporting_values} = "Profile - General" THEN "Profile - General"
        WHEN ${reporting_values} = "Trust and Safety" THEN "Trust and Safety"
        WHEN ${reporting_values} = "Chats/Snaps" THEN "Chats/Snaps"
        WHEN ${reporting_values} = "Spotlight" THEN "Spotlight"
        ELSE "Other"
        END   ;;
        group_label: "Issue Category"
  }

  dimension: case_automation {
    type: yesno
    sql: CASE
        WHEN ${case_origin}="Sprinklr" AND ${TABLE}.case_automation="Yes" THEN TRUE
        ELSE FALSE END;;
    label: "Case Automation (Sprinklr)"
    group_label: "Addressable Volume"
    description: "Filter for any case in Sprinklr with the Spam automation field filled with Yes value"
    hidden: yes

  }

  dimension: addressable_volume{
    type: yesno
    sql: CASE
        WHEN ${case_origin}="Salesforce" AND ${reporting_values} LIKE "%Automation%" THEN FALSE
        WHEN ${case_origin}="Sprinklr" AND ${case_automation}=TRUE THEN FALSE
        ELSE TRUE END;;
    label: "Addressable Volume"
    group_label: "Addressable Volume"
    description: "This filter aggregates cases based on whether they have a the spam automation filled marked as Yes (not addressable) or No (addressable) in Sprinklr; in Salesforce: reporting value that includes 'Automation' in it (not agent addressable) or not (agent addressable)"

  }

  dimension: response_time {
    type: number
    sql: CAST(${TABLE}.response_time AS FLOAT64) ;;
    group_label: "Metrics"
    label: "First Reply Time"
    description: "Number of minutes to the first reply during calendar hours"
  }

  dimension: secondary_response_value {
    group_label: "Issue Category"
  }

  dimension: source_id {
    hidden: yes
  }

  # dimension: spam_false_positive {
  #   type: yesno
  #   sql: CASE
  #     WHEN ${reporting_values} = "Automation:Spam" AND ${reopens} >=1 THEN TRUE ELSE FALSE END  ;;
  #   description: "Cases with reporting values Automation:Spam and reopened atleast once"
  # }

  dimension: actioned_not_spam {
    type: yesno
    sql: CASE
         WHEN ${case_origin} = "Salesforce" AND ${initial_reporting_values} = "Automation:Spam" AND ${reporting_values} != "Automation:Spam" THEN TRUE
        when ${case_origin}="Sprinklr" AND ${case_automation}=FALSE THEN TRUE
        ELSE FALSE END
        ;;
    description: "Cases without the spam automation filled as Yes (Sprinklr) or initial reporting values 'Automation:Spam' but changed after agent review (SF)"
    label: "Actioned: Not Spam "
    group_label: "Addressable Volume"
  }

  dimension: automation_cases {
    type: yesno
    label: "Automation Cases"
    group_label: "Addressable Volume"
    sql: CASE
         WHEN ${case_origin} = "Salesforce" AND ${initial_reporting_values} = "Automation:Spam" AND ${reporting_values} = "Automation:Spam" THEN TRUE
        when ${case_origin}="Sprinklr" AND ${case_automation}=TRUE THEN TRUE
        ELSE FALSE END
        ;;
    description: "Automation cases - cases with the spam automation field marked as yes (Sprinklr) or initial and current reporting values 'Automation:Spam' (Salesforce)"
  }

  dimension: initial_reporting_values {
    group_label: "Issue Category"
  }

  dimension: status {
    group_label: "Case Fields"
  }

  dimension: subject {
    group_label: "Case Fields"
    hidden: yes
  }

  dimension: tier {
    group_label: "Case Fields"
    hidden: no
    description: "Initial tier of a case"
    label: "Initial Tier"
  }

  dimension: type {
    hidden: yes
  }

  dimension: time_since_last_modified {
    group_label: "Metrics"
    type: number
    sql: CAST(${TABLE}.time_since_last_modified AS FLOAT64) ;;
    description: "Time since case was last modified in minutes"
    hidden: yes
  }

  dimension: verified {
    hidden: yes
  }

 dimension: frt_null_frtless1hr {
   type: yesno
  sql: CASE WHEN ${first_response_date_time} is NOT NULL AND CAST(${TABLE}.response_time AS FLOAT64) <= 60.0 THEN TRUE
            ELSE FALSE
            END
            ;;
            hidden: yes
 }

    dimension: tickets_with_frt_notnull {
      type: yesno
      sql: CASE WHEN ${first_response_date_time} is NOT NULL THEN TRUE
                ELSE FALSE
                END
                ;;
      hidden: yes
    }

  # MEASURES

  measure: test_frt_null {
    type: count
    filters: [first_response_date_time: "NOT NULL"]
    drill_fields: [drill*]
    hidden: yes
    group_label: "Counts"
  }

  measure: count_tickets_first_reply_time_within_1hr {
    type: count
    filters: [frt_null_frtless1hr: "yes"]
    drill_fields: [drill*]
    group_label: "Counts"
    label: "Count Cases First Reply Time Within 1hr"
  }

  measure: cnt_tickets_with_frt_notnull {
    type: count
    filters: [tickets_with_frt_notnull: "yes"]
    drill_fields: [drill*]
    label: "Count Cases First Reply Time Not Null"
    group_label: "Counts"
  }


  measure: percent_tickets_first_reply_time_within_1hr {
    type: number
    sql: ${count_tickets_first_reply_time_within_1hr}/NULLIF(${cnt_tickets_with_frt_notnull}, 0) ;;
    value_format_name: percent_0
    drill_fields: [drill*]
    label: "Percent Cases First Reply Time Within 1hr"
  }

 # SUM

  measure: sum_First_Reply_Time {
    type: sum
    sql: CAST(${TABLE}.response_time AS FLOAT64)/60 ;;
    group_label: "Sum"
    group_item_label: "First Reply Time"
    description: "Sum of hours to the first reply during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: sum_Full_Resolution_Time {
    type: sum
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64)/60 ;;
    group_label: "Sum"
    group_item_label: "Full Resolution Time"
    description: "Sum of hours to the full resolution during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: sum_agent_wait_time {
    type: sum
    hidden: yes
    sql: CAST(${TABLE}.agent_wait_time AS FLOAT64) ;;
    group_label: "Sum"
    group_item_label: "Agent Wait Time"
    description: "Sum of minutes the agent spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: sum_first_resolution_time {
    type: sum
    sql: CAST(${TABLE}.first_resolution_time AS FLOAT64) ;;
    group_label: "Sum"
    group_item_label: "First Resolution Time"
    description: "Sum of minutes to the first resolution time during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: sum_requester_wait_time {
    type: sum
    sql: CAST(${TABLE}.requester_wait_time AS FLOAT64) ;;
    group_label: "Sum"
    group_item_label: "Requester Wait Time"
    description: "Sum of minutes the Requester spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: sum_Reopens {
    type: sum
    sql: CAST(${TABLE}.case_reopened_count AS FLOAT64) ;;
    group_label: "Sum"
    group_item_label: "Reopens"
    description: "Sum of times a case gets reopened"
    value_format: "0"
    drill_fields: [drill*]
  }

  # MEDIAN

  measure: mdn_First_Reply_Time {
    type: median
    sql: CAST(${TABLE}.response_time AS FLOAT64)/60 ;;
    group_label: "Median"
    group_item_label: "First Reply Time"
    description: "Median of hours to the first reply during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: mdn_Full_Resolution_Time_minutes {
    type: median
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64) ;;
    group_label: "Median"
    group_item_label: "Full Resolution Time minutes"
    description: "Mdn of minutes to the full resolution during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: mdn_First_Reply_Time_minutes {
    type: median
    sql: CAST(${TABLE}.response_time AS FLOAT64) ;;
    group_label: "Median"
    group_item_label: "First Reply Time minutes"
    description: "Median of minutes to the first reply during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: mdn_Full_Resolution_Time {
    type: median
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64)/60 ;;
    group_label: "Median"
    group_item_label: "Full Resolution Time"
    description: "Mdn of hours to the full resolution during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: mdn_Reopens {
    type: median
    sql: CAST(${TABLE}.case_reopened_count AS FLOAT64) ;;
    group_label: "Median"
    group_item_label: "Reopens"
    description: "Mdn of times a case gets reopened"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: mdn_time_since_last_modified {
    type: median
    hidden: yes
    sql: CAST(${TABLE}.time_since_last_modified AS FLOAT64)/60 ;;
    group_label: "Median"
    group_item_label: "Time Since Last modified"
    description: "Mdn of time since a case was last midified in hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: mdn_agent_wait_time {
    type: median
    hidden: yes
    sql: CAST(${TABLE}.agent_wait_time AS FLOAT64) ;;
    group_label: "Median"
    group_item_label: "Agent Wait Time"
    description: "Mdn of minutes the agent spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: mdn_first_resolution_time {
    type: median
    sql: CAST(${TABLE}.first_resolution_time AS FLOAT64) ;;
    group_label: "Median"
    group_item_label: "First Resolution Time"
    description: "Mdn of minutes to the first resolution time during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: mdn_requester_wait_time {
    type: median
    sql: CAST(${TABLE}.requester_wait_time AS FLOAT64) ;;
    group_label: "Median"
    group_item_label: "Requester Wait Time"
    description: "Mdn of minutes the Requester spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  # P 90

  measure: P90_First_Reply_Time {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.response_time AS FLOAT64)/60 ;;
    group_label: "P90"
    group_item_label: "First Reply Time"
    description: "P90 of hours to the first reply during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: P90_Full_Resolution_Time {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64)/60 ;;
    group_label: "P90"
    group_item_label: "Full Resolution Time"
    description: "P90 of hours to the full resolution during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: P90_First_Reply_Time_minutes {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.response_time AS FLOAT64) ;;
    group_label: "P90"
    group_item_label: "First Reply Time minutes"
    description: "P90 of minutes to the first reply during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P90_Full_Resolution_Time_minutes {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64) ;;
    group_label: "P90"
    group_item_label: "Full Resolution Time minutes"
    description: "P90 of minutes to the full resolution during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P90_Reopens {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.case_reopened_count AS FLOAT64) ;;
    group_label: "P90"
    group_item_label: "Reopens"
    description: "P90 of times a case gets reopened"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P90_agent_wait_time {
    type: percentile
    hidden: yes
    percentile: 90
    sql: CAST(${TABLE}.agent_wait_time AS FLOAT64) ;;
    group_label: "P90"
    group_item_label: "Agent Wait Time"
    description: "P90 of minutes the agent spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P90_first_resolution_time {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.first_resolution_time AS FLOAT64) ;;
    group_label: "P90"
    group_item_label: "First Resolution Time"
    description: "P90 of minutes to the first resolution time during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P90_requester_wait_time {
    type: percentile
    percentile: 90
    sql: CAST(${TABLE}.requester_wait_time AS FLOAT64) ;;
    group_label: "P90"
    group_item_label: "Requester Wait Time"
    description: "P90 of minutes the Requester spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  # P75

  measure: P75_First_Reply_Time {
    type: percentile
    percentile: 75
    sql: CAST(${TABLE}.response_time AS FLOAT64)/60 ;;
    group_label: "P75"
    group_item_label: "First Reply Time"
    description: "P75 of hours to the first reply during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: P75_Full_Resolution_Time {
    type: percentile
    percentile: 75
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64)/60 ;;
    group_label: "P75"
    group_item_label: "Full Resolution Time"
    description: "P75 of hours to the full resolution during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: P75_agent_wait_time {
    type: percentile
    hidden: yes
    percentile: 75
    sql: CAST(${TABLE}.agent_wait_time AS FLOAT64) ;;
    group_label: "P75"
    group_item_label: "Agent Wait Time"
    description: "P75 of minutes the agent spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P75_first_resolution_time {
    type: percentile
    percentile: 75
    sql: CAST(${TABLE}.first_resolution_time AS FLOAT64) ;;
    group_label: "P75"
    group_item_label: "First Resolution Time"
    description: "P75 of minutes to the first resolution time during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P75_requester_wait_time {
    type: percentile
    percentile: 75
    sql: CAST(${TABLE}.requester_wait_time AS FLOAT64) ;;
    group_label: "P75"
    group_item_label: "Requester Wait Time"
    description: "P75 of minutes the Requester spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: P75_Reopens {
    type: percentile
    percentile: 75
    sql: CAST(${TABLE}.case_reopened_count AS FLOAT64) ;;
    group_label: "P75"
    group_item_label: "Reopens"
    description: "P75 of times a case gets reopened"
    value_format: "0"
    drill_fields: [drill*]
  }


  # AVG

  measure: avg_First_Reply_Time {
    type: average
    sql: CAST(${TABLE}.response_time AS FLOAT64)/60 ;;
    group_label: "Averages"
    group_item_label: "First Reply Time"
    description: "Avg of hours to the first reply during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: avg_Full_Resolution_Time {
    type: average
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64)/60 ;;
    group_label: "Averages"
    group_item_label: "Full Resolution Time"
    description: "Avg of hours to the full resolution during calendar hours"
    value_format: "0.0"
    drill_fields: [drill*]
  }

  measure: avg_First_Reply_Time_minutes {
    type: average
    sql: CAST(${TABLE}.response_time AS FLOAT64) ;;
    group_label: "Averages"
    group_item_label: "First Reply Time minutes"
    description: "Avg of minutes to the first reply during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: avg_Full_Resolution_Time_minutes {
    type: average
    sql: CAST(${TABLE}.full_resolution_time AS FLOAT64) ;;
    group_label: "Averages"
    group_item_label: "Full Resolution Time minutes"
    description: "Avg of minutes to the full resolution during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: avg_Reopens {
    type: average
    sql: CAST(${TABLE}.case_reopened_count AS FLOAT64) ;;
    group_label: "Averages"
    group_item_label: "Reopens"
    description: "Avg of times a case gets reopened"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: avg_time_since_last_modified {
    type: average
    hidden: yes
    sql: CAST(${TABLE}.time_since_last_modified AS FLOAT64)/60 ;;
    group_label: "Averages"
    group_item_label: "Time Since Last modified"
    description: "Avg of hours since a case was last midified in hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: avg_agent_wait_time {
    type: average
    hidden: yes
    sql: CAST(${TABLE}.agent_wait_time AS FLOAT64) ;;
    group_label: "Averages"
    group_item_label: "Agent Wait Time"
    description: "Avg of minutes the agent spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: avg_first_resolution_time {
    type: average
    sql: CAST(${TABLE}.first_resolution_time AS FLOAT64) ;;
    group_label: "Averages"
    group_item_label: "First Resolution Time"
    description: "Avg of minutes to the first resolution time during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }

  measure: avg_requester_wait_time {
    type: average
    sql: CAST(${TABLE}.requester_wait_time AS FLOAT64) ;;
    group_label: "Averages"
    group_item_label: "Requester Wait Time"
    description: "Avg of minutes the Requester spent waiting during calendar hours"
    value_format: "0"
    drill_fields: [drill*]
  }



    measure: count_cases {
      type: count_distinct
      sql: ${id} ;;
      drill_fields: [drill*]
      group_label: "Counts"
    }

    measure: count_not_spam_cases {
      type: count_distinct
      drill_fields: [drill*]
      sql: ${case_number} ;;
      filters: [reporting_values: "-Spam Mention"]
      description: "Spam cases are not counted here"
      group_label: "Counts"
    }

  measure: count_cases_closed_no_response {
    type: count
    drill_fields: [drill*]
    filters: [status: "Closed No Response"]
    description: "Count of cases with Closed No Response"
    group_label: "Counts"
  }

  measure: count_no_reopens {
    type: count
    drill_fields: [drill*]
    filters: [reopens: "0"]
    description: "Count of cases with 0 Reopens"
    group_label: "Counts"
  }

  measure: count_reopens {
    type: count_distinct
    drill_fields: [drill*]
    filters: [reopens: ">=1"]
    sql: ${case_number} ;;
    description: "Count of cases with 1 & more than 1 Reopens"
    group_label: "Counts"
  }

  measure: count_agent_addressable_cases {
    type: count_distinct
    drill_fields: [drill*]
    sql: ${case_number} ;;
    filters: [addressable_volume: "Yes"]
    description: "Count of cases that are addressable to agents and not fully automated"
    group_label: "Counts"
  }


  measure: count_automation_spam {
    type: count_distinct
    sql:CASE
    WHEN ${case_origin}="Salesforce" AND reporting_values="Automation:Spam" THEN ${case_number}
    WHEN ${case_origin}="Sprinklr" AND ${case_automation}=TRUE THEN ${case_number}
    ELSE null END;;
    description: "Count of automation spam cases"
    group_label: "Counts"
  }

  measure: automation_spam_percent {
    type: number
    description: "Percent of automation spam cases"
    label: "Automation Spam Percent"
    value_format_name: percent_0
    sql: ${count_automation_spam}/${count_cases} ;;
    drill_fields: [drill*]
  }


set: drill {
  fields: [
    id,
    case_url,
    created_date_pst_time,
    first_reply_time_time,
    response_time,
    status,
    current_tier,
    subject,
    reporting_values,
    secondary_response_value

  ]
}

  }
