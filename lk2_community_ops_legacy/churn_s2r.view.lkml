# most active contributor jbabra@snapchat.com
view: churn_s2r {

  derived_table: {
    sql: SELECT c.userID AS userID,
        c.lastEngagementTime AS lastEngagementTime,
        c.deviceType AS deviceType,
        c.version AS version,
        c.creationTime AS creationTime,
        c.lastCountry AS lastCountry,
        c.ghost_user_id AS ghost_user_id,
        d.device_model AS device_model
FROM (SELECT
        userID,
        lastEngagementTime,
        deviceType,
        version,
        creationTime,
        lastCountry,
        ghost_user_id
            FROM TABLE_QUERY([sc-analytics:report_user],
                "table_id IN (SELECT table_id FROM [sc-analytics:report_user.__TABLES__]
                WHERE REGEXP_MATCH(table_id, r'^identity_[0-9]{8}$')
                ORDER BY table_id
                DESC LIMIT 1)")) AS c

JOIN (SELECT
  ghost_user_id,
  country,
  device,
  device_model
 FROM TABLE_QUERY([sc-analytics:report_app], "table_id IN
              (SELECT table_id
              FROM [sc-analytics:report_app.__TABLES__]
              WHERE REGEXP_MATCH(table_id, r'^dau_user_device_model_country_[0-9]{8}')
              ORDER BY table_id DESC
              LIMIT 1)")) AS d ON c.ghost_user_id = d.ghost_user_id
 ;;
  }

#Dimensions

dimension: userid {
  type: string
  primary_key: yes
  sql: ${TABLE}.userID ;;
}

  dimension: ghost_user_id {
    type: string
    sql: ${TABLE}.ghost_user_id ;;
  }

  # dimension_group: account_creation_time {
  #   type: time
  #   sql: ${TABLE}.creationTime ;;
  # }

  dimension_group: last_engagement_time {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.lastEngagementTime ;;
  }

  # dimension: last_engagement_time {


  # }

  dimension: device_type {
    type: string
    sql: ${TABLE}.deviceType ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: snap_version {
    type: string
    sql: ${TABLE}.version ;;
  }

dimension: last_country {
  type: string
  label: "Last country of user"
  sql: ${TABLE}.lastCountry ;;
}

  dimension: churn_days {
    label: "Days since last active"
    description: "difference between today's date and last engagement date in UTC"
    type: number
    sql: DATEDIFF( CURRENT_DATE(), ${last_engagement_time_date}) ;;

  }

# Measures

measure: count {
  type: count
  label: "Count of unique userIDs"
 # sql: ${userid} ;;
drill_fields: [churn_days, last_engagement_time_date]

}


}
