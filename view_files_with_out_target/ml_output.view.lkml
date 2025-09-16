# most active contributor jbabra@snapchat.com
view: ml_output {
  sql_table_name: public.output ;;

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
    #sql: to_timestamp(${TABLE}."processed", 'YYYY MM DD HH24 SS MS') ;; to convert date to timestamp postgre
    sql: ${TABLE}."processed";;
  }

  dimension_group: sent {
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
    sql: ${TABLE}."sent"  ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}."text" ;;
  }

  dimension: ticket_id {
    type: number
    primary_key: yes
    sql: ${TABLE}."ticket_id" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }


  }
