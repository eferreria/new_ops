# most active contributor jbabra@snapchat.com
view: appinstall_matched_events {
label: "Sanitized App Install Matched Events 🧴"
  derived_table: {
    sql:
         SELECT *
        FROM  `attribution-platform.sanitized_events.appinstall_matched_events_*`
        WHERE {% condition date_filter %} TIMESTAMP(PARSE_DATE('%E4Y%m%d', _TABLE_SUFFIX)) {% endcondition %}
    ;;
    }

#Table filter

  filter: date_filter {
    label: "Table Filter"
    description: "Adding this filter will only query specific tables in the YYYYMMDD format. Not adding this filter will query all tables, all time"
    type: date
    convert_tz: no
  }

  #Records

  dimension: attribution_req_data {
    hidden: yes
  }

  dimension: attribution_events {
    hidden: yes
  }


#Dimensions

#   dimension: valid_item_id {
#     type: number
#     sql: ${TABLE}.attribution_req_data.productinfo.valid_item_id;;
#   } need a new view to be joined
# same will these nested columns - attribution_events.ad_account_id


  dimension: gdpr_status {
    label: "GDPR Status"
    type: string
    sql: ${TABLE}.gdpr_status ;;
  }

  dimension: said {
    type: string
    sql: ${TABLE}.said ;;
    primary_key: yes
    label: "SAID"
    group_label: "IDs"
  }

  dimension: duplicate_type {
    type: string
    sql: ${TABLE}.duplicate_type ;;
  }

  dimension: ccpa_status {
    type: string
    sql: ${TABLE}.ccpa_status ;;
    label: "CCPA Status"
  }

  #Nested columns for - attribution_req_data column

  dimension: eventid {
    type: number
    sql: ${TABLE}.attribution_req_data.eventid;;
    label: "Event ID"
    group_label: "IDs"
  }

  dimension: processed_snap_app_ids {
    type: string
    label: "Processed Snap App ID"
    group_label: "IDs"
    sql: ARRAY_TO_STRING(${TABLE}.attribution_req_data.processed_snap_app_ids, " , ") ;;
    description: "Since this is an array, when filtering, use CONTAINS"
  }
  #Mode = REPEATED in BQ so we need to convert array to string.

  dimension: appid {
    label: "App ID"
    group_label: "IDs"
    type: string
    sql: ${TABLE}.attribution_req_data.appid ;;
  }

  dimension: conversionevent {
    type: string
    sql: ${TABLE}.attribution_req_data.conversionevent ;;
    label: "Conversion Event"
    group_label: "Events"
  }

  dimension: requestid {
    type: string
    sql: ${TABLE}.attribution_req_data.requestid ;;
    label: "Request ID"
    group_label: "IDs"
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.attribution_req_data.platform ;;
  }

  dimension: eventsource {
    type: string
    sql: ${TABLE}.attribution_req_data.eventsource ;;
    label: "Event Source"
    group_label: "Events"
  }

  dimension: eventconversiontype {
    type: string
    sql: ${TABLE}.attribution_req_data.eventconversiontype ;;
    label: "Event Conversion Type"
    group_label: "Events"
  }

  dimension: snapappid {
    type: string
    sql: ${TABLE}.attribution_req_data.snapappid ;;
    label: "Snap App ID"
    group_label: "IDs"
  }

  dimension: partner {
    type: string
    sql: ${TABLE}.attribution_req_data.partner ;;
  }

  dimension: contenttype {
    type: string
    sql: ${TABLE}.attribution_req_data.contenttype ;;
    label: "Content Type"

  }





  #Measures

  measure: count_distinct_saids {
    type: count_distinct
    sql: ${TABLE}.said;;
    group_label: "Count Distint IDs"
    label: "SAIDs"
  }

  measure: count_distinct_eventid {
    type: count_distinct
    sql: ${TABLE}.attribution_req_data.eventid ;;
    group_label: "Count Distint IDs"
    label: "Event IDs"
  }

  measure: count_distinct_processed_snap_app_ids {
    type: count_distinct
    sql: ${TABLE}.attribution_req_data.processed_snap_app_ids ;;
    group_label: "Count Distint IDs"
    label: "Processed Snap App IDs"
  }

  measure: count_distinct_appid {
    type: count_distinct
    sql: ${TABLE}.attribution_req_data.appid ;;
    group_label: "Count Distint IDs"
    label: "App IDs"
  }

  measure: count_distinct_snapappid {
    type: count_distinct
    sql: ${TABLE}.attribution_req_data.snapappid ;;
    group_label: "Count Distint IDs"
    label: "Snap APP IDs"
  }


























}
