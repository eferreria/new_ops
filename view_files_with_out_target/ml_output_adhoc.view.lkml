# most active contributor jbabra@snapchat.com
view: ml_output_adhoc {

  sql_table_name: public.output ;;

  dimension: assigned {
    type: string
    sql: ${TABLE}."assigned" ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}."event_date" ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}."language" ;;
  }

  dimension: level1 {
    type: string
    sql: ${TABLE}."level1" ;;
  }

  dimension: level2 {
    type: string
    sql: ${TABLE}."level2" ;;
  }

  dimension: ml_id {
    type: number
    primary_key: yes
    sql: ${TABLE}."ml_id" ;;
  }

  dimension_group: processed {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."processed" ;;
  }

  dimension_group: sent {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."sent" ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}."text" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }





 }
