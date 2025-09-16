# most active contributor jbabra@snapchat.com
view: attribution_events {
  label: "Sanitized App Attribution Events 🧼"

  dimension: id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${attribution_events.ad_account_id} AS STRING),'|', CAST(${appinstall_matched_events.said} AS STRING)) ;;
  }


  dimension: ad_account_id {
    type: string
  }

  dimension: ghost_mode_link {
    label: "Ghost Mode(Audiences)"
   type: string
    sql: CONCAT("https://softserve-prod.appspot.com/",${ad_account_id}, "/audiences") ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
  }

  measure: count_ad_account_id {
    sql: ${ad_account_id} ;;
  type: count_distinct
  label: "Count Distinct Ad Account IDs"
  }



#appid
#  sql: CONCAT(CAST(${attribution_events.ad_account_id} AS STRING),'|', CAST(${said} AS STRING)) ;;

  }
