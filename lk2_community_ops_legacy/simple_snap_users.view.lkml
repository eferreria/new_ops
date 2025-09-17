view: simple_snap_users {

  derived_table: {
    # interval_trigger: "24 hours"
    sql:

    SELECT
      ghost_user_id,
      MAX(is_simple_snapchat) as is_simple_snapchat
    FROM TABLE_DATE_RANGE(
      [sc-analytics:report_search.user_cohorts_],
      TIMESTAMP(DATE_ADD(CURRENT_DATE(), -5, "DAY")),
      TIMESTAMP(DATE_ADD(CURRENT_DATE(), -1, "DAY")))
    WHERE
      is_dau = 1
      AND is_simple_snapchat = TRUE
    GROUP BY ghost_user_id
        ;;

    # persist_for: "24 hours"
  }

  dimension: ghost_user_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.ghost_user_id ;;
    label: "Ghost ID"
    hidden: yes
  }

  dimension: is_simple_snap {
    label: "Simple Snap User"
    type: yesno
    sql: CASE WHEN ${TABLE}.is_simple_snapchat = TRUE THEN TRUE ELSE FALSE END ;;
  }

  # dimension: ghost_id {
  #   type: string
  #   sql: ${TABLE}.ghostId ;;
  # }

}
