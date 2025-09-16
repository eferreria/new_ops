# most active contributor abenharosh@snapchat.com
view: social_events {
  view_label: "Social Events"
  derived_table: {
    sql:
      SELECT
          id,
          case_id,
          created_date,
          field,
          new_value,
          old_value,
          created_by_id,
          "Salesforce" as event_origin,
          null as agent_city

      FROM `sc-analytics.prod_metadata_crm_co.case_history_20240221`  -- 2024-02-21 was the last day of operation in SF Social Studio before Sprinklr migration
      WHERE CAST(created_date AS TIMESTAMP) <= CAST('2024-02-22' AS TIMESTAMP)

      UNION ALL

      SELECT
      h.Workflow_Key_1 as id,
      h.CASE_NUMBER_0 as case_id,
      CAST(timestamp_millis(cast(h.CUSTOM_PROPERTY_ASSIGNMENT_TIME_4 as int64)) AS STRING) as created_date,
      h.CUSTOM_PROPERTY_FIELD_NAME_2 as field,
      h.CUSTOM_PROPERTY_VALUE_3 as new_value,
      NULL AS old_value,
      h.Modified_By_User_Default_Empty_Value_5 AS created_by_id,
      "Sprinklr" as event_origin,
      u.USER_CUSTOM_PROPERTY_5 as agent_city

      FROM `sc-sprinklr.prod_metadata_sprinklr.case_history` as h
      LEFT JOIN `sc-sprinklr.prod_metadata_sprinklr.user` as u on u.USER_ID_2 = h.Modified_By_User_Default_Empty_Value_5

      WHERE CAST(timestamp_millis(cast(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4 as int64)) AS TIMESTAMP) >= CAST('2024-02-22' AS TIMESTAMP)

      UNION ALL

      SELECT
      concat(CASE_ID_0,"-Escalation")  as id
      ,CASE_ID_0 as case_id
      ,CAST(timestamp_millis(cast(t.event_time as int64)) AS STRING) as created_date
      ,"Escalate from L1 to L2" as field
      ,UNIVERSAL_CASE_CUSTOM_PROPERTY_22 as new_value
      ,null as old_value
      ,u.USER_ID_2 as created_by_id
      ,"Sprinklr" as event_origin
      ,u.USER_CUSTOM_PROPERTY_5 as agent_city

      FROM `sc-sprinklr.prod_metadata_sprinklr.cases`
      LEFT JOIN `sc-sprinklr.prod_metadata_sprinklr.user`  as u on u.EMAIL_1 = D_LAST_ENGAGED_USER_EMAIL_ADDR_0
      LEFT JOIN (select CASE_NUMBER_0, min(CUSTOM_PROPERTY_ASSIGNMENT_TIME_4) as event_time from `sc-sprinklr.prod_metadata_sprinklr.case_history` WHERE CUSTOM_PROPERTY_FIELD_NAME_2 = "Status" and CUSTOM_PROPERTY_VALUE_3="Assigned" GROUP BY 1) as t on t.CASE_NUMBER_0 = CASE_ID_0

      where UNIVERSAL_CASE_CUSTOM_PROPERTY_22 = "Yes" AND UNIVERSAL_CASE_CUSTOM_PROPERTY_21 = "Yes"

      --  _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', CURRENT_DATE("America/Los_Angeles"))
      ;;
  }

##   DIMENSIONS  ##

  dimension: id {
    label: "Event ID"
    hidden: no
    type: string
    primary_key: yes
  }

  dimension: case_id {
    type: string
    hidden: yes
  }

  dimension: event_origin {
    type: string
    hidden: yes
  }

  dimension: url {
    type: string
    label: "Case URL"
    sql: CONCAT('https://snapchat.my.salesforce.com/',(${case_id}));;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
    hidden: yes
  }

  dimension_group: updated_at_pst  {
    type: time
    convert_tz: no
    label: "Event PST"
    description: "Timestamp of a particular event"
    sql: TIMESTAMP_ADD(CAST(${TABLE}.created_date AS TIMESTAMP), INTERVAL -7 HOUR);;
  }

  dimension_group: updated_utc {
    type: time
    convert_tz: no
    label: "Event UTC"
    sql: CAST(${TABLE}.created_date AS TIMESTAMP) ;;
    timeframes: [date, time, hour, hour_of_day, week, day_of_week, month, year, quarter]
  }

  dimension: field {
    type: string
    description: "Field which was updated"
  }

  dimension: is_deleted {
    type: string
    hidden: yes
  }

  dimension: new_value {
    type: string
    description: "New value of the field which will change"
  }

  dimension: old_value {
    type: string
    label: "Old Value (SF Only)"
    description: "Old value of the field which changed"
  }

  dimension: event_agent_city {
    sql: CASE WHEN ${all_case_owners}="Not an Agent change" THEN NULL ELSE ${TABLE}.agent_city  END;;
    type: string
    description: "City for the agent that associated with the event"
  }

  dimension: status_change {
    sql: CASE
          WHEN ${field} = "Status" THEN ${new_value}
          ELSE "Not a status update" END ;;
    type: string
    description: "Change of status update"
  }

  dimension: tier_change {
    sql: CASE
          WHEN ${field} = "Owner" and (${new_value} LIKE '%Tier%')
          and (${old_value} LIKE '%Tier%' )
          THEN TRUE
            ELSE FALSE END;;
    type: yesno
    label: "Tier Change"
    description: "Change of Tier update"
    hidden: yes
  }

  dimension: escalation {
    sql: CASE
          WHEN ${event_origin}="Salesforce" AND ${field} = "Owner" and ( ${new_value} LIKE '%Tier 2%' and ${old_value} LIKE '%Tier 1%'  ) THEN TRUE
          WHEN ${event_origin}="Sprinklr" AND field="Escalate from L1 to L2" THEN TRUE
          ELSE FALSE END;;
    label: "Escalation"
    type: yesno
    description: "Escalated from Tier 1 to 2"
  }

  dimension: created_by_id {
    type: string
    hidden: yes
  }

  dimension: all_case_owners {
    label: "All Case Owners"
    type: string
    sql: CASE
        WHEN ${event_origin}="Salesforce" AND
        (${field} = "Owner" AND ${new_value} not LIKE '00%' AND ${old_value} not LIKE '00%'
          AND ${old_value} not LIKE '%Social Studio Integration User%'
          AND ${new_value} not LIKE '%Queue%' AND ${old_value} not LIKE '%Queue%')
        THEN ${new_value}
        WHEN ${event_origin}="Sprinklr" AND ${created_by_id}="-" THEN "Not an Agent change"
        WHEN ${event_origin}="Sprinklr" AND ${field}="Status" THEN ${created_by_id}
        ELSE "Not an Agent change" END
        ;;
    description: "This is a list of all the case owners who were assigned the case"
  }

  # dimension: spam_false_positives {
  #   type: yesno
  #   sql: CASE
  #         WHEN ${field} = "Reporting_Values__c" AND ${old_value} = "Automation:Spam" AND ${new_value} != "Automation:Spam" THEN TRUE
  #         ELSE FALSE END  ;;
  #   description: "Cases with initial reporting values Automation:Spam but changed after agent review"
  # }


  ##   MEASURES  ##

  measure: count_updates {
    type: count_distinct
    sql: ${id} ;;
    drill_fields: [jango*]
    description: "Count of all updates"
  }

  measure: count_open {
    type: count_distinct
    hidden: yes
    sql: ${id} ;;
    filters: {
      field: status_change
      value: "Open"
    }
    drill_fields: [jango*]
    description: "Count of Open status events"
  }

  measure: count_closed_responded {
    type: count_distinct
    hidden: no
    sql: CASE WHEN ${status_change} IN ("Closed Responded", "Closed") THEN ${id} ELSE NULL END ;;
    drill_fields: [jango*]
    description: "Count of Closed Responded status events"
  }

  measure: count_closed_no_respond {
    type: count_distinct
    hidden: no
    sql: CASE WHEN ${status_change} IN ("Closed No Response", "No Response Required") THEN ${id} ELSE NULL END ;;
    drill_fields: [jango*]
    description: "Count of Closed No Response status events"
  }

  measure: count_pending {
    type: count_distinct
    hidden: yes
    sql: ${id} ;;
    filters: {
      field: status_change
      value: "Pending"
    }
    drill_fields: [jango*]
    description: "Count of Pending status events"
  }

  measure: count_status_change {
    type: count_distinct
    hidden: yes
    sql: ${id} ;;
    filters: {
      field: status_change
      value: "Open, Closed Responded, Closed No Response, Pending"
    }
    drill_fields: [jango*]
    description: "Count of all status change events"
  }

  measure: count_tier_change {
    type: count_distinct
    label: "Count Tier Change"
    hidden: yes
    sql: ${id} ;;
    filters: {
      field: tier_change
      value: "yes"
    }
    drill_fields: [jango*]
    description: "Count of Tier Change events"
  }

  measure: count_escalations {
    type: count_distinct
    label: "Count Escalations"
    sql: ${id} ;;
    filters: {
      field: escalation
      value: "yes"
    }
    drill_fields: [jango*]
    description: "Count of Tier Change events"
  }

  measure: tickets_per_agent_per_hr {
    label: "Tickets per Agent per Hr"
    type: number
    description: "Count of tickets solved(respond + no respond) per agent per hour"
    sql:  (${count_closed_responded} + ${count_closed_no_respond} + ${count_escalations})/ NULLIF (COUNT (distinct CONCAT(${social_agent.email}, ${updated_utc_hour})), 0) ;;
    drill_fields: [jango*]
    value_format_name: decimal_1
  }

  set: jango {
    fields: [updated_at_pst_time,
      case_id,
      field,
      old_value,
      new_value,
      status_change,
      all_case_owners]
  }

}
