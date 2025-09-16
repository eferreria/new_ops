# most active contributor jbabra@snapchat.com
view: ml_input_data {
  sql_table_name: public.input_data ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: batch_id {
    type: number
    sql: ${TABLE}."batch_id" ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}."text" ;;
  }

  dimension: ticket_id {
    type: number
    sql: ${TABLE}."ticket_id" ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
