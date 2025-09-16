include: "//hub_looker_production/bizops/zendesk_ticket.view"
view: zendesk_ticket_tag {
  derived_table: {
    sql: SELECT id, null as type, null as explicit_tag, tag as tag
         FROM [sc-analytics:report_zendesk.ticket_distinct]
    /*
SELECT ticket_id                            AS id
      ,type                                 AS type
      ,GROUP_CONCAT(search_tag,", ")        AS explicit_tag
      ,GROUP_CONCAT(tag,", ")               AS tag
FROM(
    SELECT a.ticket_id                 AS ticket_id
          ,CONCAT("{",a.tag,"}")       AS search_tag
          ,a.tag                       AS tag
          ,'current'                   AS type FROM
    (
      SELECT ticket_id, REGEXP_EXTRACT(spl,r'u\'(.*)\'') tag
      FROM FLATTEN(
      SELECT ticket_id, SPLIT(new_value,',') spl, REGEXP_EXTRACT(new_value,r'\[u\'(.*)\'\]') tag
      FROM ${zendesk_ticket_history.SQL_TABLE_NAME}
      WHERE property = 'added_tags'
      AND REGEXP_EXTRACT(new_value,r'\[u\'(.*)\'\]') IS NOT NULL
      ,spl)
      GROUP BY 1,2
    ) a
    LEFT JOIN EACH
    ( SELECT ticket_id, REGEXP_EXTRACT(spl,r'u\'(.*)\'') tag
      FROM FLATTEN(
      SELECT ticket_id, SPLIT(new_value,',') spl, REGEXP_EXTRACT(new_value,r'\[u\'(.*)\'\]') tag
      FROM ${zendesk_ticket_history.SQL_TABLE_NAME}
      WHERE property = 'removed_tags'
      AND REGEXP_EXTRACT(new_value,r'\[u\'(.*)\'\]') IS NOT NULL
      ,spl)
      GROUP BY 1,2
    ) b ON a.ticket_id = b.ticket_id AND a.tag = b.tag
    WHERE b.ticket_id IS NULL
    ),
    ( SELECT ticket_id, CONCAT("{",REGEXP_EXTRACT(spl,r'u\'(.*)\''),"}") AS search_tag, REGEXP_EXTRACT(spl,r'u\'(.*)\'') AS tag, 'removed' AS type
      FROM FLATTEN(
      SELECT ticket_id, SPLIT(new_value,',') spl, REGEXP_EXTRACT(new_value,r'\[u\'(.*)\'\]') tag
      FROM ${zendesk_ticket_history.SQL_TABLE_NAME}
      WHERE property = 'removed_tags'
      AND REGEXP_EXTRACT(new_value,r'\[u\'(.*)\'\]') IS NOT NULL
      ,spl)
      GROUP BY 1,2,3
    )
    GROUP BY 1,2
    */
 ;;

    # sql_trigger_value: SELECT HOUR(NOW()) ;;
    ## SELECT FLOOR(((NOW() / 1000000) - 60*60*13)/(60*60*24)) ;; ## Updates at 1PM GMT

    }

    dimension: id {
      type: number
      label: "Ticket ID (DEPRECATED DON'T USE)"
      description: "Ticket ID"
      primary_key: yes
      sql: ${TABLE}.id ;;
    }

    dimension:explicit_tag {
      type:  string
      label: "Explicit Tag (DEPRECATED DON'T USE)"
      description: "DEPRECATED DON'T USE"
      sql:  ${TABLE}.explicit_tag ;;
    }

    dimension: type {
      type: string
      description: "Set type to 'Current' to find tags currently applied to tickets, set type to 'Removed' to find tags that have been removed."
      label: "Type (DEPRECATED DON'T USE)"
      sql: ${TABLE}.type ;;
    }

    dimension: tag {
      type: string
      label: "Tag (DEPRECATED DON'T USE)"
      description: "Fitler by using 'contains or does not contain' only. For collisions, use 'Explicit Tag'."
      sql: ${TABLE}.tag ;;
    }

    set: detail {
      fields: [zendesk_ticket.detail*]

    }
  }
