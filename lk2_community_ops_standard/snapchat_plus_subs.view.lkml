view: snapchat_plus_subs {
view_label: "Snapchat Plus Subscription"
sql_table_name: (select
  *
from `sc-subscription.premium_feature_enrollment.premium_feature_enrollment_2024*`
where _table_suffix = (select max(_table_suffix) from `sc-subscription.premium_feature_enrollment.premium_feature_enrollment_2024*`)
QUALIFY ROW_NUMBER() OVER (PARTITION BY ghost_id ORDER BY state) = 1) ;;


  dimension: ghost_id {
    sql: ${TABLE}.ghost_id ;;
    type: string
    label: "Ghost ID"
  }

  dimension: pk {
    type: string
    sql: CONCAT(${ghost_id}, ${originally_subscribed_at_time}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: is_plus_user {
    type: yesno
    sql: ${TABLE}.is_plus_user ;;
    label: "Current Plus User"
  }

  dimension_group: originally_subscribed_at {
    label: "Subscribed At UTC"
    type: time
    sql: ${TABLE}.originally_subscribed_at ;;
    convert_tz: no
    timeframes: [date, month, week, year, quarter, time, month_name, week_of_year, day_of_week]
  }

  dimension: plan_type {
    sql: ${TABLE}.plan_type ;;
    type: string
    description: "platform and frequency of the plan"
    label: "Current Plan Type"
  }

  dimension: badge_visibility {
    sql: CASE WHEN ${TABLE}.badge_visibility = 1 THEN TRUE
              ELSE FALSE END;;
    type: yesno
  }

  dimension: story_rewatch_count_disabled {
    type: yesno
    sql: ${TABLE}.story_rewatch_count_disabled ;;
  }

  dimension: ghost_trails_disabled {
    type: yesno
    sql: ${TABLE}.ghost_trails_disabled ;;
  }

  dimension: custom_icon {
    sql: ${TABLE}.custom_icon ;;
    type: string
  }

  dimension: subscription_status {
    sql: ${TABLE}.state ;;
    type: string
    description: "ACTIVE, CANCELED, REVOKED, EXPIRED"
    label: "Current Subscriptions Status"
  }

  dimension: platform {
    sql: CASE WHEN ${plan_type} LIKE '%android%' THEN "android"
              WHEN ${plan_type} LIKE '%com.snapchat%' THEN "ios"
         ELSE null END ;;
        description: "ios or android"
  }


  dimension_group: expires_at {
    label: "Expires At UTC"
    type: time
    sql: ${TABLE}.expires_at ;;
    convert_tz: no
    timeframes: [date, month, week, year, quarter, time, month_name, week_of_year, day_of_week]
  }

  dimension: has_pinned_best_friend {
    type: yesno
    sql: ${TABLE}.has_pinned_best_friend ;;
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
    label: "Current Offer Type"
  }

  dimension: renew_status {
    type: yesno
    sql: CASE
          WHEN ${TABLE}.renew_status = 1 then true
          ELSE FALSE END;;
    label: "Current Renew Status"
  }

  measure: count {
    type: count
    drill_fields: [drill*]
  }

  set: drill {
    fields: [originally_subscribed_at_time,
      ghost_id,
      plan_type,
      platform,
      is_plus_user,
      subscription_status,
      expires_at_date,
      badge_visibility,
      renew_status,
      offer_type]
  }




}
