# most active contributor jbabra@snapchat.com
view: ml_batches {
  sql_table_name: public.batches ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension_group: deleted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."deleted_date" ;;
  }

  dimension: input_data_count {
    type: number
    sql: ${TABLE}."input_data_count" ;;
  }

  dimension_group: processed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."processed_date" ;;
  }

  dimension_group: sent_to_process {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."sent_to_process_date" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
