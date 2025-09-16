# most active contributor jbabra@snapchat.com
view: streaks_ticket {

  derived_table: {
    sql:
          SELECT
          id,
          subject,
          description,
          status,
          recipient,
          requester_id,
          submitter_id,
          --assignee_id,
          group_id,
          via_channel,
          --category,
        --  subcategory,
          ticket_form_id,
          created_at,
          updated_at,
          total_time_spent,
          time_spent_last_update,
          tag,
          created_str,
          device_os,
          device_os_version,
          snapchat_version_primary,
          snapchat_version_secondary
          FROM

       [sc-analytics:report_zendesk_snapstreaks.ticket_distinct]
      ,
       [sc-analytics:report_zendesk.ticket_distinct]
     WHERE ticket_form_id IN (149423,360002019217 )
      ;;

  }

  dimension: id {
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
    label: "Ticket ID"
  }

  dimension: url {
    type: string
    label: "Ticket URL"
    sql: CONCAT('https://snapstreak.zendesk.com/agent/tickets/',STRING(${TABLE}.id)) ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  dimension: requester_url {
    type: string
    label: "Requester's Tickets URL"
    sql: CONCAT('https://snapstreak.zendesk.com/agent/users/',STRING(${requester_id}),'/requested_tickets') ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
    group_label: "Ticket Fields"
  }

  dimension: group_individual_streak {
    label: "Individual/Group Streak"
    group_label: "Ticket Fields"
    sql: CASE
          WHEN ${tag} LIKE '%snapstreak_restoration_group%' THEN "Group"
          ELSE "Individual"
        END;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
    case_sensitive: no
    group_label: "Ticket Fields"
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
    html: {{ rendered_value }};;
    case_sensitive: no
    group_label: "Ticket Fields"
  }

  dimension: description_length {
    type: number
    sql: LENGTH(${description}) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    case_sensitive: no
    group_label: "Ticket Fields"
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
    case_sensitive: no
    group_label: "Ticket Fields"
  }

  dimension: requester_id {
    type: number
    sql: ${TABLE}.requester_id ;;
    group_label: "Ticket Fields"
  }

  dimension: assignee_id {
    type: number
    sql: ${TABLE}.assignee_id ;;
    group_label: "Ticket Fields"
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.group_id ;;
    group_label: "Ticket Fields"
  }

  dimension: group_name {
    sql: CASE WHEN ${group_id} = 360008049797 THEN "General Support L1"
              ELSE "Other" END ;;
              type: string
  }

  dimension: ticket_form_id {
    type: number
    sql: ${TABLE}.ticket_form_id ;;
    group_label: "Ticket Fields"
  }

  dimension: form_name {
    type: string
    sql: CASE WHEN ${ticket_form_id} IN (149423,360002019217) THEN "Snapstreak Restore"
            ELSE "Other"
            END ;;
  }

  # dimension: form_name {
  #   sql: ${streaks_form.name} ;;
  #   group_label: "Ticket Fields"
  # }

  dimension_group: created {
    type: time
    label: "Created PST"
    sql: DATE_ADD(${TABLE}.created_at, -7, "HOUR") ;;
    convert_tz: no
  }

  dimension_group: created_utc {
    type: time
    label: "Created UTC"
    sql: ${TABLE}.created_at ;;
    convert_tz: no
  }

  dimension: week_number_sunday_start {
    type: number
    description: "Weeks begin on Sunday, so if January 1 is on a day other than Sunday, week 1 has fewer than 7 days and the first Sunday of the year is the first day of week 2."
    sql:  WEEK(TIMESTAMP(DATE_ADD(${TABLE}.created_at, -7, "HOUR") )) ;;
  }

  dimension_group: updated {
    type: time
    label: "Updated PST"
    sql: DATE_ADD(${TABLE}.updated_at, -7, "HOUR") ;;
  }

  dimension_group: updated_utc {
    type: time
    label: "Updated UTC"
    sql: ${TABLE}.updated_at ;;
  }

  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
    case_sensitive: no
    group_label: "Ticket Fields"
  }

  dimension: via_channel {
    label: "Channel"
    description: "The channel that the ticket came from. Values can be API, Email, Chat"
    type: string
    sql: ${TABLE}.via_channel ;;
    group_label: "Ticket Fields"
  }

  dimension: device_os {
    type: string
    sql: ${TABLE}.device_os ;;
    label: "Device OS"
    description: "ios vs android"
  }

  dimension: device_os_version {
    type: string
    sql: ${TABLE}.device_os_version ;;
    label: "Device OS Version"
    description: "android10 , ios 15.1"
  }

  dimension: snapchat_version_primary {
    type: string
    sql: ${TABLE}.snapchat_version_primary ;;
  }

  dimension: snapchat_version_primary_numeric {
    type: number
    sql: ${snapchat_version_primary}  ;;
  }

  dimension: in_app_restore_eligible {
    type: string
    label: "In App Restore Eligble"
    sql: CASE
              WHEN ${snapchat_version_primary} LIKE '99.9' OR ${snapchat_version_primary} is NULL OR ${snapchat_version_primary} LIKE '0.0'  THEN "Undefined"
              WHEN ${snapchat_version_primary} IN ("12.28","12.29") OR ${snapchat_version_primary} LIKE '12.3%' OR ${snapchat_version_primary} LIKE '12.4%' OR ${snapchat_version_primary} LIKE '12.5%' OR ${snapchat_version_primary} LIKE '12.6%' THEN "Eligible"
              else "Not Eligible" END ;;
  }

  dimension: snapchat_version_secondary {
    type: string
    sql: ${TABLE}.snapchat_version_secondary ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    description: "Country extracted from tags"
    sql: CASE
        WHEN ${tag} LIKE '%l-country-%' THEN UPPER( RIGHT( REGEXP_EXTRACT(${tag}, r'(l-country-+[a-z]{2})') , 2) )

        ELSE null
          END ;;
  }

  dimension: support_site_version {
    type: string
    case: {
      when: {
        sql: ${tag} LIKE '%site-origin-zd-guide%' ;;
        label: "help-dot"
      }
      else: "support-dot"
    }
    description: "Which verison of Support site was the ticket sent from: support-dot vs help-dot"
  }

  # MEASURES

  measure: count_tickets {
    type: count
    approximate_threshold: 100000000
    drill_fields: [detail*]
    group_label: "Count"
    group_item_label: "Tickets"
  }

  measure: count_requester {
    type: count_distinct
    approximate_threshold: 100000
    sql: ${TABLE}.requester_id;;
    drill_fields: [detail*]
    group_label: "Count"
    group_item_label: "Requester"
  }

  measure: count_tickets_last_7d {
    type: count
    group_label: "Count"
    group_item_label: "Tickets last 7D"
    approximate_threshold: 100000
    filters: {
      field: created_date
      value: "7 days ago for 7 days"
    }
    drill_fields: [detail*]
  }

  # STREAK ACTIONS RAW

  measure: low_value {
    type: count
    group_label: "Streak Actions"
    label: "Low Value"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail-low-value%"
    }
    drill_fields: [detail*]
  }

  measure: no_info_match {
    type: count
    group_label: "Streak Actions"
    label: "No info match"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail-no-info-match%"
    }
    drill_fields: [detail*]
  }

  measure: no_streak {
    type: count
    group_label: "Streak Actions"
    label: "No streak"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail-no-streak%"
    }
    drill_fields: [detail*]
  }

  measure: over_48h {
    type: count
    group_label: "Streak Actions"
    label: "Over 48h"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail-over-48-hours%"
    }
    drill_fields: [detail*]
  }

  measure: over_72h {
    type: count
    group_label: "Streak Actions"
    label: "Over 72h"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail-over-72-hours%"
    }
    drill_fields: [detail*]
  }

  measure: fail_username {
    type: count
    group_label: "Streak Actions"
    label: "Fail Username"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail-username%"
    }
    drill_fields: [detail*]
  }

  measure: sr_success {
    type: count
    group_label: "Streak Actions"
    label: "Successfully Restored"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-success%"
    }
    drill_fields: [detail*]
  }

  measure: sr_fail {
    type: count
    group_label: "Streak Actions"
    label: "Failed to Restore"
    approximate_threshold: 100000
    filters: {
      field: tag
      value: "%sr-fail%"
    }
    drill_fields: [detail*]
  }

    # STREAK ACTIONS PERCENT

  measure: low_value_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "Low Value %"
    sql: ${low_value}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: no_info_match_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "No info match %"
    sql: ${no_info_match}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: no_streak_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "No Streak %"
    sql: ${no_streak}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: over_48h_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "Over 48h %"
    sql: ${over_48h}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: over_72h_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "Over 72h %"
    sql: ${over_72h}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: fail_username_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "Fail Username %"
    sql: ${fail_username}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: sr_success_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "Successfully Restored %"
    sql: ${sr_success}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }

  measure: sr_fail_pt {
    type: number
    group_label: "Streak Actions Percent"
    label: "Failed to Restore %"
    sql: ${sr_fail}/${count_tickets} ;;
    drill_fields: [detail*]
    value_format_name: percent_1
  }




  set: detail {
    fields: [
      created_time,
      url,
      description,
      status,
      ticket_form_id,
      tag,
      device_os_version,
      snapchat_version_primary
    ]
  }


}
