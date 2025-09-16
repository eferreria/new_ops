view: page_session_interaction {
  derived_table: {
    sql:
    SELECT *
    FROM (
      SELECT *
      FROM
      { sc-analytics:report_discover_feed.aggregated_page_session_interaction_ % date_range_filter date_filter %}
      where date_pst is not null AND (num_users > 0 OR discover_feed_penetration_denominator > 0)),
      (SELECT * FROM [sc-analytics:report_discover_feed.aggregated_page_session_interaction_20190725] WHERE 1 > 2),
      (SELECT * FROM [sc-analytics:report_discover_feed.aggregated_page_session_interaction_20200206] WHERE 1 > 2)
    ;;
  }

  parameter: aggregation_period {
    type: number
  }


  dimension: aggregation_period_pass_through {
    type: number
    sql: {% parameter aggregation_period %} ;;

  }

  filter: date_filter {
    type: date
  }

  dimension_group: date_pst {
    description: "date_pst"
    type: time
    sql: ${TABLE}.date_pst ;;
  }

  dimension: page_type {
    description: "page_type"
    type: string
    sql: IFNULL(${TABLE}.page_type, 'all') ;;
    suggestions: [
      "all", "DISCOVER_FEED", "PREMIUM_FEED"
    ]
  }

  dimension: app_build {
    description: "app_build"
    type: string
    sql: ${TABLE}.app_build;;
  }

  dimension: slice_type {
    description: "slice_type"
    type: string
    sql: ${TABLE}.slice_type;;
  }

  dimension: slice {
    description: "slice"
    type: string
    sql: RTRIM(${TABLE}.slice);;
  }

  dimension: gender {
    description: "gender"
    type: string
    sql: ${TABLE}.gender;;
  }

  dimension: inferred_age_bucket {
    description: "inferred_age_bucket"
    type: string
    sql: ${TABLE}.inferred_age_bucket;;
  }

  measure: num_users {
    description: "num_users"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users;;
  }

  measure: non_friend_story_view_time {
    description: "non_friend_story_view_time"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.non_friend_story_view_time;;
  }

  measure: story_view_time {
    description: "friend_story_view_time"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.story_view_time;;
  }

  measure: num_users_has_page_scroll {
    description: "num_users_has_page_scroll"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_scroll;;
  }

  measure: num_users_has_page_scroll_friends {
    description: "num_users_has_page_scroll_friends"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_scroll_friends;;
  }

  measure: num_users_has_page_scroll_subscriptions {
    description: "num_users_has_page_scroll_subscriptions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_scroll_subscriptions;;
  }

  measure: num_users_has_page_refresh {
    description: "num_users_has_page_refresh"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_refresh;;
  }
  measure: num_users_has_page_expire {
    description: "num_users_has_page_expire"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_expire;;
  }

  measure: num_users_has_page_open {
    description: "num_users_has_page_open"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_open;;
  }

  measure: num_users_has_is_abandoned {
    description: "num_users_has_is_abandoned"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_is_abandoned;;
  }

  measure: num_users_has_is_abandoned_no_scroll {
    description: "num_users_has_is_abandoned_no_scroll"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_is_abandoned_no_scroll;;
  }

  measure: num_users_has_max_item_pos_with_long_imp_at_4 {
    description: "num_users_has_max_item_pos_with_long_imp_at_4"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_max_item_pos_with_long_imp_at_4;;
  }

  measure: num_users_has_max_item_pos_with_long_imp_at_10 {
    description: "num_users_has_max_item_pos_with_long_imp_at_10"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_max_item_pos_with_long_imp_at_10;;
  }

  measure: num_users_has_max_item_pos_with_long_imp_at_20 {
    description: "num_users_has_max_item_pos_with_long_imp_at_20"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_max_item_pos_with_long_imp_at_20;;
  }

  measure: num_users_has_max_item_pos_with_long_imp_at_50 {
    description: "num_users_has_max_item_pos_with_long_imp_at_50"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_max_item_pos_with_long_imp_at_50;;
  }

  measure: num_users_has_max_item_pos_with_long_imp_at_100 {
    description: "num_users_has_max_item_pos_with_long_imp_at_100"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_max_item_pos_with_long_imp_at_100;;
  }

  measure: num_users_has_max_item_pos_with_long_imp_above_100 {
    description: "num_users_has_max_item_pos_with_long_imp_above_100"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_max_item_pos_with_long_imp_above_100;;
  }

  measure: num_users_has_bounced_session {
    description: "Number of users with bounced sessions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_bounced_session;;
  }

  measure: num_page_sessions {
    description: "num_page_sessions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions;;
  }

  measure: num_page_sessions_with_story_view_only {
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_story_view_only;;
  }

  measure: num_bounce_rate_eligible_sessions {
    description: "Number of sessions used as the denominator for bounce rate"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_bounce_rate_eligible_sessions;;
  }

  measure: num_bounced_sessions {
    description: "Number of bounced sessions: sessions without any impressions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_bounced_sessions;;
  }

  measure: num_page_scroll {
    description: "num_page_scroll"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_scroll;;
  }

  measure: num_long_impression {
    description: "num_long_impression"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_long_impression;;
  }


  measure: num_page_scroll_friends {
    description: "num_page_scroll_friends"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_scroll_friends;;
  }

  measure: num_page_scroll_subscriptions {
    description: "num_page_scroll_subscriptions"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_scroll_subscriptions;;
  }
  measure: num_page_refresh {
    description: "num_page_refresh"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_refresh;;
  }
  measure: num_page_expire {
    description: "num_page_expire"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_expire;;
  }
  measure: num_page_open {
    description: "num_page_open"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_open;;
  }
  measure: num_is_abandoned {
    description: "num_is_abandoned"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_is_abandoned;;
  }
  measure: num_is_abandoned_no_scroll {
    description: "num_is_abandoned_no_scroll"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_is_abandoned_no_scroll;;
  }

  measure: page_view_time {
    description: "page_view_time"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.page_view_time;;
  }

  measure: p25_page_view_time {
    description: "page_view_time"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.p25_page_view_time;;
  }

  measure: p50_page_view_time {
    description: "page_view_time"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.p50_page_view_time;;
  }

  measure: p75_page_view_time {
    description: "page_view_time"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.p75_page_view_time;;
  }

  measure: p90_page_view_time {
    description: "page_view_time"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.p90_page_view_time;;
  }

  measure: p95_page_view_time {
    description: "page_view_time"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.p95_page_view_time;;
  }

  measure: num_page_view {
    description: "num_page_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_view;;
  }

  measure: num_discover_feed_bounce {
    description: "num_discover_feed_bounce"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_discover_feed_bounce;;
  }

  measure: num_discover_feed_friend_bounce {
    description: "num_discover_feed_friend_bounce"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_discover_feed_friend_bounce;;
  }

  measure: num_discover_feed_non_friend_bounce {
    description: "num_discover_feed_non_friend_bounce"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_discover_feed_non_friend_bounce;;
  }

  measure: page_view_time_minute {
    description: "page_view_time (minute)"
    type: sum
    value_format_name: decimal_4
    sql: ${TABLE}.page_view_time / 60;;
  }
  measure: num_max_item_pos_with_long_imp_at_4 {
    description: "num_max_item_pos_with_long_imp_at_4"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_at_4;;
  }
  measure: num_max_item_pos_with_long_imp_at_10 {
    description: "num_max_item_pos_with_long_imp_at_10"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_at_10;;
  }
  measure: num_max_item_pos_with_long_imp_at_20 {
    description: "num_max_item_pos_with_long_imp_at_20"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_at_20;;
  }
  measure: num_max_item_pos_with_long_imp_at_50 {
    description: "num_max_item_pos_with_long_imp_at_50"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_at_50;;
  }
  measure: num_max_item_pos_with_long_imp_at_100 {
    description: "num_max_item_pos_with_long_imp_at_100"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_at_100;;
  }
  measure: num_max_item_pos_with_long_imp_above_100 {
    description: "num_max_item_pos_with_long_imp_above_100"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_above_100;;
  }
  measure: num_users_has_story_view {
    description: "num_users_has_story_view"
    type: sum
    value_format_name: decimal_0
    sql: IFNULL(${TABLE}.num_users_has_non_friend_story_view, ${TABLE}.num_users_has_story_view);;
  }
  measure: num_users_has_publisher_story_view {
    description: "num_users_has_publisher_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_publisher_story_view;;
  }
  measure: num_users_has_following_story_view {
    description: "num_users_has_following_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_following_story_view;;
  }
  measure: num_users_has_public_user_following_story_view {
    label: "Num Users Has Official/Public Following Story View"
    description: "num_users_has_public_user_following_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_public_user_following_story_view;;
  }
  measure: num_users_has_publisher_following_story_view {
    description: "num_users_has_publisher_following_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_publisher_following_story_view;;
  }
  measure: num_users_has_happy_view {
    description: "num_users_has_happy_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_happy_view;;
  }
  measure: num_users_has_long_session_with_no_imp {
    description: "num_users_has_long_session_with_no_imp"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_max_item_pos_with_long_imp_above_100;;
  }

  measure: num_users_has_page_view {
    description: "num_users_has_page_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_page_view;;
  }

  measure: num_users_has_discover_feed_bounce {
    description: "num_users_has_discover_feed_bounce"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_discover_feed_bounce;;
  }

  measure: num_users_has_discover_feed_friend_bounce {
    description: "num_users_has_discover_feed_friend_bounce"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_discover_feed_friend_bounce;;
  }

  measure: num_users_has_discover_feed_non_friend_bounce {
    description: "num_users_has_discover_feed_non_friend_bounce"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_discover_feed_non_friend_bounce;;
  }

  measure: num_has_story_view {
    description: "num_has_story_view"
    type: sum
    value_format_name: decimal_0
    sql: IFNULL(${TABLE}.num_has_non_friend_story_view, ${TABLE}.num_has_story_view);;
  }

  measure: num_has_publisher_story_view {
    description: "num_has_publisher_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_has_publisher_story_view;;
  }

  measure: num_has_following_story_view {
    description: "num_has_following_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_has_following_story_view;;
  }

  measure: num_has_public_user_following_story_view {
    label: "Num Has Official/Public Following Story View"
    description: "num_has_public_user_following_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_has_public_user_following_story_view;;
  }

  measure: num_has_publisher_following_story_view {
    description: "num_has_publisher_following_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_has_publisher_following_story_view;;
  }

  measure: num_has_happy_view {
    description: "num_has_happy_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_has_happy_view;;
  }

  measure: num_long_session_with_no_imp {
    description: "num_long_session_with_no_imp"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_long_session_with_no_imp;;
  }

  measure: discover_feed_penetration_denominator {
    description: "discover_feed_penetration_denominator"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.discover_feed_penetration_denominator;;
  }

  measure: num_users_has_impression {
    description: "num_users_has_impression"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_impression;;
  }

  measure: num_users_has_long_impression {
    description: "num_users_has_long_impression"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_long_impression;;
  }

  measure: num_page_sessions_with_imp {
    description: "num_page_sessions_with_imp"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_imp;;
  }

  measure: num_page_sessions_with_long_imp {
    description: "num_page_sessions_with_long_imp"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_long_imp;;
  }

  measure: num_page_sessions_with_story_view {
    description: "page sessions with story or snap view event"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_has_any_story_view;;
  }

  measure: num_page_sessions_with_friend_story_view {
    description: "page sessions with friend Story View"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_friend_story_view;;
  }

  measure: num_page_sessions_with_ugc_story_view {
    description: "page sessions with UGC Story View"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_ugc_story_view;;
  }

  measure: num_page_sessions_with_premium_story_view {
    description: "page sessions with Premium Story View"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_premium_story_view;;
  }

  measure: num_page_sessions_with_snap_view_event {
    description: "page sessions with snap view event"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_snap_view;;
  }

  measure: num_page_sessions_with_story_view_event {
    description: "page sessions with story view event"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_story_view;;
  }

  measure: num_page_sessions_with_story_view_without_snap_view {
    description: "page sessions with story view event without snap view event"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_story_view_without_snap_view;;
  }

  measure: num_page_sessions_with_snap_view_without_story_view {
    description: "page sessions without story view event with snap view event"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_snap_view_without_story_view;;
  }

  measure: num_page_sessions_with_any_spotlight_imp {
    description: "num_page_sessions_with_any_spotlight_imp"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_any_spotlight_imp;;
  }

  measure: num_page_sessions_with_spotlight_story_view {
    description: "num_page_sessions_with_spotlight_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_spotlight_story_view;;
  }

  measure: num_page_sessions_with_1_plus_spotlight_story_view {
    description: "num_page_sessions_with_1_plus_spotlight_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_1_plus_spotlight_story_view;;
  }

  measure: num_page_sessions_with_1_plus_spotlight_snap_view {
    description: "num_page_sessions_with_1_plus_spotlight_snap_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_1_plus_spotlight_snap_view;;
  }

  measure: num_page_sessions_with_1_plus_story_view {
    description: "num_page_sessions_with_1_plus_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_1_plus_story_view;;
  }

  measure: num_page_sessions_with_1_plus_snap_view {
    description: "num_page_sessions_with_1_plus_snap_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_1_plus_snap_view;;
  }

  measure: num_page_sessions_with_5_plus_snap_view {
    description: "num_page_sessions_with_5_plus_snap_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_5_plus_snap_view;;
  }

  measure: num_page_sessions_with_10_plus_snap_view {
    description: "num_page_sessions_with_10_plus_snap_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_10_plus_snap_view;;
  }

  measure: num_page_sessions_with_hn_story_view {
    description: "num_page_sessions_with_hn_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_hn_story_view;;
  }

  measure: num_story_view {
    description: "num_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_story_view;;
  }

  measure: num_snap_view {
    description: "num_snap_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_snap_view;;
  }

  measure: num_hn_story_view {
    description: "num_hn_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_hn_story_view;;
  }

  measure: num_spotlight_story_view {
    description: "num_hn_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_spotlight_story_view;;
  }

  measure: num_page_sessions_with_hn_story_view_notification {
    description: "num_page_sessions_with_hn_story_view_notification"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_page_sessions_with_hn_story_view_notification;;
  }

  measure: num_hn_story_views_notification {
    description: "num_hn_story_views_notification"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_hn_story_views_notification;;
  }

  measure: num_badge_long_impression {
    description: "num_badge_long_impression"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_badge_long_impression;;
  }

  measure: num_badge_click {
    description: "num_badge_click"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_badge_click;;
  }

  measure: num_show_badge_long_impression {
    description: "num_show_badge_long_impression"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_show_badge_long_impression;;
  }

  measure: num_show_badge_click {
    description: "num_show_badge_click"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_show_badge_click;;
  }

  measure: num_hn_badge_long_impression {
    description: "num_hn_badge_long_impression"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_hn_badge_long_impression;;
  }

  measure: num_hn_badge_click {
    description: "num_hn_badge_click"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_hn_badge_click;;
  }

  measure: num_users_has_any_story_view {
    description: "num_users_has_any_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.num_users_has_any_story_view;;
  }

  measure: total_story_view_time {
    description: "num_users_has_any_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.story_view_time;;
  }

  measure: df_friends_story_view_time {
    description: "num_users_has_any_story_view"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.df_friends_story_view_time;;
  }
}
