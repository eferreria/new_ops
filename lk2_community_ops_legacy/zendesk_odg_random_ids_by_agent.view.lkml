# most active contributor gcheung@snapchat.com
view: zendesk_odg_random_ids_by_agent {
  derived_table: {
    sql: SELECT * FROM
      (SELECT STRING(zendesk_ticket_id) AS id
            ,approval_status
            ,zendesk_agent_email AS email
            ,system
            FROM(
      SELECT
        zendesk_ticket.id  AS zendesk_ticket_id,
        'NA' AS approval_status,
        zendesk_agent.email  AS zendesk_agent_email,
        'ZD' AS system,
        ROW_NUMBER() OVER (PARTITION BY zendesk_agent.email ORDER BY zendesk_ticket.rand)  AS position
      FROM (SELECT *, RAND() AS rand FROM (TABLE_DATE_RANGE([sc-analytics:report_zendesk.ticket_],TIMESTAMP(DATE_ADD(TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00')), -7, 'DAY')),TIMESTAMP(DATE_ADD(DATE_ADD(DATE_ADD(TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00')), -7, 'DAY'), 7, 'DAY'),-1, 'SECOND')))) )
           AS zendesk_ticket
      LEFT JOIN ${zendesk_agent.SQL_TABLE_NAME} AS zendesk_agent ON zendesk_ticket.assignee_id  = zendesk_agent.id
      LEFT JOIN ${zendesk_ticket_tag.SQL_TABLE_NAME} AS zendesk_ticket_tag ON zendesk_ticket.id  = zendesk_ticket_tag.id

      WHERE (zendesk_ticket.status = 'closed' OR zendesk_ticket.status = 'solved') AND (zendesk_agent.email IS NOT NULL) AND (zendesk_ticket_tag.type = 'current') AND (NOT  zendesk_ticket_tag.tag  CONTAINS '{closed_by_merge}' OR zendesk_ticket_tag.tag IS NULL)
      )
      WHERE position <= 10),
      (SELECT
              ID
              ,approval_status
              ,email
              ,'ODG' AS system
              FROM(
      SELECT report_ondemand_geofilter_orders_id AS ID,
             report_ondemand_geofilter_orders_approval_time,
             report_ondemand_geofilter_orders_start_time,
             report_ondemand_geofilter_orders_purpose,
             report_ondemand_geofilter_orders_approval_status AS approval_status,
             report_ondemand_geofilter_orders_approver_email AS email,
             tot AS total_orders,
             ROW_NUMBER() OVER (PARTITION BY report_ondemand_geofilter_orders_approver_email)
             report_ondemand_geofilter_orders_net_booking
      FROM(
          SELECT
            report_ondemand_geofilter_orders.id  AS report_ondemand_geofilter_orders_id,
            SUBSTR(STRING(report_ondemand_geofilter_orders.approval_timestamp ),1,19) AS report_ondemand_geofilter_orders_approval_time,
            SUBSTR(STRING(report_ondemand_geofilter_orders.start_time ),1,19) AS report_ondemand_geofilter_orders_start_time,
            report_ondemand_geofilter_orders.usage_type  AS report_ondemand_geofilter_orders_purpose,
            report_ondemand_geofilter_orders.approval_status  AS report_ondemand_geofilter_orders_approval_status,
            report_ondemand_geofilter_orders.approver_email  AS report_ondemand_geofilter_orders_approver_email
            ,RAND() AS rnd
            ,ROW_NUMBER() OVER (PARTITION BY report_ondemand_geofilter_orders.approver_email, report_ondemand_geofilter_orders_approval_status ORDER BY rnd) AS pos
            ,COUNT(report_ondemand_geofilter_orders_id) OVER (PARTITION BY report_ondemand_geofilter_orders.approver_email) AS tot
            ,COALESCE(CAST(SUM(IF(report_ondemand_geofilter_orders.approval_status = 'ACCEPTED', COALESCE(report_ondemand_geofilter_orders.offer_amount,0), 0) ) AS FLOAT), 0) AS report_ondemand_geofilter_orders_net_booking
          FROM ${report_ondemand_geofilter_orders.SQL_TABLE_NAME} AS report_ondemand_geofilter_orders,
          WHERE (report_ondemand_geofilter_orders.approval_status = 'ACCEPTED' OR report_ondemand_geofilter_orders.approval_status = 'REJECTED') AND ((((report_ondemand_geofilter_orders.approval_timestamp ) >= ((DATE_ADD(TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00')), -7, 'DAY'))) AND (report_ondemand_geofilter_orders.approval_timestamp ) < ((DATE_ADD(DATE_ADD(TIMESTAMP(CONCAT(CURRENT_DATE(), ' 00:00:00')), -7, 'DAY'), 7, 'DAY'))))))
          GROUP BY 1,2,3,4,5,6,7,report_ondemand_geofilter_orders.approver_email
          )
      WHERE --pos / tot <= .1
            pos <= 10
            ))
       ;;

      persist_for: "1 hour"
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: id {
      type: string
      can_filter: no
      sql: ${TABLE}.ID ;;
    }

    dimension: approval_status {
      type: string
      can_filter: no
      alpha_sort: yes
      sql: ${TABLE}.approval_status ;;
    }

    dimension: email {
      type: string
      can_filter: yes
      alpha_sort: yes
      sql: ${TABLE}.email ;;
    }

    dimension: system {
      type: string
      can_filter: no
      alpha_sort: yes
      sql: ${TABLE}.system
        ;;
    }

    set: detail {
      fields: [id, approval_status, email, system]
    }
  }
