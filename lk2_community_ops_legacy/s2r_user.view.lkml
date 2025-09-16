# most active contributor jbabra@snapchat.com
include: "//hub_looker_production/common/common_blizzard.view.lkml"
view: s2r_user {
  extends: [country_groups]

  derived_table: {

    sql: SELECT *
          FROM (
            SELECT
              *
              ,'android' AS platform
              ,'beta' AS buildFlavor
              ,'' AS userSelectedFeature
              ,'V1' AS tableType

             FROM {% table_date_range date_filter feelinsonice-hrd:shake2report_metadata_android_beta_dataset.shaketoreport_metadata_ %}
          ), (
            SELECT
              report_id AS reportid
              ,user_id AS userid
              --,'' AS username
              ,UPPER(type) AS reportType
              ,reportClientTime AS creationTime
              ,IFNULL(REGEXP_EXTRACT(userAgent, r'Snapchat\/([\d+.]+[\d])\s?[a-zA-Z]*\s[\(][^;]+;.+'), 'Unknown') AS appVersion
              ,IFNULL(REGEXP_EXTRACT(userAgent, r'Snapchat\/[\d+.]+[\d]\s?[a-zA-Z]*\s[\(][^;]+;\s([^#;]+).+'), 'Unknown') AS deviceOs
              --,'' AS deviceMake
              ,JSON_EXTRACT_SCALAR(deviceinfo, "$.model") AS deviceModel
              --,'' AS shakeSensitivity
              --,'' AS deviceScore
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.country") AS country
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.region") AS region
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.city") AS city
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.locale") AS locale
            ,JSON_EXTRACT_SCALAR(otherJsonInfo, "$.source_screen_feature_team") AS feature
            ,JSON_EXTRACT_SCALAR(otherJsonInfo, "$.source_screen") AS subFeature
            --,'' AS friendUsername
            ,description AS description
            --,'' AS isp
            ,JSON_EXTRACT_SCALAR(networkinfo, "$.connectionType") AS connectionType
            ,NULL AS bandwidth
            ,internal AS shakeType
            --,'' AS cheetahTreatment
            ,CASE
              WHEN userAgent CONTAINS 'iOS'
                THEN 'ios'
              WHEN userAgent CONTAINS 'Android'
                THEN 'android'
              ELSE 'Unknown'
             END AS platform
            ,JSON_EXTRACT_SCALAR(appinfo, "$.buildFlavor") AS buildFlavor
            ,feature AS userSelectedFeature
            , 'V2' AS tableType
          FROM [lookinsoclear:app_insights.air_reports]
          WHERE {% condition is_internal %} internal {% endcondition %}
          AND _PARTITIONTIME >= TIMESTAMP('2018-02-24')
          AND _PARTITIONTIME BETWEEN TIMESTAMP({% date_start date_filter %}) AND TIMESTAMP({% date_end date_filter %})

          AND NOT (otherJsonInfo CONTAINS "{\"from_test_automation\":true}")
        )

     ;;
    }

  filter: is_inetrnal {
    label: "Is Internal"
    type: yesno
    default_value: "no"
  }


  filter: date_filter {
    label: "Date UTC Filter"
    type: date
  }

  ## dimensions

  dimension_group: event {
    label: "Event UTC"
    type: time
    sql: ${TABLE}.creationTime ;;
  }

  dimension_group: event_pst {
    label: "Event PST"
    description: "Offset -7 hours from UTC"
    type: time
    sql: DATE_ADD(${TABLE}.creationTime,-7,'HOUR') ;;
  }

  dimension: tableType {
    description: "flag for V1 or V2"
    sql: ${TABLE}.tableType ;;
    type: string
  }

  dimension: reportId {
    description: "reportId"
    type: string
    primary_key: yes
  }

  dimension: username {
    description: "username"
    sql: ${TABLE}.username ;;
    type: string
  }

  dimension: friendUsername {
    description: "friendUsername"
    type: string
    sql: ${TABLE}.friendUsername ;;
  }

  dimension: description {
    description: "description"
    type: string
  }

  dimension: devicescore {
    description: "device score"
    sql: ${TABLE}.devicescore ;;
    type: string
  }

  dimension: appVersion {
    description: "appVersion"
    type: string
  }

  dimension: appVersion_Primary {
    description: "Primary App Version, ie. 10.7"
    type: string
    sql: REGEXP_EXTRACT(appVersion,r'(.*\..*)\.') ;;
  }

  dimension: appVersion_primary_type {
    description: "Version type is 'current', 'previous', or 'other'. Field must be manually updated upon version update."
    sql: CASE WHEN ${appVersion_Primary} = "10.26" THEN 'current' WHEN ${appVersion_Primary} = "10.25" THEN 'previous' ELSE 'other' END ;;
  }

  dimension: deviceOS {
    description: "deviceOS"
    type: string
  }

  dimension: deviceOS_group {
    description: "deviceOS_group"
    type: string
    sql: left(${TABLE}.deviceOS,9) ;;
  }

  dimension: deviceMake {
    description: "deviceMake"
    sql: ${TABLE}.deviceMake ;;
    type: string
  }

  dimension: deviceModel {
    description: "deviceModel"
    type: string
  }

  dimension: deviceName {
    description: "deviceName"
    type: string
  }

  dimension: country {
    description: "country"
    type: string
  }

  dimension: region {
    description: "region"
    type: string
  }

  dimension: city {
    description: "city"
    type: string
  }

  dimension: locale {
    description: "locale"
    type: string
  }

  dimension: feature {
    description: "feature"
    type: string
  }

  dimension: subfeature {
    description: "subfeature"
    type: string
  }

  dimension: ISP {
    description: "ISP"
    type: string
    sql: ${TABLE}.isp ;;
  }

  dimension: connectionType {
    description: "connectionType"
    type: string
  }

  dimension: bandwidth {
    description: "bandwidth"
    type: number
  }

  dimension: bandwidth_group {
    description: "bandwidth_group"
    type: number
    sql: CASE
          WHEN ${TABLE}.bandwidth >=500000 THEN 500000
        ELSE floor(${TABLE}.bandwidth/1000)*1000
        END
         ;;
  }

  dimension: reportType {
    description: "reportType"
    type: string
  }

  dimension: cheetahTreatment {
    description: "cheetahTreatment"
    sql: ${TABLE}.cheetahTreatment  ;;
    type: string
  }

  dimension: platform {
    sql: ${TABLE}.platform ;;
    type: string
  }

  dimension: buildFlavor {
    sql: ${TABLE}.buildFlavor ;;
    type: string
  }

  dimension: userSelectedFeature {
    sql: ${TABLE}.userSelectedFeature ;;
    type: string
  }

  dimension: userId {
    sql: ${TABLE}.userId ;;
    type: string
  }

  ## measures

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: avg_bandwidth {
    type: average
    sql: ${TABLE}.bandwidth ;;
    drill_fields: [detail*]
  }

  measure: number_of_unique_user {
    type: count_distinct
    sql: COALESCE(${username},${userId}) ;;
    drill_fields: [detail*]
    approximate_threshold: 100000
  }

  set: detail {
    fields: [event_time,
      feature,
      subfeature,
      country,
      bandwidth,
      deviceModel,
      deviceName,
      deviceOS,
      appVersion,
      reportId,
      username,
      description
    ]
  }
}
