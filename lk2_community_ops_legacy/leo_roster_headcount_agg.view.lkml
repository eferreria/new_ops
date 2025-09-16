view: leo_roster_headcount_agg {
  label: "LEO Roster Headcount Agg"
  sql_table_name: [sc-analytics:report_customer_ops.leo_roster_headcount_agg] ;;

  dimension_group: date {
    type: time
    sql: CAST(CONCAT(${TABLE}.month_number, ' 00:00:00') AS TIMESTAMP) ;;
  }

  measure: all_leo_headcount {
    type: average
    value_format: "0"
    sql: ${TABLE}.all_leo_headcount ;;
  }

  measure: FTE_headcount {
    label: "FTE Headcount"
    value_format: "0"
    type: average
    sql: ${TABLE}.fte ;;
  }

  measure: total_cw {
    label: "Total CW"
    value_format: "0"
    type: average
    sql: ${TABLE}.total_cw ;;
  }

  measure: acn {
    label: "ACN"
    value_format: "0"
    type: average
    sql: ${TABLE}.acn ;;
  }

  measure: integreon {
    type: average
    value_format: "0"
    sql: ${TABLE}.integreon ;;
  }

  measure: ZGSS {
    label: "ZGSS"
    value_format: "0"
    type: average
    sql: ${TABLE}.zgss ;;
  }

  measure: oddacious {
    type: average
    value_format: "0"
    sql: ${TABLE}.oddacious ;;
  }

  measure: elevate {
    type: average
    value_format: "0"
    sql: ${TABLE}.elevate ;;
  }


}
