# most active contributor jbabra@snapchat.com
view: ml_header {
  sql_table_name: public.header ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension: parsed_value {
    type: string
    sql: ${TABLE}."parsed_value" ;;
  }

  dimension: source_id {
    type: number
    sql: ${TABLE}."source_id" ;;
  }

  dimension: tag_name {
    type: string
    sql: ${TABLE}."tag_name" ;;
  }

  measure: count {
    type: count
    drill_fields: [id, tag_name]
  }
}
