view: custops_ghost_ids {
  derived_table: {
    interval_trigger: "24 hours"
    sql:

    SELECT
      te.ticket_id AS ticket_id,
      uid.userId AS userID,
      uid.ghostId AS ghostID
    FROM (
      SELECT
        ticket_id,
        LOWER(REGEXP_REPLACE(JSON_EXTRACT(child_json, "$.custom_ticket_fields.24281229"), r'"', '')) AS extract_un
      FROM [sc-analytics:report_zendesk.ticket_events]
      WHERE
        _PARTITIONTIME >= TIMESTAMP("2023-01-01")
        AND child_via = "Web service"
        AND child_event_type = "Create"
        AND child_json CONTAINS '24281229'
    ) te
    LEFT JOIN (
      SELECT
        userId,
        ghostId,
        LOWER(mutableUsername) AS normalized_mutableUsername
      FROM TABLE_DATE_RANGE(
        [snap-atlas-prod:user_identity.user_id_mapping_unfiltered_],
        TIMESTAMP(DATE_ADD(CURRENT_DATE(), -1, "DAY")),
        TIMESTAMP(DATE_ADD(CURRENT_DATE(), -1, "DAY"))
      )
    ) uid
    ON te.extract_un = uid.normalized_mutableUsername


        ;;

    #persist_for: "24 hours"
  }

  dimension: ticket_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.ticket_id ;;
    label: "Ticket ID"
  }

  dimension: ghost_id {
    type: string
    sql: ${TABLE}.ghostId ;;
    label: "Ghost ID"
    description: "GhostID that is associated to the username submitted on each ticket"
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.userId ;;
    label: "User ID"
    description: "UserID that is associated to the username submitted on each ticket"
  }


}
