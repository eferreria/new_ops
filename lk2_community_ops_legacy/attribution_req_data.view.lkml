# most active contributor jbabra@snapchat.com
view: attribution_req_data {

dimension: id {
  primary_key: yes
  hidden: yes
  sql: CONCAT(CAST(${appinstall_matched_events.said} AS STRING),'|', CAST(${processed_snap_app_ids} AS STRING)) ;;
}

dimension: processed_snap_app_ids {
  type: string
}

  dimension: appid {
    type: string
  }

  dimension: conversionevent {
    type: string
  }

  dimension: requestid {
    type: string
  }

  dimension: platform {
    type: string
  }

  dimension: eventsource {
    type: string
  }

  dimension: eventconversiontype {
    type: string
  }

  dimension: snapappid {
    type: string
  }

  dimension: partner {
    type: string
  }

  dimension: contenttype {
    type: string
  }




































}
