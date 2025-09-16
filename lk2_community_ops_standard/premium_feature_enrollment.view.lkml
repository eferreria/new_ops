view: premium_feature_enrollment {

  view_label: "Snapchat+ Daily Status"
  sql_table_name: `sc-subscription.premium_feature_enrollment.premium_feature_enrollment_2022*` ;;

  dimension: ghost_id {
    sql: ${TABLE}.ghost_id ;;
    type: string
    label: "Ghost ID"
  }

  dimension: pk {
    type: string
    sql: CONCAT(${ghost_id}, ${daily_event_time}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: is_plus_user {
    type: yesno
    sql: ${TABLE}.is_plus_user ;;
    label: "Daily Plus User"
  }

  dimension: subscription_status {
    sql: ${TABLE}.state ;;
    type: string
    label: "Daily Subscription Status"
    description: "ACTIVE, CANCELED, REVOKED, EXPIRED"
  }

  dimension_group: daily_event {
    label: "Daily Event UTC"
    type: time
    sql: ${TABLE}.timestamp ;;
    convert_tz: no
    timeframes: [date, month, week, year, time, month_name, week_of_year, day_of_week]
  }

  dimension: event_string {
    hidden: no
    type: string
    sql: STRING(DATE(${TABLE}.timestamp)) ;;
  }

  dimension: plan_type {
    sql: ${TABLE}.plan_type ;;
    type: string
    description: "platform and frequency of the plan"
    label: "Daily Plan Type"
  }

  dimension: platform {
    sql: CASE WHEN ${plan_type} LIKE '%android%' THEN "android"
              WHEN ${plan_type} LIKE '%com.snapchat%' THEN "ios"
         ELSE null END ;;
    description: "ios or android"
    label: "Daily Platform"
  }

  dimension: offer_type {
    type: string
    sql: CASE
         WHEN ${TABLE}.offer_type = 0 then "no offer"
         WHEN ${TABLE}.offer_type = 1 then "free trail"
         WHEN ${TABLE}.offer_type = 3 then "promo code"
         ELSE "NA" END
          ;;
    description: "free trail, promo code, no offer"
    label: "Daily Offer Type"
  }

  dimension: renew_status {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.renew_status = 1 then true
          ELSE FALSE END;;
    label: "Daily Renew Status"
  }


 }
