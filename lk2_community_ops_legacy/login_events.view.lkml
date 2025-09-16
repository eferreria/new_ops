view: login_events {

  derived_table: {

    sql: SELECT app_login, reachability, ghost_user_id, event_date_hour_last_millis
    FROM TABLE_DATE_RANGE([sc-portal:quest.app_app_login_user_], TIMESTAMP('20220201'),TIMESTAMP(CURRENT_DATE())) ;;

   persist_for: "48 hours"
  }

  #february onwards

  dimension: primary_key {
    primary_key: yes
    sql: concat(${ghost_user_id},"-",${event_date_hour_last_millis}) ;;
    hidden: yes
  }

  dimension: app_login {
    type: number
    description: "Count of logins"
    hidden: yes
  }

  dimension: reachability {
    type: string
    description: "Connection of login event - wifi or mobile data"
    hidden: yes
  }

  dimension: ghost_user_id {
    type: string
    hidden: yes
  }

  dimension: event_date_hour_last_millis {
    type: number
    hidden: yes
  }

  dimension_group: login_ts {
    type: time
    timeframes: [date, week, month, year, week_of_year, month_num, time, time_of_day, raw]
    sql: MSEC_TO_TIMESTAMP(${event_date_hour_last_millis})  ;;
    convert_tz: no
    label: "Login UTC"
  }

  dimension: login_to_tic_created {
  sql: DATEDIFF( ${login_ts_date} , ${zendesk_ticket.created_utc_date} )  ;;
  type: number
  description: "Number of days from ticket creation to logins"
  hidden: yes
  }

  dimension: login_1 {
    type: yesno
    sql: CASE WHEN ${login_to_tic_created} >= 0 AND ${login_to_tic_created} <=1 THEN TRUE ELSE FALSE END ;;
    hidden: yes
  }

  dimension: login_2 {
    type: yesno
    sql: CASE WHEN ${login_to_tic_created} >= 0 AND ${login_to_tic_created} <=2 THEN TRUE ELSE FALSE END ;;
    hidden: yes
  }

  dimension: login_5 {
    type: yesno
    sql: CASE WHEN ${login_to_tic_created} >= 0 AND ${login_to_tic_created} <=5 THEN TRUE ELSE FALSE END ;;
    hidden: yes
  }

  dimension: login_7 {
    type: yesno
    sql: CASE WHEN ${login_to_tic_created} >= 0 AND ${login_to_tic_created} <=7 THEN TRUE ELSE FALSE END ;;
    hidden: yes
  }


  # DATE_ADD(${TABLE}.creationTime,-7,'HOUR')

  measure: count_logins {
    type: sum
    sql: ${app_login} ;;
  }

  measure: count_ghost_ids {
    type: count_distinct
    sql: ${ghost_user_id} ;;
  }



}
