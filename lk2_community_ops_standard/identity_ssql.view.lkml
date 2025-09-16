# most active contributor jbabra@snapchat.com
view: identity_ssql {

  derived_table: {
    sql: SELECT
          lastEngagementTime AS lastEngagementTime,
          creationTime AS creationTime,
          ghost_user_id AS ghost_user_id,
          isPhoneVerified AS isPhoneVerified,
          isEmailVerified as isEmailVerified,
          hasBitmoji as hasBitmoji,
          isTestUser as isTestUser,
          friendCount as friendCount,
          snapPrivacy as snapPrivacy,
          storyPrivacy as storyPrivacy,
          age as age,
          version AS version,
          lastCountry as lastCountry,
          hasDisplayName as hasDisplayName

        FROM   `sc-analytics.report_user.identity_2*`
        WHERE
        _TABLE_SUFFIX = RIGHT(FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE("America/Los_Angeles"), INTERVAL 2 DAY)), 7)
          ;;

#changed interval 1 to 2
          #persist_for: "24 hours"
  }

#Dimensions

  dimension: ghost_user_id {
    type: string
    sql: ${TABLE}.ghost_user_id ;;
    primary_key: yes
  }

  dimension_group: last_engagement_time {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.lastEngagementTime ;;
  }

  dimension_group: account_creation_time {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.creationTime ;;
  }

  dimension: is_Phone_Verified {
    type: yesno
    sql: ${TABLE}.isPhoneVerified ;;
  }

  dimension: is_Email_Verified {
    type: yesno
    sql: ${TABLE}.isEmailVerified ;;
  }

  dimension: has_Bitmoji {
    type: yesno
    sql: ${TABLE}.hasBitmoji ;;
  }

  dimension: is_Test_User {
    type: yesno
    sql: ${TABLE}.isTestUser ;;
  }

  dimension: friend_range {
    type: tier
    tiers: [0, 10, 20, 50, 100, 300, 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000]
    style: integer
    sql: ${TABLE}.friendCount
      ;;
  }

  dimension: snap_Privacy {
    type: string
    sql: ${TABLE}.snapPrivacy;;
    description: "friends, everyone, custom"
  }

  dimension: story_Privacy {
    type: string
    sql: ${TABLE}.storyPrivacy;;
    description: "friends, everyone, custom"
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_range {
    type: tier
    tiers: [0, 10, 15, 20, 25, 30, 40, 50, 60, 70, 80]
    style: integer
    sql: ${TABLE}.age ;;

  }

  dimension: has_Display_Name {
    type: yesno
    sql: ${TABLE}.hasDisplayName ;;
  }


  dimension: lastCountry {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.lastCountry ;;
  }

  dimension: snap_version {
    type: string
    sql: ${TABLE}.version ;;
  }


  dimension: churn_days {
    label: "Days since last active"
    description: "difference between today's date and last engagement date in UTC"
    type: number
    sql: DATE_DIFF( CURRENT_DATE(), ${last_engagement_time_date}, DAY) ;;

  }

  dimension: days_between_account_created_and_report_date {
    label: "# of Days bw account created & report date"
    description: "difference between report date and account created date in UTC"
    type: number
    sql: DATE_DIFF(DATE(${in_app_reports_stdsql.event_date}) , ${account_creation_time_date}, DAY) ;;

  }


# Measures

  measure: count {
    type: count
    label: "Count of unique GhostIds"
    # sql: ${userid} ;;
    drill_fields: [churn_days, last_engagement_time_date, ghost_user_id, friend_range]

  }


}
