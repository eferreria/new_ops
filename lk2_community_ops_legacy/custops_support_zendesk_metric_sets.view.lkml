# most active contributor jbabra@snapchat.com
view: custops_support_zendesk_metric_sets {
    derived_table: {
      sql: SELECT *
      FROM
      (SELECT * FROM TABLE_QUERY([sc-analytics:report_zendesk], "table_id IN (SELECT table_id FROM [sc-analytics:report_zendesk.__TABLES__] WHERE REGEXP_MATCH(table_id, r'^ticket_metric_sets_distinct_[0-9].*') ORDER BY table_id DESC LIMIT 1)"))
      WHERE DATE(created_at) >= '2017-01-01'
      ;;
      }

      measure: count_tickets {
        type: count
        group_label: "Count Metrics"
        drill_fields: [detail*]
      }

      dimension: id {
        type: number
        hidden:  yes
        sql: ${TABLE}.id ;;
      }


      dimension: ticket_id {
        type: number
        primary_key: yes
        hidden:  yes
        sql: ${TABLE}.ticket_id ;;
      }

      dimension_group: assignee_updated_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.assignee_updated_at,-8,"HOUR") ;;
      }

      dimension_group: requester_updated_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.requester_updated_at,-8,"HOUR") ;;
      }

      dimension_group: status_updated_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.status_updated_at,-8,"HOUR") ;;
      }

      dimension_group: initially_assigned_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.initially_assigned_at,-8,"HOUR") ;;
      }

      dimension_group: assigned_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.assigned_at,-8,"HOUR") ;;
      }

      dimension_group: solved_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.solved_at,-8,"HOUR") ;;
      }

      dimension_group: latest_comment_added_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.latest_comment_added_at,-8,"HOUR") ;;
      }

      dimension_group: created_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.created_at,-8,"HOUR") ;;
      }

      dimension_group: updated_at {
        type: time
        hidden:  yes
        sql: DATE_ADD(${TABLE}.updated_at,-8,"HOUR") ;;
      }

      dimension: count_ticket_replies {
        label: "Replies"
        type: number
        group_label: "Raw Metrics"
        sql: ${TABLE}.replies ;;
      }


      dimension: full_resolution_time_in_minutes_calendar {
        group_label: "Raw TAT Metrics (Calendar)"
        label: "Full Resolution Time - Calendar (minutes)"
        type: number
        sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
      }

      dimension: first_resolution_time_in_minutes_calendar {
        group_label: "Raw TAT Metrics (Calendar)"
        label: "First Resolution Time - Calendar (minutes)"
        type: number
        sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
      }


      dimension: reply_time_in_minutes_calendar {
        group_label: "Raw TAT Metrics (Calendar)"
        label: "First Reply Time - Calendar (minutes)"
        type: number
        sql:  ${TABLE}.reply_time_in_minutes_calendar;;
        drill_fields: [detail*]
      }

      dimension: agent_wait_time_in_minutes_calendar {
        group_label: "Raw TAT Metrics (Calendar)"
        label: "Agent Wait Time - Calendar (minutes)"
        type: number
        hidden:  yes
        sql:  ${TABLE}.agent_wait_time_in_minutes_calendar;;
        drill_fields: [detail*]
      }

      dimension: requester_wait_time_in_minutes_calendar {
        group_label: "Raw TAT Metrics (Calendar)"
        label: "Requestor Wait Time - Calendar (minutes)"
        type: number
        hidden:  yes
        sql:  ${TABLE}.requester_wait_time_in_minutes_calendar;;
        drill_fields: [detail*]
      }

      dimension: full_resolution_time_in_minutes_business {
        group_label: "Raw TAT Metrics (Business)"
        label: "Full Resolution Time - Business (minutes)"
        type: number
        sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
      }

      dimension: first_resolution_time_in_minutes_business {
        group_label: "Raw TAT Metrics (Business)"
        label: "First Resolution Time - Business (minutes)"
        type: number
        sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
      }

      dimension: reply_time_in_minutes_business {
        group_label: "Raw TAT Metrics (Business)"
        label: "First Reply Time - Business (minutes)"
        type: number
        sql:  ${TABLE}.reply_time_in_minutes_business;;
        drill_fields: [detail*]
      }


      measure: reopens_average {
        type: average
        value_format: "0.00"
        group_label: "Average Metrics"
        sql: ${TABLE}.reopens ;;
        drill_fields: [detail*]
      }


      measure: replies_average {
        type: average
        value_format: "0.00"
        group_label: "Average Metrics"
        sql: ${TABLE}.replies ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_calendar_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_business_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_calendar_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.reply_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_business_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.reply_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_calendar_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_business_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_calendar_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_business_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_calendar_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_business_average {
        type: average
        hidden:  yes
        group_label: "Average Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }




      measure: first_resolution_time_in_minutes_calendar_median {
        type: median
        hidden:  yes
        group_label: "Median Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_business_median {
        type: median
        hidden:  yes
        group_label: "Median Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_calendar_median {
        type: median

        group_label: "Median Metrics"
        sql: ${TABLE}.reply_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_business_median {
        type: median
        group_label: "Median Metrics"
        sql: ${TABLE}.reply_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_calendar_median {
        type: median
        group_label: "Median Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_business_median {
        type: median
        group_label: "Median Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_calendar_median {
        type: median
        hidden:  yes
        group_label: "Median Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_business_median {
        type: median
        hidden:  yes
        group_label: "Median Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_calendar_median {
        type: median
        hidden:  yes
        group_label: "Median Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_business_median {
        type: median
        hidden:  yes
        group_label: "Median Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }


      measure: first_resolution_time_in_minutes_calendar_p95 {
        type: percentile
        percentile: 95
        hidden:  yes
        group_label: "P95 Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_business_p95 {
        type: percentile
        percentile: 95
        hidden:  yes
        group_label: "P95 Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_calendars_p95 {
        type: percentile
        percentile: 95
        group_label: "P95 Metrics"
        sql: ${TABLE}.reply_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_business_p95 {
        type: percentile
        percentile: 95
        group_label: "P95 Metrics"
        sql: ${TABLE}.reply_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_calendar_p95 {
        type: percentile
        percentile: 95
        group_label: "P95 Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_business_p95 {
        type: percentile
        percentile: 95
        group_label: "P95 Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_calendar_p95 {
        type: percentile
        percentile: 95
        hidden:  yes
        group_label: "P95 Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_business_p95 {
        type: percentile
        percentile: 95
        hidden:  yes
        group_label: "P95 Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_calendar_p95 {
        type: percentile
        percentile: 95
        hidden:  yes
        group_label: "P95 Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_business_p95 {
        type: percentile
        percentile: 95
        hidden:  yes
        group_label: "P95 Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_calendar_p90 {
        type: percentile
        percentile: 90
        hidden:  yes
        group_label: "P90 Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_business_p90 {
        type: percentile
        percentile: 90
        hidden:  yes
        group_label: "P90 Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_calendars_p90 {
        type: percentile
        percentile: 90
        group_label: "P90 Metrics"
        sql: ${TABLE}.reply_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_business_p90 {
        type: percentile
        percentile: 90
        group_label: "P90 Metrics"
        sql: ${TABLE}.reply_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_calendar_p90 {
        type: percentile
        percentile: 90
        group_label: "P90 Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_business_p90 {
        type: percentile
        percentile: 90
        group_label: "P90 Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_calendar_p90 {
        type: percentile
        percentile: 90
        hidden:  yes
        group_label: "P90 Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_business_p90 {
        type: percentile
        percentile: 90
        hidden:  yes
        group_label: "P90 Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_calendar_p90 {
        type: percentile
        percentile: 90
        hidden:  yes
        group_label: "P90 Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_business_p90 {
        type: percentile
        percentile: 90
        hidden:  yes
        group_label: "P90 Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }




      dimension: reopens {
        type: number
        group_label: "Raw Metrics"
        sql: ${TABLE}.reopens;;
        drill_fields: [detail*]
      }

      dimension: is_reopened {
        type: yesno
        hidden:  yes
        sql: CASE WHEN ${TABLE}.reopens >= TRUE THEN 1 ELSE FALSE END ;;
        drill_fields: [detail*]
      }

      measure: replies_sum {
        type: sum
        group_label: "Sum Metrics"
        sql: ${TABLE}.replies ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_calendar_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: first_resolution_time_in_minutes_business_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.first_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_calendar_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.reply_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: reply_time_in_minutes_business_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.reply_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_calendar_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: full_resolution_time_in_minutes_business_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.full_resolution_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_calendar_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: agent_wait_time_in_minutes_business_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.agent_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_calendar_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_calendar ;;
        drill_fields: [detail*]
      }

      measure: requester_wait_time_in_minutes_business_sum {
        type: sum
        hidden:  yes
        group_label: "Sum Metrics"
        sql: ${TABLE}.requester_wait_time_in_minutes_business ;;
        drill_fields: [detail*]
      }

      dimension: row_order {
        type: number
        hidden: yes
        sql: ${TABLE}.row_order ;;
      }

      measure: distinct_organizations {
        label: "Count Organizations"
        type: count_distinct
        group_label: "Count Metrics"
        sql: ${custops_support_zendesk_ticket.ticket_organization_id} ;;
      }



      set: detail {
        fields: [
          ticket_id,
      custops_support_zendesk_ticket.ticket_url,
      custops_support_zendesk_ticket.created_time,
      custops_support_zendesk_ticket.ticket_subject,
      custops_support_zendesk_ticket.ticket_description,
      custops_support_zendesk_ticket.ticket_status,
      custops_support_zendesk_ticket.category,
      custops_support_zendesk_ticket.subcategory,
      custops_support_zendesk_ticket.zendesk_group.name,
      custops_support_zendesk_ticket.group_name,
      custops_support_zendesk_ticket.device_os_version,
      custops_support_zendesk_ticket.device_marketing_name,
      custops_support_zendesk_ticket.device_model,
      custops_support_zendesk_ticket.snapchat_version_primary,
      custops_support_zendesk_ticket.snapchat_version_secondary,
      custops_support_zendesk_ticket.country,
      custops_support_zendesk_ticket.ticket_tags


        ]
      }
    }
