view: in_app_support_customer {

  derived_table: {
    sql:
      (SELECT
          event_time,
          client_id,
          app_build,
          app_version,
          client_ts,
          country,
          device_connectivity,
          device_model,
          event_hour_ts,
          event_name,
          event_sampling_rate,
          user_sampling_rate,
          locale,
          os_minor_version,
          os_version,
          os_type,
          region,
          server_ts,
          time_on_page_sec,
          ui_location,
          user_action,
          user_agent,
          NULL as support_setting_item
        FROM `sc-analytics.prod_analytics_ops_security.daily_events_*`

      WHERE
      event_name = "IN_APP_SUPPORT_LOGIN_HELP"

      AND _TABLE_SUFFIX BETWEEN
      REPLACE(CAST({% date_start date_filter %} AS STRING), "-","") and
      REPLACE(CAST({% date_end date_filter %} AS STRING), "-",""))

      UNION ALL

      (SELECT
        event_time,
        client_id,
        app_build,
        app_version,
        client_ts,
        country,
        device_connectivity,
        device_model,
        event_hour_ts,
        event_name,
        event_sampling_rate,
        user_sampling_rate,
        locale,
        os_minor_version,
        os_version,
        os_type,
        region,
        server_ts,
        NULL as time_on_page_sec,
        NULL as ui_location,
        NULL as user_action,
        user_agent,
        support_setting_item
      FROM `sc-analytics.prod_analytics_app.daily_events_*`
      WHERE
        support_setting_item IN (
          "LOST_MY_SNAPSTREAK", "HELP_CENTER", "REPORT_AN_ISSUE",
          "HAVE_A_SUGGESTION", "SHAKE_TO_REPORT", "MADE_FOR_ME",
          "REPORT_A_SAFETY_CONCERN", "PRIVACY_QUESTIONS", "SAFETY_CENTER",
          "PRIVACY_CENTER", "FAMILY_CENTER", "HAVE_A_PRIVACY_ISSUE")
        AND _TABLE_SUFFIX BETWEEN
          REPLACE(CAST({% date_start date_filter %} AS STRING), "-","") and
          REPLACE(CAST({% date_end date_filter %} AS STRING), "-",""))
      ;;
    # persist_for: "24 hours"
  }


filter: date_filter {
  type: date
  default_value: "14 days ago for 14 days"
  convert_tz: no
}

###DIMENSIONS

dimension_group: event_utc {
  type: time
  label: "Event Time UTC"
  sql: ${TABLE}.event_time ;;
  convert_tz: no
}

dimension: pk {
  type: string
  sql: CONCAT(${client_id}, '|', ${event_time}) ;;
  primary_key: yes
  hidden: no
}

dimension: app_build  {
  label: "App Build"
  type: string
  sql: ${TABLE}.app_build ;;
  description: "indicates the build type [MASTER, DEBUG, ALPHA, UIAUTOMATION, etc], blank for prod."
}

dimension: app_version {
  label: "App Version"
  type: string
  sql: ${TABLE}.app_version ;;
  description: "indicates the version of the app on the device i.e. 9.29.0"
}

dimension: client_id {
  label: "Client ID"
  type: string
  sql: ${TABLE}.client_id  ;;
  description: "client-generated UUID tied to the app, resets every 30 days."
}

dimension: client_ts {
  label: "Client Timestamp"
  type: date_time
  sql: ${TABLE}.client_ts ;;
  description: "client timestamp as recorded by the device"
}

dimension: country {
  label: "Country"
  type: string
  sql: ${TABLE}.country ;;
  description: "Two letter country code as defined by Digital Envoy IP lookup. Country code ZZ means unknown. Note: EU can be a valid code denoting IP ranges we know are in Europe, but don't have specific geographic data for them at the time."
}

dimension: device_connectivity {
  label: "Device Connectivity"
  type: string
  sql: ${TABLE}.device_connectivity ;;
  description: "indicates if device is currently on wifi, mobile, unreachable."
}

dimension: device_model {
  label: "Device Model"
  type: string
  sql: ${TABLE}.device_model ;;
  description: "The model of the device i.e. Nexus 4, iPhone7.2"
}

dimension: event_hour_ts {
  label: "Event Hour Timestamp"
  type: date_time
  sql: ${TABLE}.event_hour_ts ;;
  description: "The hour of the event, used for timezone shifting"
}

dimension: event_name {
  label: "Event Name"
  type: string
  sql: ${TABLE}.event_name ;;
  description: "The name of the event. Use 'IN_APP_SUPPORT_LOGIN_HELP' for in-app support data. Use 'IN_SETTING_SUPPORT_ITEM_CLICK' for app setting data."
}

dimension: event_sampling_rate {
  label: "Event Sampling Rate"
  type: number
  sql: ${TABLE}.event_sampling_rate ;;
  description: "The per-event sampling rate that was in effect for this event when it was logged"
}

dimension: user_sampling_rate {
  label: "User Sampling Rate"
  type: number
  sql: COALESCE (${TABLE}.user_sampling_rate, null) ;;
  description: ""
}

dimension: event_time {
  label: "Event Time"
  type: date_time
  sql: ${TABLE}.event_time ;;
  # description: "it is a way to handle late data where if the data is received by the server is 6 hours late, we use the server_ts. server_ts is time of collection. client_ts is the time in which the event was logged. if client_ts is between server_ts minus 6 hour and server_ts, then event_time = client_ts. Else event_time=server_ts."
}

dimension: locale {
  label: "Locale"
  type: string
  sql: ${TABLE}.locale ;;
  description: "The locale of the device, e.g. en_US"
}

dimension: os_minor_version {
  label: "OS Minor Version"
  type: string
  sql: ${TABLE}.os_minor_version ;;
  description: "Indicates minor version of the OS, only for Android, usually for manufacturer or carrier specific build"
}

dimension: os_type {
  label: "OS Type"
  type: string
  sql: ${TABLE}.os_type ;;
  description: "The os type i.e. Android, iOS"
}

dimension: os_version {
  label: "OS Version"
  type: string
  sql: ${TABLE}.os_version ;;
  description: "The versione of the OS i.e.'9.3.4' for iOS and '5.1.1' for Android"
}

dimension: region {
  label: "Region"
  type: string
  sql: ${TABLE}.region ;;
  description: "State or region as defined by Digital Envoy IP lookup"
}

dimension: server_ts {
  label: "Server Timestamp"
  type: date_time
  sql: ${TABLE}.server_ts ;;
  description: "timestamp as recorded by the server"
}

dimension: support_setting_item {
  label: "Support Setting Item"
  type: string
  sql: CASE
        WHEN ${TABLE}.support_setting_item = "LOST_MY_SNAPSTREAK" THEN "I lost my Snapstreak"
        WHEN ${TABLE}.support_setting_item = "HELP_CENTER" THEN "Help Center"
        WHEN ${TABLE}.support_setting_item = "REPORT_AN_ISSUE" THEN "Report a bug"
        WHEN ${TABLE}.support_setting_item = "HAVE_A_SUGGESTION" THEN "Make a suggestion"
        WHEN ${TABLE}.support_setting_item = "SHAKE_TO_REPORT" THEN "Shake to report"
        WHEN ${TABLE}.support_setting_item = "MADE_FOR_ME" THEN "Made for Me"
        WHEN ${TABLE}.support_setting_item = "REPORT_A_SAFETY_CONCERN" THEN "How to report a safety concern"
        WHEN ${TABLE}.support_setting_item = "PRIVACY_QUESTIONS" THEN "Frequently asked privacy questions"
        WHEN ${TABLE}.support_setting_item = "SAFETY_CENTER" THEN "Safety Center"
        WHEN ${TABLE}.support_setting_item = "PRIVACY_CENTER" THEN "Privacy Center"
        WHEN ${TABLE}.support_setting_item = "FAMILY_CENTER" THEN "Family Center"
        WHEN ${TABLE}.support_setting_item = "HAVE_A_PRIVACY_ISSUE" THEN "I have a privacy question"
        ELSE "Other"
        END ;;
  description: "User setting action. Data is filtered to only contain 'HELP_CENTER', 'REPORT_A_SAFETY_CONCERN', 'HAVE_A_PRIVACY_ISSUE', 'REPORT_AN_ISSUE', 'HAVE_A_SUGGESTION', 'SHAKE_TO_REPORT' support setting items."
}

dimension: time_on_page_sec {
  label: "Time on Page (Seconds)"
  type: number
  sql: ${TABLE}.time_on_page_sec ;;
  description: "length of time (in seconds) on current page at time of event"
}

dimension: ui_location {
  label: "UI Location"
  type: string
  sql: ${TABLE}.ui_location ;;
  description: "Roughly corresponds with the page of the support flow"
}

dimension: user_action {
  label: "User Action"
  type: string
  sql: ${TABLE}.user_action ;;
  description: "Corresponds to user actions within the UI (excluding interaction within the webview)"
}

dimension: user_agent {
  label: "User Agent"
  type: string
  sql: ${TABLE}.user_agent ;;
  description: "Browser user agent (applies to events logged on web only; note: historically set to *snapchat* user agent on mobile, but this is no longer set - use specific fields like appVersion instead)"
}

dimension: total_sampling_rate{
  label: "Total Sampling Rate"
  type: number
  sql: COALESCE ((${user_sampling_rate}*${event_sampling_rate}), NULL) ;;
}

###MEASURES

measure: count_distinct_client_id {
  label: "Count Distinct Client ID"
  type: count_distinct
  sql: ${client_id} ;;
  description: "Number of unique client ID's"
}

measure: count_client_id {
  label: "Count Client ID"
  type: count
  # sql: ${client_id} ;;
  description: "Number of client ID's"
}

measure: count_survey_no{
  label: "Count Survey No"
  type: count
  description: "Number of 'No' votes on survey"
  filters: [user_action: "CONTENT_SURVEY_NO_BUTTON"]
}

measure: count_survey_yes{
  label: "Count Survey Yes"
  type: count
  description: "Number of 'Yes' votes on survey"
  filters: [user_action: "CONTENT_SURVEY_YES_BUTTON"]
}

measure: count_account_compromised{
  label: "Count Topic Account Compromised"
  type: count
  # description: "Number of 'No' votes on survey"
  filters: [ui_location: "TOPIC_ACCOUNT_COMPROMISED"]
}

measure: count_account_compromised_distinct{
    label: "Count Distinct Topic Account Compromised"
    type: count_distinct
    sql: ${client_id} ;;
    # description: "Number of 'No' votes on survey"
    filters: [ui_location: "TOPIC_ACCOUNT_COMPROMISED"]
  }

measure: count_error_message{
  label: "Count Topic Error message"
  type: count
  # description: "Number of 'No' votes on survey"
  filters: [ui_location: "TOPIC_ERROR_MESSAGE"]
}

measure: count_error_message_distinct{
    label: "Count Distinct Topic Error message"
    type: count_distinct
    sql: ${client_id} ;;
    # description: "Number of 'No' votes on survey"
    filters: [ui_location: "TOPIC_ERROR_MESSAGE"]
  }

measure: count_phone_forgot{
  label: "Count Topic Phone Forgot"
  type: count
  # description: "Number of 'No' votes on survey"
  filters: [ui_location: "TOPIC_PHONE_FORGOT"]
}

measure: count_phone_forgot_distinct{
  label: "Count Distinct Topic Phone Forgot"
  type: count_distinct
  sql: ${client_id} ;;
  # description: "Number of 'No' votes on survey"
  filters: [ui_location: "TOPIC_PHONE_FORGOT"]
}

measure: count_phone_lost_access{
  label: "Count Topic Phone Lost Access"
  type: count
  # description: "Number of 'No' votes on survey"
  filters: [ui_location: "TOPIC_PHONE_LOST_ACCESS"]
}

measure: count_phone_lost_access_distinct{
    label: "Count Distinct Topic Phone Lost Access"
    type: count_distinct
    sql: ${client_id} ;;
    # description: "Number of 'No' votes on survey"
    filters: [ui_location: "TOPIC_PHONE_LOST_ACCESS"]
  }

measure: count_user_action_content_link_webview {
  label: "Count 'Content Link Webview' Action"
  type: count
  filters: [user_action: "CONTENT_LINK_WEBVIEW"]
}

measure: avg_sampling_rate {
  label: "Average total sampling rate"
  type: average
  sql: ${total_sampling_rate} ;;
}

measure: population_size{
  label: "Population Size"
  type: number
  sql: ${count_client_id}/${avg_sampling_rate} ;;
}


#%CSAT
measure: CSAT_score {
  label: "CSAT Score"
  group_label: "CSAT"
  type: number
  value_format_name: percent_2
  sql: ${count_survey_yes}/(${count_survey_no}+${count_survey_yes}) ;;
  description: "number of Yes entries/total number of survery entries"
}

measure: CSAT_change {
  label: "CSAT change"
  group_label: "CSAT"
  type: percent_of_previous
  sql: ${CSAT_score} ;;
  description: "% difference in CSAT compared to the previous row (dependent on sort order)."
}

measure: CSAT_response_rate {
  label: "CSAT Response Rate"
  group_label: "CSAT"
  type: number
  value_format_name: percent_2
  sql:((${count_survey_no}+${count_survey_yes}) /
    (${count_account_compromised}+${count_error_message}+${count_phone_forgot}+${count_phone_lost_access})) ;;
}

measure: avg_time_on_page_sec {
  label: "Average Time"
  group_label: "CSAT"
  type: average
  value_format: "0.00"
  sql: ${time_on_page_sec} ;;
  description: "Average time on page in seconds"
}


}
