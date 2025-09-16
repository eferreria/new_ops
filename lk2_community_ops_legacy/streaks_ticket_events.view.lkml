# most active contributor jbabra@snapchat.com
view: streaks_ticket_events {

  derived_table: {
    sql: SELECT * FROM [sc-analytics:report_zendesk_snapstreaks.ticket_events]
           WHERE {% condition partition_filter %} _PARTITIONTIME {% endcondition %}
          ;;
  }

###################
##   FILTERS     ##
###################
  filter: partition_filter {
    label: "Event Date Filter"
    type: date
    default_value: "7 days ago for 7 days"
  }

###################
##   DIMENSIONS  ##
###################
  dimension: id {
    hidden: yes
  }

  # dimension: agent_email {
  #   sql: ${zendesk_agent.email} ;;
  # }

  dimension: updater_id {
    hidden: yes
  }

  dimension: event_type {
    type: string
  }

  dimension: via {
    type: string
  }

  dimension_group: updated_at  {
    type: time
    description: "UTC"
  }

  dimension_group: updated_at_pst  {
    type: time
    description: "PST (-7)"
    sql: DATE_ADD(${TABLE}.updated_at, -7, "HOUR" ) ;;
  }

  dimension: _updated_at  {
    type: string
    hidden: yes
  }

  dimension: created_at {
    hidden: yes
  }

  dimension: ticket_id {
    type: number
  }

  dimension: url {
    type: string
    label: "Ticket URL"
    sql: CONCAT('https://snapstreak.zendesk.com/agent/tickets/',STRING(${TABLE}.ticket_id)) ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: child_id {
    primary_key: yes
  }

  dimension: child_event_type {
    type: string
  }

  dimension: child_via_reference_id {
    hidden: yes
  }

  dimension: child_via {
    type: string
  }

  dimension: child_json {
    type: string
  }

  dimension: added_tags {
    description: "List of tags that were added"
    type: string
    sql: JSON_EXTRACT(${child_json},'$.added_tags') ;;
  }

  dimension: removed_tags {
    description: "List of tags that were removed"
    type: string
    sql: JSON_EXTRACT(${child_json},'$.removed_tags') ;;
  }

  dimension: action_type {
    type: string
    case: {
      when: {
        label: "SOLVED"
        sql: ${child_json} LIKE '%"status": "solved"%';;
      }
      when: {
        label: "PENDING"
        sql: ${child_json} LIKE '%"status": "pending"%';;
      }
      when: {
        label: "OPENED"
        sql: ${child_json} LIKE '%"status": "open"%';;
      }
      when: {
        label: "HOLD"
        sql: ${child_json} LIKE '%"status": "hold"%';;
      }
      when: {
        label: "CLOSED"
        sql: ${child_json} LIKE '%"status": "closed"%';;
      }
      when: {
        label: "DELETED"
        sql: ${child_json} LIKE '%"status": "deleted"%';;
      }
      when: {
        label: "EXTERNAL_COMMENT"
        sql: ${child_json} LIKE '%"comment_public": true%' ;;
      }
      when: {
        label: "INTERNAL_COMMENT"
        sql: ${child_json} LIKE '%"comment_public": false%' ;;
      }
      when: {
        label: "ROUTE"
        sql: ${child_json} LIKE '%"group_id": %' ;;
      }
    }
  }


###################
##   MEASURES    ##
###################

  measure: count {
    type: count
    drill_fields: [drill_fields*]
  }

  measure: count_updates {
    type: count_distinct
    sql: ${id} ;;
    approximate_threshold: 10000
    drill_fields: [drill_fields*]
  }

  measure: count_solved {
    description: "Count of how many times a ticket was put in solved"
    type: count
    filters: {
      field: action_type
      value: "SOLVED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_pending {
    description: "Count of how many times a ticket was put in pending"
    type: count
    filters: {
      field: action_type
      value: "PENDING"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_hold {
    description: "Count of how many times a ticket was put on hold"
    type: count
    filters: {
      field: action_type
      value: "HOLD"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_closed {
    description: "Count of how many times a ticket was closed"
    type: count
    filters: {
      field: action_type
      value: "CLOSED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_ticket {
    type: count_distinct
    sql: ${ticket_id} ;;
    approximate_threshold: 1000000
    drill_fields: [drill_fields*]
  }

  measure: count_opened {
    description: "Count of how many times a ticket was opened"
    type: count
    filters: {
      field: action_type
      value: "OPENED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_status_change {
    description: "Count of how many times status changed on a ticket"
    type: count
    filters: {
      field: action_type
      value: "OPENED,SOLVED,CLOSED,HOLD,PENDING,DELETED"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_external_comment {
    description: "Count of agent external comments"
    type: count
    filters: {
      field: action_type
      value: "EXTERNAL_COMMENT"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_internal_comment {
    description: "Count of agent internal comments"
    type: count
    filters: {
      field: action_type
      value: "INTERNAL_COMMENT"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_tickets_internal_comment {
    description: "Count of unique tickets with an agent internal comment"
    type: number
    sql: COUNT(DISTINCT IF(${action_type}="INTERNAL_COMMENT",${ticket_id},NULL)) ;;
    drill_fields: [drill_fields*]
  }

  measure: count_tickets_external_comment {
    description: "Count of unique tickets with an agent external comment"
    type: number
    sql: COUNT(DISTINCT IF(${action_type}="EXTERNAL_COMMENT",${ticket_id},NULL)) ;;
    drill_fields: [drill_fields*]
  }

  measure: count_comment {
    description: "Count of any agent comments (external & internal)"
    type: count
    filters: {
      field: action_type
      value: "INTERNAL_COMMENT,EXTERNAL_COMMENT"
    }
    drill_fields: [drill_fields*]
  }

  measure: count_route {
    description: "Count of how many times a ticket changed groups"
    type: count
    filters: {
      field: action_type
      value: "ROUTE"
    }
    drill_fields: [drill_fields*]
  }

  set: drill_fields {
    fields: [
      url,
      ticket_id,
      event_type,
      child_event_type,
      action_type,
      updated_at_time,
      child_json
    ]
  }



}
