connection: "svc-looker-community-ops-legacy"
include: "//hub_looker_production/access_grant.lkml"
include: "lk2_community_ops_legacy/*.view.lkml"
include: "//hub_looker_production/access_grant.lkml"
include: "//hub_looker_production/common/common_blizzard.view.lkml"
include: "//hub_looker_production/camera_platform/report_geofilter_metadata.view.lkml"
include: "//hub_looker_production/bizops/prod_analytics_app.view.lkml"
include: "//hub_looker_production/bizops/zendesk_ticket.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_metadata.view.lkml"
include: "view_files_with_out_target/*.view.lkml"
include: "//hub_looker_production/engineering_security/taskservice_review_duration.view.lkml"
include: "//hub_looker_production/community_ops/inapp_abuse_reporting_taskhistories.view.lkml"
include: "//hub_looker_production/community_ops/inapp_abuse_reporting_queues.view.lkml"
include: "//hub_looker_production/community_ops/inapp_abuse_reporting_tasks.view.lkml"
include: "//hub_looker_production/platform_integrity/ads_funding_source.view.lkml"
include: "//hub_looker_production/community_ops/business_support_chat_transcript.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_form.view.lkml"
include: "//hub_looker_production/platform_integrity/custops_snap_ads_task_meta.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_category.view.lkml"
include: "//hub_looker_production/community_ops/custops_snap_ads_task_tag_category.view.lkml"
include: "//hub_looker_production/bizops/custops_support_zendesk_ticket_group_based_metrics.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_subcategory.view.lkml"
include: "//hub_looker_production/community_ops/inclusive_region_lsql.view.lkml"
include: "//hub_looker_production/community_ops/jira_intermidiate.view.lkml"
include: "//hub_looker_production/platform_integrity/custops_snap_ads_api_ads.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_ticket_union.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_ticket_metric_sets.view.lkml"
include: "//hub_looker_production/platform_integrity/zendesk_backlog.view.lkml"
include: "//hub_looker_production/community_ops/custops_fte_vendor_users.view.lkml"
include: "//hub_looker_production/platform_integrity/taskservice_tasks_qa.view.lkml"
include: "//hub_looker_production/platform_integrity/ad_review_fraud_orgs.view.lkml"
include: "//hub_looker_production/community_ops/custops_odg_rejections.view.lkml"
include: "//hub_looker_production/platform_integrity/taskservice_task_backlog_snapshot.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_ticket_individual_tags.view.lkml"
include: "//hub_looker_production/community_ops/business_support_zendesk_chat.view.lkml"
include: "//hub_looker_production/community_ops/custops_jira.view.lkml"
include: "//hub_looker_production/platform_integrity/custops_odg_orders.view.lkml"
include: "//hub_looker_production/platform_integrity/snap_ads_tasks_aht.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_audit_ids.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_ticket_history.view.lkml"
include: "//hub_looker_production/community_ops/country_info.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_agent.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_csat.view.lkml"
include: "//hub_looker_production/platform_integrity/zendesk_ticket_agent_turnaround_time.view.lkml"
include: "//hub_looker_production/community_ops/task_qa_shadow.view.lkml"
include: "//hub_looker_production/platform_integrity/ads_ownership.view.lkml"
include: "//hub_looker_production/community_ops/customer_reports_abtest.view.lkml"
include: "//hub_looker_production/community_ops/general_support_reason.view.lkml"
include: "//hub_looker_production/platform_integrity/custops_snap_ads_task_histories.view.lkml"
include: "//hub_looker_production/community_ops/custops_odg_audit_log.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_group.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_ticket_initials.view.lkml"
include: "//hub_looker_production/community_ops/identity.view.lkml"
include: "//hub_looker_production/platform_integrity/taskservice_taskhistories.view.lkml"
include: "//hub_looker_production/platform_integrity/taskservice_tasks.view.lkml"
include: "//hub_looker_production/platform_integrity/customer_ops_iaa.view.lkml"
include: "//hub_looker_production/platform_integrity/customer_ops_dau_agg.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_custom_fields.view.lkml"
include: "//hub_looker_production/platform_integrity/pi_leo_fte_zd_qa_scores.view.lkml"
include: "/lk2_community_ops_legacy/support_site_experiment_schedule_legacy.view.lkml"
include: "//hub_looker_production/platform_integrity/leo_ticket_custom_fields.view.lkml"
include: "//hub_looker_production/platform_integrity/ts_fte_roster_spreadsheet.view.lkml"
#include: "//hub_looker_production/community_ops/ticket_buckets.view.lkml"
#include: "//hub_looker_production/platform_integrity/leo_headcount_agg3.view.lkml"


include: "/**/*.dashboard"
label: "Community Ops lk2"

access_grant: spam_access {
  user_attribute: email
  allowed_values: ["abenharosh@snapchat.com", "adong@snapchat.com", "cyang4@snapchat.com", "edwin.jacintobringuez@snapchat.com", "jhaytko@snapchat.com", "kgiltz@snapchat.com", "rsiniscalchi@snapchat.com", "bbhalkiker@snapchat.com", "vemany@snapchat.com", "dhluhovska@snapchat.com", "fruttledge@snapchat.com", "brooke.winn@snapchat.com"]
## this parameter gates access to spam signal filters, owned by abenharosh@snapchat.com
  }

week_start_day: monday     # DO NOT CHANGE

explore: custops_business_operations_roster {
  label: "CO Business Operations - Team Roster"
}

explore: zendesk_ticket_union {
  label: "Zendesk Ticket Union"

  join: zendesk_ticket {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_union.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.group_id
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_initials.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.assignee_id
  }

  join: zendesk_ticket_tag {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.id
  }

  join: zendesk_category {
    type: left_outer
    relationship: one_to_many
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: one_to_many
    foreign_key: zendesk_ticket.subcategory
  }

  join: zendesk_ticket_metric_sets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_union.ticket_id} = ${zendesk_ticket_metric_sets.ticket_id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_ticket_agent_turnaround_time {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_agent_turnaround_time.ticket_id} = ${zendesk_ticket_union.ticket_id} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

}

# explore: leo_headcount_agg3 {
#   view_name: leo_headcount_agg3
#   from: leo_headcount_agg3
# }

explore: leo_roster_headcount_agg {}

explore: zendesk_ticket {
  label: "Zendesk Ticket"
  view_label: "   Zendesk Ticket"
  sql_always_where: ${ticket_form_id} <> 149423 ;;

  # join: ticket_buckets {
  #   type: left_outer
  #   view_label: "Ticket Buckets"
  #   relationship: many_to_many
  #   sql_on: ${zendesk_ticket.requester_id} = ${ticket_buckets.zendesk_ticket_requester_id} AND ${zendesk_ticket.created_date} = ${ticket_buckets.zendesk_ticket_created_utc_date} ;;
  # }

  join: zendesk_group {
    view_label: "  Zendesk Group"
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.group_id
  }

  join: zendesk_agent {
    view_label: "  Zendesk Agent"
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.assignee_id
  }

  join: zendesk_category {
    type: left_outer
    view_label: "  Zendesk Category"
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    view_label: "  Zendesk Subcategory"
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }

  join: zendesk_ticket_metric_sets {
    view_label: "  Zendesk Ticket Metric Sets"
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_metric_sets.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_initials {
    view_label: "  Zendesk Ticket Initials"
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_initials.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_csat {
    type: left_outer
    view_label: "  Zendesk CSAT"
    relationship: one_to_one
    sql_on: ${zendesk_csat.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: custops_fte_vendor_users {
    view_label: " Agent Roster"
    relationship: many_to_one
    type: left_outer
    sql_on: ${custops_fte_vendor_users.email} = ${zendesk_agent.email} ;;
  }

  join: s2r_android_user {
    type: left_outer
    relationship: many_to_one
    sql_on: ${s2r_android_user.reportId} = ${zendesk_ticket.report_id} ;;
    view_label: " In-App Customer Contacts"
  }

  join: customer_reports_abtest {
    type: left_outer
    view_label: " Customer A/B Test"
    relationship: many_to_one
    sql_on: ${s2r_android_user.userId} = ${customer_reports_abtest.ghost_user_id} ;;
  }

  join: identity {
    view_label: " Identity"
    type: inner
    sql_on: ${s2r_android_user.userId} = ${identity.ghost_user_id} ;;
    relationship: many_to_one
  }

  join: country_info {
    view_label: " Country Info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: custops_jira {
    type: full_outer_each
    view_label: "CustOps JIRA"
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_intermidiate_id} = ${custops_jira.id} ;;
    sql_where: ${custops_jira.project_key} IN ("ADL",  "ADS",  "APP",  "APPINS",  "ARP",  "AY",  "BM",  "BO",  "CAMEO",  "CAMERA",  "CLIENT",  "COE",  "CONTEXT",  "CONVO",  "COPM",  "CREATE",  "CUSTOPS",  "DAPL",  "DELI",  "DF",  "FF",  "GAME",  "IDT",  "IMPALA",  "INF",  "L10N",  "LOC",  "LOOK",  "MAPS",  "MDP",  "MEM",  "MONP",  "OPERA",  "ORCA", "OSP", "PROFILE",  "PUSH",  "RPG",  "SCT",  "SEARCH",  "SEC",  "SFDC",  "SGS",  "SPT",  "STORIES",  "TOOLS",  "TR",  "ZD", "ADCL", "COM", "DP") ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_ticket_agent_turnaround_time {
    type: left_outer
    view_label: "  Zendesk Ticket Agent Turnaround Time"
    relationship: many_to_one
    sql_on: ${zendesk_ticket_agent_turnaround_time.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: le_contacts_info {
    type: left_outer
    view_label: "LE Contacts Info"
    relationship: many_to_one
    sql_on: ${zendesk_ticket.requester_id} = ${le_contacts_info.requester_id} ;;
  }

  join: leo_ramp_status {
    type: left_outer
    relationship: one_to_many
    sql_on: ${zendesk_agent.email} = ${leo_ramp_status.email} ;;
  }

  join: ticket_spam_metadata {
    view_label: "Spam Metadata"
    type: left_outer
    relationship: one_to_one
    sql_on: ${ticket_spam_metadata.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: support_site_experiment_schedule_legacy {
    view_label: "Support Site Experiments"
    relationship: many_to_one
    type: left_outer
    sql_on: ${zendesk_ticket.created_hour_id} = ${support_site_experiment_schedule_legacy.hour_id} ;;
  }

  join: custops_ghost_ids {
    view_label: "Ghost IDs"
    type: left_outer
    relationship: one_to_one
    sql_on: ${custops_ghost_ids.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: simple_snap_users {
    view_label: "Simple Snap Users"
    type: left_outer
    relationship: one_to_one
    sql_on: ${simple_snap_users.ghost_user_id} =  ${custops_ghost_ids.ghost_id}  ;;
  }

  join: zendesk_ticket_trendfinder_group {
    view_label: "Trendfinder Group"
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket.id} = ${zendesk_ticket_trendfinder_group.zendesk_ticket_id};;
  }

  # join: custops_appeal_users {
  #   view_label: "Appeal Users"
  #   type: left_outer
  #   relationship: one_to_one
  #   sql_on: ${custops_appeal_users.ghost_user_id} =  ${custops_ghost_ids.ghost_id}  ;;
  # }

}


explore: custops_support_zendesk_qa_sample {
  label: "CO Support - Zendesk QA Sampler"
}

explore: custops_review_odg_qa_acn {
  label: "CO On-Demand G/L - Review QA"
}

explore: custops_review_odg_qa_fte {
  label: "CO On-Demand G/L - Review QA FTE"
}

explore: custops_odg_orders {
  label: "CO On-Demand G/L - Orders Distinct"

  join: custops_odg_audit_log {
    type: left_outer
    relationship: one_to_many
    sql_on: ${custops_odg_audit_log.lineitem_id} = ${custops_odg_orders.id} ;;
  }

  join: custops_odg_rejections {
    type: left_outer
    relationship: one_to_many
    sql_on: ${custops_odg_rejections.id} = ${custops_odg_orders.id} ;;
  }

  join: approver_users {
    from: custops_fte_vendor_users
    view_label: "Approver Users"
    type: left_outer
    relationship: one_to_many
    fields: [fte_contractor_or_vendor_name, email, name, location]
    sql_on: ${approver_users.email} = ${custops_odg_orders.approver_email} ;;
  }

  join: audit_log_users {
    from: custops_fte_vendor_users
    view_label: "Audit Log Users"
    type: left_outer
    relationship: one_to_many
    fields: [fte_contractor_or_vendor_name, email, name, location]
    sql_on: ${audit_log_users.email} = ${custops_odg_audit_log.username} ;;
  }
}

explore: zendesk_ticket_individual_tags {
  label: "Individual Tag Reporting"

  join: zendesk_ticket {
    type: left_outer
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_ticket_individual_tags.id} ;;
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_individual_tags.id} = ${zendesk_ticket_initials.ticket_id} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.group_id} = ${zendesk_group.id} ;;
  }

  join: zendesk_ticket_tag {
    type: left_outer
    fields: []
    relationship: one_to_one
    foreign_key: zendesk_ticket.id
  }

  join: zendesk_ticket_metric_sets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_individual_tags.id} = ${zendesk_ticket_metric_sets.ticket_id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.assignee_id
  }

  join: zendesk_ticket_history {
    type: left_outer
    relationship: many_to_many
    sql_on: ${zendesk_ticket_individual_tags.id} =  ${zendesk_ticket_history.ticket_id} ;;
  }

  join: history_agents {
    from: zendesk_agent
    view_label: "Zendesk History Agent"
    type: left_outer
    fields: [history_agents.email, history_agents.cost_center, history_agents.count_agents]
    relationship: many_to_one
    sql_on: ${zendesk_ticket_history.updater_id} = ${history_agents.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_ticket_agent_turnaround_time {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_agent_turnaround_time.ticket_id} = ${zendesk_ticket_history.ticket_id} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }


}

explore: zendesk_backlog {
  label: "Zendesk Backlog"
  description: "Zendesk ticket backlog by day. One table per day, make sure to group by date!"

  join: zendesk_ticket {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.id} = ${zendesk_backlog.ticket_id} ;;
  }

  join: zendesk_ticket_individual_tags {
    type: left_outer
    relationship: many_to_many
    sql_on: ${zendesk_ticket_individual_tags.id} = ${zendesk_backlog.ticket_id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.assignee_id
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.group_id
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_initials.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_metric_sets {
    view_label: "Zendesk Ticket Metric Sets"
    relationship: many_to_one
    sql_on: ${zendesk_backlog.ticket_id} = ${zendesk_ticket_metric_sets.ticket_id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_ticket_agent_turnaround_time {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_agent_turnaround_time.ticket_id} = ${zendesk_backlog.ticket_id} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }

}

explore: custops_snap_ads_rejections_log {
  label: "CO Snap Ads - Rejections Log"
  description: "Details all rejections used on Snap Ads tasks."

  join: top_rej {
    type: inner
    relationship: many_to_one
    sql_on: ${top_rej.rejection_type} = ${custops_snap_ads_rejections_log.rejection_type} ;;
  }
}

explore: zendesk_audit_ids {
  label: "Zendesk QA Audit IDs"

  always_filter: {
    filters: {
      field: updated_at
      value: "7 days ago for 7 days"
    }
  }

  join: custops_fte_vendor_users {
    type: left_outer
    sql_on: ${custops_fte_vendor_users.email} = ${zendesk_audit_ids.zendesk_agent_email} ;;
    relationship: many_to_one
  }

  join: zendesk_ticket {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_audit_ids.id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_agent.id} = ${zendesk_ticket.assignee_id} ;;
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_initials.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_metric_sets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_metric_sets.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.group_id} = ${zendesk_group.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_ticket_agent_turnaround_time {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_agent_turnaround_time.ticket_id} = ${zendesk_audit_ids.id} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }

}

explore: custops_ad_review_qa_combined {
  label: "CO Ad Review - Secondary QA"
}

explore: custops_support_qa_acn {
  label: "Business Support QA ACN"
}

explore: custops_odg_qa {
  label: "CO On-Demand G/L - QA Ids"
}

explore: business_support_chat_transcript {
  label: "Business Support Chat Transcript"
  description: "This Explore includes detailed chat trancsript for Business Support Chats"
  sql_always_where: ${zendesk_group.name} = "Business Support L1"
      OR ${zendesk_group.name} = "Business Support VL2"
      OR ${zendesk_group.name} = "Business Support L2"
      OR ${zendesk_group.name} = "Pixel Support"
      OR ${zendesk_group.name} = "Ad Product Quality" ;;

  always_filter: {
    filters: {
      field: zendesk_group.name
      value: "Business Support L1,
              Business Support VL2,
              Business Support L2,
              Pixel Support,
              Ad Product Quality"
    }

    filters: {
      field: chat_timestamp_utc_date
      value: "Last 2 Years"
    }
  }

  join: business_support_zendesk_chat {
    type: left_outer
    relationship: many_to_one
    sql_on: ${business_support_chat_transcript.chat_id} = ${business_support_zendesk_chat.chat_id} ;;
  }

  join: zendesk_ticket {
    relationship: many_to_one
    type: left_outer
    sql_on: ${business_support_zendesk_chat.zendesk_ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.group_id} = ${zendesk_group.id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.assignee_id} = ${zendesk_agent.id} ;;
  }

  join: zendesk_ticket_metric_sets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_metric_sets.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_initials.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_csat {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_csat.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: custops_fte_vendor_users {
    view_label: "Agent Roster"
    relationship: many_to_one
    type: left_outer
    sql_on: ${custops_fte_vendor_users.email} = ${zendesk_agent.email} ;;
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }


  always_join: [jira_intermidiate]
}

explore: zendesk_ticket_events {
  label: "Zendesk Ticket Events"

  always_filter: {
    filters: {
      field: partition_filter
      value: "7 days ago for 7 days"
    }
  }

  join: zendesk_ticket {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_events.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_metric_sets {
    view_label: "Zendesk Ticket Metric Sets"
    relationship: many_to_one
    sql_on: ${zendesk_ticket_events.ticket_id} = ${zendesk_ticket_metric_sets.ticket_id} ;;
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_events.ticket_id} = ${zendesk_ticket_initials.ticket_id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_events.updater_id} = ${zendesk_agent.id} ;;
  }

  join: custops_fte_vendor_users {
    type: left_outer
    view_label: "Agent Roster"
    relationship: many_to_one
    sql_on: ${zendesk_agent.email} = ${custops_fte_vendor_users.email} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.group_id} = ${zendesk_group.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_ticket_agent_turnaround_time {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_agent_turnaround_time.ticket_id} = ${zendesk_ticket_events.ticket_id} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: copi_triggers_automations {
    type: inner
    relationship: many_to_one
    sql_on: ${copi_triggers_automations.added_tags} = ${zendesk_ticket_events.a_t} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }

  join: leo_ramp_status {
    type: left_outer
    relationship: one_to_many
    sql_on: ${zendesk_agent.email} = ${leo_ramp_status.email} ;;
  }

  join: le_contacts_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.requester_id} = ${le_contacts_info.requester_id} ;;
  }

  join: ts_fte_roster_spreadsheet {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${ts_fte_roster_spreadsheet.email} = ${zendesk_ticket_events.agent_email} ;;
  }

}

explore: zendesk_ticket_history {
  label: "Zendesk Ticket History"

  join: zendesk_ticket {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_history.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_metric_sets {
    view_label: "Zendesk Ticket Metric Sets"
    relationship: many_to_one
    sql_on: ${zendesk_ticket_history.ticket_id} = ${zendesk_ticket_metric_sets.ticket_id} ;;
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_history.ticket_id} = ${zendesk_ticket_initials.ticket_id} ;;
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket_history.updater_id} = ${zendesk_agent.id} ;;
  }

  join: custops_fte_vendor_users {
    type: left_outer
    view_label: "Agent Roster"
    relationship: many_to_one
    sql_on: ${zendesk_agent.email} = ${custops_fte_vendor_users.email} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.group_id} = ${zendesk_group.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }


}

explore: prod_analytics_app {
  label: "App"
  persist_for: "24 hours"

  always_filter: {
    filters: {
      field: date_filter
      value: "2 days ago for 1 days"
    }
  }

  join: report_app_device_model {
    foreign_key: user_agent
    type: left_outer_each
  }
}

explore: community_support_qa_fte {
  label: "Community Support QA FTE"
}

explore: s2r_android_user {
  label: "In-App Contacts ❌ (Use Std SQL version ,this explore is not updated)"
  view_label: "In-App Contacts"

  always_filter: {
    filters: {
      field: datefilter
      value: "last 30 days"
    }

    filters: {
      field: shakeType
      value: "External"
    }

    filters: {
      field: source
      value: "Shake, InSetting, RatingInApp, InCanvas, InMap, InSnapPro"
    }
  }

  join: identity {
    type: inner
    sql_on: ${s2r_android_user.userId} = ${identity.ghost_user_id} ;;
    relationship: many_to_one
  }

  join: device_cluster_latest {
    type: left_outer
    relationship: many_to_one
    sql_on: ${s2r_android_user.deviceModel} = ${device_cluster_latest.device_model} ;;
  }

  join: persona {
    type: left_outer
    relationship: many_to_one
    sql_on: ${s2r_android_user.userId} = ${persona.ghost_user_id} ;;
  }

  join: customer_reports_abtest {
    type: inner
    relationship: many_to_one
    sql_on: ${s2r_android_user.reportId} = ${customer_reports_abtest.report_ids} ;;
  }
}

explore: custops_jira_snapshot {
  label: "CO - JIRA Snapshot"
}

explore: custops_jira {
  sql_always_where: ${project_key} IN ("ADL",  "ADS",  "APP",  "APPINS",  "ARP",  "AY",  "BM",  "BO",  "CAMEO",  "CAMERA",  "CLIENT",  "COE",  "CONTEXT",  "CONVO",  "COPM",  "CREATE",  "CUSTOPS",  "DAPL",  "DELI",  "DF",  "FF",  "GAME",  "IDT",  "IMPALA",  "INF",  "L10N",  "LOC",  "LOOK",  "MAPS",  "MDP",  "MEM",  "MONP",  "OPERA",  "ORCA", "OSP",  "PROFILE",  "PUSH",  "RPG",  "SCT",  "SEARCH",  "SEC",  "SFDC",  "SGS",  "SPT",  "STORIES",  "TOOLS",  "TR",  "ZD", "ADCL", "COM", "DP") ;;
}

explore: streaks_ticket {
  label: "Snapstreaks Tickets 🔥"

  join: streaks_ticket_initials {
    type: left_outer
    relationship: one_to_one
    sql_on: ${streaks_ticket_initials.ticket_id} = ${streaks_ticket.id} ;;
  }

  join: streaks_ticket_events {
    type: left_outer
    relationship: one_to_many
    sql_on: ${streaks_ticket_events.ticket_id} = ${streaks_ticket.id} ;;
  }

  join: streaks_ticket_metric_sets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${streaks_ticket_metric_sets.ticket_id} = ${streaks_ticket.id} ;;
  }
}

explore: zendesk_csat {
  label: "Zendesk Satisfaction Score"
}

explore: identity {
  label: "Identity dataset"
  view_label: "identity & Churn"
  fields: [ALL_FIELDS*, -identity.days_between_account_created_and_report_date]
}

explore: customer_reports_abtest {}

explore: preservation_v2 {
  label: "PI - Preservation V2"
  persist_for: "12 hours"

  always_filter: {
    filters: {
      field: date_filter
      value: "last 15 days"
    }
  }
}

explore: custops_support_zendesk_ticket_group_based_metrics {
  label: "CO Business Support - Zendesk Ticket Group Based Metrics"
}

explore: communityops_forecast_20211_2022 {
  label: "Community Ops Forecast 2021-22"
}

explore: ticketevents_ghostid {
label: "Ticket and App Events"
  always_filter: {
    filters: {
      field: partition_filter
      value: "last 7 days"
    }
    }

  join: login_events {
    type: left_outer
    relationship: one_to_many
    sql_on: ${ticketevents_ghostid.ghost_id} = ${login_events.ghost_user_id} ;;
    fields: []
  }

  join: zendesk_ticket {
    type: left_outer
    relationship: one_to_one
    sql_on: ${ticketevents_ghostid.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_group {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.group_id
  }

  join: zendesk_agent {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.assignee_id
  }

  join: zendesk_category {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.category
  }

  join: zendesk_subcategory {
    type: left_outer
    relationship: many_to_one
    foreign_key: zendesk_ticket.subcategory
  }

  join: zendesk_ticket_metric_sets {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_metric_sets.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_ticket_initials {
    type: left_outer
    relationship: one_to_one
    sql_on: ${zendesk_ticket_initials.ticket_id} = ${zendesk_ticket.id} ;;
  }

  join: zendesk_form {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_form.id} = ${zendesk_ticket.ticket_form_id} ;;
    fields: []
  }

  join: general_support_reason {
    type: left_outer
    relationship: many_to_one
    sql_on: ${general_support_reason.value} = ${zendesk_ticket.general_support_value_code} ;;
    fields: []
  }

  join: cross_join_max_create {
    type: cross
    relationship: many_to_one
  }

  join: leo_country_tag_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_country_tag} = ${leo_country_tag_view.value} ;;
    fields: []
  }

  join: leo_contact_reason_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_contact_reason_raw} = ${leo_contact_reason_view.value} ;;
    fields: []
  }

  join: leo_objection_or_error_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_objection_or_error_raw} = ${leo_objection_or_error_view.value} ;;
    fields: []
  }

  join: leo_case_type_view {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.leo_case_type_raw} = ${leo_case_type_view.value} ;;
    fields: []
  }

  join: custops_fte_vendor_users {
    view_label: "Agent Roster"
    relationship: many_to_one
    type: left_outer
    sql_on: ${custops_fte_vendor_users.email} = ${zendesk_agent.email} ;;
  }

  join: inclusive_region_lsql {
    type: left_outer
    sql_on: ${zendesk_ticket.country_h} = ${inclusive_region_lsql.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: country_info {
    type: left_outer
    relationship: many_to_one
    sql_on: ${country_info.isotwo_char_code} = zendesk_ticket.country_upper ;;
  }

  join: jira_intermidiate {
    type: left_outer
    relationship: many_to_one
    sql_on: ${zendesk_ticket.jira_ticket} = ${jira_intermidiate.key} ;;
    fields: []
  }

  join: zendesk_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${zendesk_custom_fields.ticket_id} ;;
    sql_where: ${zendesk_custom_fields.custom_field_name} = "Company Snap Kit" ;;
    fields: []
  }

  join: leo_ticket_custom_fields {
    type: inner
    relationship: one_to_many
    sql_on: ${zendesk_ticket.id} = ${leo_ticket_custom_fields.ticket_id} ;;
    fields: []
  }

  join: customer_ops_dau_agg {
    type: left_outer
    relationship: many_to_one
    fields: []
    sql_on: ${zendesk_ticket.country_upper} = ${customer_ops_dau_agg.country} AND ${zendesk_ticket.created_str} = ${customer_ops_dau_agg.ds} ;;
  }

}

explore: leo_ramp_status {
  label: "LEO Ramp Status"
}

explore: le_contacts_info {
  label: "LE Contact Info"

  #join: zendesk_ticket {
  #  type: left_outer
  #  relationship: one_to_many
  #  sql_on: ${le_contacts_info.requester_id} = ${zendesk_ticket.requester_id} ;;
  #}
}

#explore: leo_uk_bilat_requests {
#  label: "LEO UK Bilat Requests"

#  join: zendesk_agent {
#    type: left_outer
#    relationship: many_to_one
#    sql_on: ;;
#  }
#}

explore: page_session_interaction {
  persist_for: "2 hours"
  label: "Page Session Interaction"
  always_filter: {
    filters: {
      field: date_filter
      value: "last 90 days"
    }
    filters: {
      field: page_type
      value: "all"
    }
  }
}

#explore: login_events {}
