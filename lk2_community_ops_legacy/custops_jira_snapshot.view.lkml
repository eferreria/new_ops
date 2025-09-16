# most active contributor jbabra@snapchat.com
view: custops_jira_snapshot {
  derived_table: {
    sql:  SELECT DATE(record_date) AS record_date
                 ,key
                 ,INTEGER(id) AS id
                 ,status_name
                 ,CAST(status_time AS TIMESTAMP) AS status_time
                 ,issueType_name
                 ,BOOLEAN(CASE WHEN issueType_isSubtask = "false" THEN FALSE
                            WHEN issueType_isSubtask = "true" THEN TRUE
                            ELSE NULL
                        END) AS issueType_isSubtask
                 ,project_key
                 ,project_name
                 ,CAST(creationDate AS TIMESTAMP) AS creationDate
                 ,CAST(updateDate AS TIMESTAMP) AS updateDate
                 ,CAST(dueDate AS TIMESTAMP) AS dueDate
                 ,priority_name
                 ,CAST(priority_time AS TIMESTAMP) AS priority_time
                 ,CAST(triageTime AS TIMESTAMP) AS triageTime
                 ,CAST(fixTime AS TIMESTAMP) AS fixTime
                 ,fixVersion
                 ,affectedVersion
                 ,platform
                 ,changeHistory
                 ,triageHistory
                 ,labels
                 ,resolution_name
                 ,CAST(resolution_time AS TIMESTAMP) AS resolution_time
                 ,assignee
                 ,components
                 ,summary
                 ,impactedTeams
                 ,otherFields
          FROM TABLE_QUERY([lookinsoclear:jira_snapshots], "table_id IN (SELECT table_id FROM [lookinsoclear:jira_snapshots.__TABLES__] WHERE REGEXP_MATCH(table_id, r'^jira_snapshot_[0-9].*') ORDER BY table_id DESC LIMIT 1)");;
  }

######################
##### DIMENSIONS #####
######################

  dimension: id {
    label: "Ticket ID"
    type: string
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

  dimension: others {
    label: "others"
    type: string
    sql: ${TABLE}.otherFields ;;
  }

  dimension: key {
    label: "Ticket Key"
    type: string
    link: {
      label: "JIRA"
      url: "https://jira.sc-corp.net/browse/{{ value }}"}
    sql: ${TABLE}.key ;;
  }

  dimension: project_key {
    label: "Project Key"
    type: string
    sql: ${TABLE}.project_key ;;
  }

  dimension: Status {
    label: "Current Status"
    type: string
    sql: ${TABLE}.status_name ;;
  }

  dimension: Resolution {
    label: "Resolution Type"
    type: string
    sql: ${TABLE}.resolution_name ;;
  }


  dimension: project_name {
    label: "Project Name"
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension: status_name {
    label: "Ticket Status"
    type: string
    sql: ${TABLE}.status_name ;;
  }

  dimension: issueType_name {
    label: "Ticket Issue Type"
    type: string
    sql: ${TABLE}.issueType_name ;;
  }

  dimension: issueType_isSubtask {
    label: "Is Subtask"
    type: yesno
    sql: ${TABLE}.issueType_isSubtask ;;
  }

  dimension: priority_name {
    type: string
    sql: ${TABLE}.priority_name ;;
  }

  dimension: fixVersion {
    label: "Fix Version"
    type: string
    sql: ${TABLE}.fixVersion ;;
  }

  dimension: affectedVersion {
    label: "Affected Version"
    type: string
    sql: ${TABLE}.affectedVersion ;;
  }


  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }


  dimension: labels {
    type: string
    sql: ${TABLE}.labels ;;
  }


  dimension: resolution_name {
    type: string
    sql: ${TABLE}.resolution_name ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.assignee ;;
  }

  dimension: components {
    type: string
    sql: ${TABLE}.components ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.summary ;;
  }

  dimension: impactedTeams {
    label: "Impacted Teams"
    type: string
    sql: ${TABLE}.impactedTeams ;;
  }

  dimension: create_to_triage_minutes{
    type: number
    group_label: "Time Between Dimensions"
    value_format: "0.0"
    sql: TIMESTAMP_TO_SEC(${triageTime_raw})-TIMESTAMP_TO_SEC(${creationDate_raw})/60  ;;
  }

  dimension: create_to_resolution_minutes{
    type: number
    group_label: "Time Between Dimensions"
    value_format: "0.0"
    sql: TIMESTAMP_TO_SEC(${resolution_time_raw})-TIMESTAMP_TO_SEC(${creationDate_raw})/60  ;;
  }

  dimension: create_to_fix_set_minutes{
    type: number
    group_label: "Time Between Dimensions"
    value_format: "0.0"
    sql: TIMESTAMP_TO_SEC(${fixTime_raw})-TIMESTAMP_TO_SEC(${creationDate_raw})/60  ;;
  }

  dimension: create_to_priority_set_minutes{
    type: number
    group_label: "Time Between Dimensions"
    value_format: "0.0"
    sql: TIMESTAMP_TO_SEC(${priority_time_raw})-TIMESTAMP_TO_SEC(${creationDate_raw})/60  ;;
  }

  dimension: create_to_last_update_minutes{
    type: number
    group_label: "Time Between Dimensions"
    value_format: "0.0"
    sql: TIMESTAMP_TO_SEC(${updateDate_raw})-TIMESTAMP_TO_SEC(${creationDate_raw})/60  ;;
  }



###############################
####### DATE DIMENSIONS #######
###############################

  dimension_group: record_date {
    label: "Record"
    type: time
    sql: ${TABLE}.record_date ;;
  }

  dimension_group: status_time {
    label: "Status Updated At"
    type: time
    sql: ${TABLE}.status_time ;;
  }

  dimension_group: creationDate {
    label: "Ticket Created At"
    type: time
    sql: ${TABLE}.creationDate ;;
  }

  dimension_group: updateDate {
    label: "Ticket Updated At"
    type: time
    sql: ${TABLE}.updateDate ;;
  }

  dimension_group: priority_time {
    label: "Priority Updated At"
    type: time
    sql: ${TABLE}.priority_time ;;
  }

  dimension_group: triageTime {
    label: "Triaged At"
    type: time
    sql: ${TABLE}.triageTime ;;
  }

  dimension_group: fixTime {
    label: "Fixed At"
    type: time
    sql: ${TABLE}.fixTime ;;
  }

  dimension_group: resolution_time {
    label: "Resolved At"
    type: time
    sql: ${TABLE}.resolution_time ;;
  }



###################
#### MEASURES #####
###################

  measure: issue_count {
    type: count
  }
  measure: Average_Triage_Time  {
    type: average
    sql: CASE WHEN ${updateDate_raw} > 0
      THEN  (TIMESTAMP_TO_SEC(${updateDate_raw})-TIMESTAMP_TO_SEC(${creationDate_raw}))/3600
      END;;

  }



################
#### DETAIL ####
################
}
