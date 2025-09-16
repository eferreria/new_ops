# most active contributor jbabra@snapchat.com
view: ml_identity_ops {
  sql_table_name: public.ml_identity_ops ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }

  dimension: confidence {
    type: number
    sql: ${TABLE}."confidence" ;;
  }

  dimension: source_id {
    type: number
    sql: ${TABLE}."source_id" ;;
  }

  dimension: tag_id {
    type: number
    sql: ${TABLE}."tag_id" ;;
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
