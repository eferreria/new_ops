view: ticketevents_ghostid {
label: "Tickets with Login events"

  derived_table: {
    sql:
        SELECT
            ticket_id,
            uname,
            ghost_id,
FROM (
  SELECT
    ev.ticket_id AS ticket_id,
    ev.extract_un AS uname,
    un_map.ghost_id AS ghost_id,
  FROM (
    SELECT
      ticket_id,
      LOWER(JSON_EXTRACT_SCALAR(child_json,
          "$.custom_ticket_fields.24281229")) AS extract_un
    FROM
      [sc-analytics:report_zendesk.ticket_events]
    WHERE
      {% condition partition_filter %} _PARTITIONTIME {% endcondition %}
      --DATE(_PARTITIONTIME) >= "2022-02-01"
      AND child_via = "Web service"
      AND child_event_type = "Create"
      AND child_json LIKE '%24281229%' ) AS ev
  LEFT JOIN
    (SELECT user_name, ghost_id, mutable_user_name FROM
    TABLE_QUERY([sc-targeting-measurement:user_ids],
          "table_id IN (SELECT table_id FROM [sc-targeting-measurement:user_ids.__TABLES__]
          WHERE REGEXP_MATCH(table_id, r'^ghost_id_with_username_[0-9]{8}$') ORDER BY table_id DESC LIMIT 1)")
    ) AS un_map
  ON  ev.extract_un = un_map.user_name
  WHERE  un_map.ghost_id IS NOT NULL
  GROUP BY
    1,2,3)

    ,
  (
  SELECT
    ev.ticket_id AS ticket_id,
    ev.extract_un AS uname,
    un_map.ghost_id AS ghost_id,
  FROM (
    SELECT
      ticket_id,
      LOWER(JSON_EXTRACT_SCALAR(child_json,
          "$.custom_ticket_fields.24281229")) AS extract_un
    FROM
      [sc-analytics:report_zendesk.ticket_events]
    WHERE
    {% condition partition_filter %} _PARTITIONTIME {% endcondition %}
    --DATE(_PARTITIONTIME) >= "2022-02-01"
      AND child_via = "Web service"
      AND child_event_type = "Create"
      AND child_json LIKE '%24281229%' ) AS ev
  LEFT JOIN
    (SELECT user_name, ghost_id, mutable_user_name FROM
    TABLE_QUERY([sc-targeting-measurement:user_ids],
          "table_id IN (SELECT table_id FROM [sc-targeting-measurement:user_ids.__TABLES__]
          WHERE REGEXP_MATCH(table_id, r'^ghost_id_with_username_[0-9]{8}$') ORDER BY table_id DESC LIMIT 1)")
    ) AS un_map
  ON  ev.extract_un = un_map.mutable_user_name
  WHERE
    un_map.ghost_id IS NOT NULL
  GROUP BY
    1,2,3)
  GROUP BY
    1,2,3
          ;;

    persist_for: "48 hours"
  }

  # derived_table: {
  #   sql:
  # SELECT
  #   ev.ticket_id AS ticket_id,
  #   ev.extract_un AS uname,
  #   un_map.ghost_id AS ghost_id,
  # FROM (
  #   SELECT
  #     ticket_id,
  #     LOWER(JSON_EXTRACT_SCALAR(child_json,
  #         "$.custom_ticket_fields.24281229")) AS extract_un
  #   FROM
  #     [sc-analytics:report_zendesk.ticket_events]
  #   WHERE
  #     {% condition partition_filter %} _PARTITIONTIME {% endcondition %}
  #     --DATE(_PARTITIONTIME) >= "2022-02-01"
  #     AND child_via = "Web service"
  #     AND child_event_type = "Create"
  #     AND child_json LIKE '%24281229%' ) AS ev
  # LEFT JOIN
  #   (SELECT user_name, ghost_id, mutable_user_name FROM
  #   TABLE_QUERY([sc-targeting-measurement:user_ids],
  #         "table_id IN (SELECT table_id FROM [sc-targeting-measurement:user_ids.__TABLES__]
  #         WHERE REGEXP_MATCH(table_id, r'^ghost_id_with_username_[0-9]{8}$') ORDER BY table_id DESC LIMIT 1)")
  #   ) AS un_map
  # ON  ev.extract_un = un_map.user_name
  # WHERE  un_map.ghost_id IS NOT NULL
  # GROUP BY
  #   1,2,3
  #   ;;
  # }

  filter: partition_filter {
    label: "Event Date Filter"
    type: date
    default_value: "7 days ago for 7 days"
  }

  dimension: ticket_id {
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: uname {
    type: string
    hidden: yes
  }

  dimension_group: login_ts {
    type: time
    timeframes: [date, week, month, year, week_of_year, month_num, time, time_of_day, raw]
    sql:  MSEC_TO_TIMESTAMP(${login_events.event_date_hour_last_millis})  ;;
    convert_tz: no
    label: "Login UTC"
  }

  dimension: ghost_id {
    type: string
    hidden: yes
  }

  dimension: app_login {
    type: number
    description: "Count of logins"
    sql: ${login_events.app_login} ;;
  }

  dimension: reachability {
    type: string
    description: "Connection of login event - wifi or mobile data"
    sql: ${login_events.reachability} ;;
  }


  dimension: days_from_login_to_ticket_created {
    sql: ${login_events.login_to_tic_created}  ;;
    type: number
    description: "Number of days from ticket creation to logins"
  }

  dimension: login_1_day {
    type: yesno
    sql: ${login_events.login_1} ;;
    description: "Did the user log in within 1 day of submitting a ticket?"
  }

  dimension: login_2_days {
    type: yesno
    sql: ${login_events.login_2} ;;
  description: "Did the user log in within 2 days of submitting a ticket?"
  }

  dimension: login_5_days {
    type: yesno
    sql: ${login_events.login_5} ;;
    description: "Did the user log in within 5 days of submitting a ticket?"
  }

  dimension: login_7_days {
    type: yesno
    sql: ${login_events.login_7} ;;
    description: "Did the user log in within 7 days of submitting a ticket?"
  }


  measure: count_tickets {
    type: count
    approximate_threshold: 100000
  }

  measure: count_ghost_id {
    type: count_distinct
    sql: ${TABLE}.ghost_id ;;
    approximate_threshold: 100000
    description: "count of unique ghost ids or unique users"
  }

  measure: count_tickets_login_7_days {
    type: count
    filters: [login_7_days: "yes"]
    description: "Count of tickets for which a user logged in within 7 days from created date"
    approximate_threshold: 100000
  }

  measure: count_tickets_login_2_days {
    type: count
    filters: [login_2_days: "yes"]
    description: "Count of tickets for which a user logged in within 2 days from created date"
    approximate_threshold: 100000
  }

  measure: count_tickets_login_1_day {
    type: count
    filters: [login_1_day: "yes"]
    description: "Count of tickets for which a user logged in within 1 day from created date"
    approximate_threshold: 100000
  }

  measure: count_tickets_login_5_days {
    type: count
    filters: [login_5_days: "yes"]
    description: "Count of tickets for which a user logged in within 5 days from created date"
    approximate_threshold: 100000
  }

  # PERCENT

  measure: percent_tickets_login_1_day {
    type: number
    sql: ${count_tickets_login_1_day}/${count_tickets} ;;
    description: "Percent of tickets for which a user logged in within 1 day from created date"
    value_format_name: percent_0
  }

  measure: percent_tickets_login_2_days {
    type: number
    sql: ${count_tickets_login_2_days}/${count_tickets} ;;
    description: "Percent of tickets for which a user logged in within 2 days from created date"
    value_format_name: percent_0
  }

  measure: percent_tickets_login_5_days {
    type: number
    sql: ${count_tickets_login_5_days}/${count_tickets} ;;
    description: "Percent of tickets for which a user logged in within 5 days from created date"
    value_format_name: percent_0
  }

  measure: percent_tickets_login_7_days {
    type: number
    sql: ${count_tickets_login_7_days}/${count_tickets} ;;
    description: "Percent of tickets for which a user logged in within 7 days from created date"
    value_format_name: percent_0
  }

##  measure: count_logins {
##    type: sum
##    sql: ${login_events.count_logins} ;;
##    description: "Total number of times a user logged in the app"
##  }


}
