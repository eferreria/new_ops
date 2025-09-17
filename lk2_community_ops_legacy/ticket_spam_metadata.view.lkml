view: ticket_spam_metadata {

  required_access_grants: [spam_access]

  derived_table: {
    sql:
        SELECT
        ticket_id,
        TRUE as signal

        FROM [sc-analytics:report_zendesk.ticket_events]

        WHERE 1=1
               AND _PARTITIONTIME >= CAST("2023-01-01" AS TIMESTAMP)
               AND (child_via = 'Web service' AND child_event_type = 'Create'
               AND (child_json LIKE '%24281229%' OR child_json LIKE '%24335325%'))
               AND (  LOWER(JSON_EXTRACT_SCALAR(child_json, '$.custom_ticket_fields.24281229')) LIKE '%none%' OR
                      LOWER(JSON_EXTRACT_SCALAR(child_json, '$.custom_ticket_fields.24281229')) LIKE '%nothing%' OR
                      LOWER(JSON_EXTRACT_SCALAR(child_json, '$.custom_ticket_fields.24335325')) LIKE '%a7md%' OR
                      LOWER(JSON_EXTRACT_SCALAR(child_json, '$.custom_ticket_fields.24335325')) LIKE '%44414%' OR
                      LOWER(JSON_EXTRACT_SCALAR(child_json, '$.custom_ticket_fields.24335325')) LIKE '%blaaddee%'
                      )

        GROUP BY 1,2

      ;;
    # persist_for: "24 hours"

  }

  dimension: ticket_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.ticket_id ;;
    label: "Ticket ID"
  }

  dimension: signal {
    hidden: no
    type: yesno
    sql: CASE WHEN ${TABLE}.signal = TRUE THEN TRUE ELSE FALSE END ;;
    label: "Signal"
    description: "Use this field to filter out tickets that are likely to be spam; this filter includes tickets with the 'none'/'nothing' username variants, or coming from 3 main spam accounts"
  }


}
