# most active contributor jbabra@snapchat.com
view: streaks_form {
  derived_table: {
    sql: SELECT
                id
                ,name
          FROM TABLE_QUERY([sc-analytics:report_zendesk_snapstreaks], "table_id IN
                (SELECT table_id FROM [sc-analytics:report_zendesk_snapstreaks.__TABLES__]
                WHERE REGEXP_MATCH(table_id, r'^ticket_forms_[0-9]{8}')
                ORDER BY table_id
                DESC LIMIT 1)") ;;

    }

    dimension: id {
      sql: ${TABLE}.id ;;
      type:  number
      primary_key: yes
    }

    dimension: name {
      sql: ${TABLE}.name ;;
      type:  string
    }

}


view: streaks_group {
  derived_table: {
    sql: (SELECT
                id,
               name
          FROM TABLE_QUERY([sc-analytics:report_zendesk_snapstreaks], "table_id IN (SELECT table_id FROM [sc-analytics:report_zendesk_snapstreaks.__TABLES__]
          WHERE REGEXP_MATCH(table_id, r'^group_[0-9].*')
          ORDER BY table_id
          DESC LIMIT 1)")
          GROUP BY 1,2
         );;
    }

    dimension: id {
      type: number
      primary_key: yes
      sql: ${TABLE}.id ;;
    }

    dimension: name {
      type: string
      sql: ${TABLE}.name ;;
      case_sensitive: no
    }
  }
