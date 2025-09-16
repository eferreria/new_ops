# most active contributor jbabra@snapchat.com
view: latest_appversions {
  derived_table: {
  sql:
      SELECT
        os_type,
        app_build,
        app_version_full,
        app_version_major,
        app_version_minor,
        app_version_integer,
        launch_date,
        days_since_launch,
        is_latest_app_version,
        is_latest_app_version_major,
        is_latest_app_version_minor

      FROM `sc-analytics.report_search.app_version_history_*`
      WHERE _TABLE_SUFFIX = (SELECT max(_TABLE_SUFFIX) FROM `sc-analytics.report_search.app_version_history_*`) ;;
  }


  dimension: os_type {
    type: string
    description: "iOS or Android"
  }

  dimension: app_build {
    type: string
    description: "beta or prod"
  }

  dimension: app_version_full {
    type: string
    description: "Detailed version like 11.5.0.61"
  }

  dimension: app_version_major {
    type: string
    description: "Major version like 11.5"
  }

  dimension: app_version_minor {
    type: string
    description: "Minor version upto 2 decimal like 11.4.5"
  }

  dimension: app_version_integer {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension_group: launch_date {
    type: time
    description: "Launch date UTC. This table is  based of DAGs running every half hour to check number of users
    on a new version, and once the number hits some preset threshold, we log it in the table"
  }

  dimension: days_since_launch {
    type: number
  }

  dimension: is_latest_app_version {
    type: yesno
  }

  dimension: is_latest_app_version_major {
    type: yesno
  }

  dimension: is_latest_app_version_minor {
    type: yesno
  }

  #iOS
  dimension: top_3_ios_version {
    sql: ${ios_top3.top_3_ios_version} ;;
    group_label: "iOS"
    label: "iOS Last 3 versions"
    type: string
    description: "last 3 iOS versions as of today"
  }

  dimension: is_ios_top3 {
    sql: ${ios_top3.is_top3_ios} ;;
    type: yesno
    group_label: "iOS"
    label: "Is iOS Last 3 versions?"
    description: "Yes/no to check if an app versions are last 3"
  }

  dimension: ios_version_rank {
    sql: ${ios_top3.ios_version_rank} ;;
    group_label: "iOS"
    label: "iOS version rank"
    type: number
    description: "Rank given to version, 1 to the latest & 3 to the oldest"
  }

  #ANDROID
  dimension: top_3_android_version {
    sql: ${android_top3.top_3_android_version} ;;
    group_label: "Android"
    label: "Android Last 3 versions"
    type: string
    description: "last 3 Android versions as of today"
  }

  dimension: is_android_top3 {
    sql: ${android_top3.is_top3_android} ;;
    type: yesno
    group_label: "Android"
    label: "Is Android Last 3 versions?"
    description: "Yes/no to check if an app versions are last 3"
  }

  dimension: android_version_rank {
    sql: ${android_top3.android_version_rank} ;;
    group_label: "Android"
    label: "Android version rank"
    type: number
    description: "Rank given to version, 1 to the latest & 3 to the oldest"
  }



  }






view: ios_top3 {

  derived_table: {
    sql:
           SELECT * from (

     SELECT
        app_version_major
        ,os_type
        ,row_number() over (partition by os_type order by app_version_major desc) as version_rank
        FROM `sc-analytics.report_search.app_version_history_*`
        WHERE _TABLE_SUFFIX = (SELECT max(_TABLE_SUFFIX) FROM `sc-analytics.report_search.app_version_history_*`)

        and os_type = "iOS"
        and app_build = "prod"
        GROUP by 1, os_type
        LIMIT 3
        )
        where version_rank IN (1,2,3)


 ;;
  }

  dimension: top_3_ios_version {
    sql: ${TABLE}.app_version_major ;;
    type: string
    primary_key: yes
  }

  dimension: is_top3_ios {
    type: yesno
    sql: CASE
        WHEN ${top_3_ios_version} is NOT NULL THEN TRUE
        ELSE FALSE
        END ;;
  }

  dimension: ios_version_rank {
    type: number
    sql: ${TABLE}.version_rank ;;
  }



#
#            SELECT
#         app_version_major
#         ,os_type
#         ,row_number() over (partition by os_type order by app_version_major desc) as version_rank
#         FROM `sc-analytics.report_search.app_version_history_*`
#         WHERE _TABLE_SUFFIX = (SELECT max(_TABLE_SUFFIX) FROM `sc-analytics.report_search.app_version_history_*`)
#
#         and os_type = "iOS"
#         GROUP by 1, os_type
#         LIMIT 3
#
}

view: android_top3 {

  derived_table: {
    sql:
    SELECT * from (

     SELECT
        app_version_major
        ,os_type
        ,row_number() over (partition by os_type order by app_version_major desc) as version_rank
        FROM `sc-analytics.report_search.app_version_history_*`
        WHERE _TABLE_SUFFIX = (SELECT max(_TABLE_SUFFIX) FROM `sc-analytics.report_search.app_version_history_*`)

        and os_type = "Android"
        and app_build = "prod"
        GROUP by 1, os_type
        LIMIT 3
        )
        where version_rank IN (1,2,3)


 ;;
  }

  dimension: top_3_android_version {
    sql: ${TABLE}.app_version_major ;;
    type: string
    primary_key: yes
  }

  dimension: is_top3_android {
    type: yesno
    sql: CASE
        WHEN ${top_3_android_version} is NOT NULL THEN TRUE
        ELSE FALSE
        END ;;
  }

  dimension: android_version_rank {
    type: number
    sql: ${TABLE}.version_rank ;;
  }

}
