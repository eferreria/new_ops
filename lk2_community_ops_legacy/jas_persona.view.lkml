# most active contributor jbabra@snapchat.com
view: jas_persona {

derived_table: {
  sql: (SELECT
        *
            FROM TABLE_QUERY([sc-analytics:report_user],
                "table_id IN (SELECT table_id FROM [sc-analytics:report_user.__TABLES__]
                WHERE REGEXP_MATCH(table_id, r'^user_persona_v1_[0-9]{8}$')
                ORDER BY table_id
                DESC LIMIT 1)")) ;;

}


dimension: ghost_user_id {
  type: string

}


dimension: type {
  type: string
}

}
