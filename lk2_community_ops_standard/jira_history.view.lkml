view: jira_history {
  derived_table: {
    sql: SELECT *
        FROM snap-air.jira_snapshot.jira_history as history
      JOIN (
        SELECT *, row_number() OVER(PARTITION BY id ORDER BY updated desc) AS row_num
        FROM snap-air.jira_snapshot.jira_snapshot_merge
      ) AS jira
      ON history.issue_id = jira.id AND jira.row_num = 1
     ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: issue_id {
    type: string
    sql: ${TABLE}.issue_id ;;
  }
  dimension: child_jira_key {
    type: string
    sql: ${TABLE}.child_jira_key ;;
    link: {
      label: "Jira Link"
      url: "https://jira.sc-corp.net/browse/{{ key }}"
    }
  }
  dimension: responsible_team {
    type: string
    sql: ${TABLE}.responsible_team ;;
  }
  dimension: is_anr_deadlock {
    type: string
    sql: ${TABLE}.is_anr_deadlock ;;
  }
  dimension: isSystemCrash {
    type: string
    sql: ${TABLE}.isSystemCrash ;;
  }
  dimension: crash_type {
    type: string
    sql: ${TABLE}.crash_type ;;
  }


  dimension: history_id {
    type: string
    sql: ${TABLE}.history_id ;;
  }

  dimension_group: history_created {
    type: time
    sql: ${TABLE}.history_created ;;
  }

  dimension: author_key {
    type: string
    sql: ${TABLE}.author_key ;;
  }
  dimension: bot_name {
    type: string
    sql:case
          when
          ${TABLE}.author_key like '%svc%' then  ${TABLE}.author_key
         else 'manual' end ;;
  }

  dimension: author_type {
    type: string
    sql: case when ${TABLE}.author_key like '%svc%' or ${TABLE}.author_key like '%atg%' then 'bot' else 'manual' end;;
  }

  dimension: field {
    type: string
    sql: ${TABLE}.field ;;
  }

  dimension: from {
    type: string
    sql: ${TABLE}.`from` ;;
  }

  dimension: from_string {
    type: string
    sql: ${TABLE}.from_string ;;
  }

  dimension: to {
    type: string
    sql: ${TABLE}.`to` ;;
  }

  dimension: to_string {
    type: string
    sql: ${TABLE}.to_string ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
    link: {
      label: "Jira Link"
      url: "https://jira.sc-corp.net/browse/{{ key }}"
    }
  }

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: status_name {
    type: string
    sql: ${TABLE}.status_name ;;
  }

  dimension_group: status_time {
    type: time
    sql: ${TABLE}.status_time ;;
  }

  dimension: issue_name {
    type: string
    sql: ${TABLE}.issue_name ;;
  }

  dimension: issuetype_subtype {
    type: string
    sql: ${TABLE}.issuetype_subtype ;;
  }

  dimension: project_key {
    type: string
    sql: ${TABLE}.project_key ;;
  }

  dimension: project_name {
    type: string
    sql: ${TABLE}.project_name ;;
  }

  dimension_group: created {
    type: time
    sql: ${TABLE}.created ;;
  }

  dimension_group: updated {
    type: time
    sql: ${TABLE}.updated ;;
  }

  dimension_group: duedate {
    type: time
    sql: ${TABLE}.duedate ;;
  }

  dimension: priority_name {
    type: string
    sql: ${TABLE}.priority_name ;;
  }

  dimension_group: priority_time {
    type: time
    sql: ${TABLE}.priority_time ;;
  }

  dimension_group: triage_time {
    type: time
    sql: ${TABLE}.triage_time ;;
  }

  dimension_group: fix_time {
    type: time
    sql: ${TABLE}.fix_time ;;
  }

  dimension: components {
    type: string
    sql: ${TABLE}.components ;;
  }

  dimension: fix_version {
    type: string
    sql: ${TABLE}.fix_version ;;
  }

  dimension: affected_versions {
    type: string
    sql: ${TABLE}.affected_versions ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.assignee ;;
  }

  dimension: crash_group {
    type: string
    sql: ${TABLE}.crash_group ;;
  }

  dimension: resolution {
    type: string
    sql: ${TABLE}.resolution ;;
  }

  dimension_group: resolution_date {
    type: time
    sql: ${TABLE}.resolution_date ;;
  }

  dimension: labels {
    type: string
    sql: ${TABLE}.labels ;;
  }

  dimension: summary {
    type: string
    sql: ${TABLE}.summary ;;
  }

  dimension: parent_jira_key {
    type: string
    sql: ${TABLE}.parent_jira_key ;;
  }

  dimension: git_pr {
    type: string
    sql: ${TABLE}.git_pr ;;
  }

  dimension: git_fixed_version {
    type: string
    sql: ${TABLE}.git_fixed_version ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension_group: jira_snapshot_updated {
    type: time
    sql: ${TABLE}.jira_snapshot_updated ;;
  }

  dimension: reporter {
    type: string
    sql: ${TABLE}.reporter ;;
  }

  dimension: impacted_team {
    type: string
    sql: ${TABLE}.impacted_team ;;
  }

  dimension: publisher_developer {
    type: string
    sql: ${TABLE}.publisher_developer ;;
  }

  dimension_group: last_human_update {
    type: time
    sql: ${TABLE}.last_human_update ;;
  }

  dimension: additional_info {
    type: string
    sql: ${TABLE}.additional_info ;;
  }

  dimension: row_num {
    type: number
    sql: ${TABLE}.row_num ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
  }

  dimension: customer_ops_metric_alert {
    type: string
    sql: ${TABLE}.customer_ops_metric_alert ;;
  }

  dimension: customer_ops_total_report_volume {
    type: string
    sql: ${TABLE}.customer_ops_total_report_volume ;;
  }

  dimension_group: first_customer_report {
    type: time
    sql: CAST (${TABLE}.first_customer_report AS TIMESTAMP) ;;
  }

  dimension: customer_issue_root_cause_description {
    type: string
    sql: ${TABLE}.customer_issue_root_cause_description ;;
  }

  set: detail {
    fields: [
      key,
      id,
      status_name,
      status_time_time,
      issue_name,
      issuetype_subtype,
      project_key,
      project_name,
      created_time,
      updated_time,
      duedate_time,
      priority_name,
      priority_time_time,
      triage_time_time,
      fix_time_time,
      components,
      fix_version,
      affected_versions,
      platform,
      assignee,
      crash_group,
      resolution,
      resolution_date_time,
      labels,
      summary,
      parent_jira_key,
      git_pr,
      git_fixed_version,
      source
    ]
  }
}
