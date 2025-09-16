view: leo_headcount_agg {
  sql_table_name: [platform-integrity:ops.leo_head_count_agg] ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  dimension: report_month {
    type: string
    sql: ${TABLE}.month_number ;;
  }

  dimension: all_leo_headcount {
    type: number
    sql: ${TABLE}.all_leo_headcount ;;
  }

  dimension: fte_headcount {
    type: number
    sql: ${TABLE}.fte_headcount ;;
  }
}
