connection: "svc-looker-community-ops-standard"
include: "//hub_looker_production/access_grant.lkml"
include: "//hub_looker_production/common/common_blizzard.view.lkml"
include: "lk2_community_ops_standard/*.view.lkml"
include: "dashboards/standard/*.dashboard"
include: "view_files_with_out_target/*.view.lkml"
include: "//hub_looker_production/community_ops/zendesk_agent_ssql.view.lkml"
include: "//hub_looker_production/community_ops/inapp_abuse_reporting_taskhistories.view.lkml"
include: "//hub_looker_production/community_ops/inapp_abuse_reporting_queues.view.lkml"
include: "//hub_looker_production/platform_integrity/customer_ops_dau_agg.view.lkml"
include: "//hub_looker_production/community_ops/inapp_abuse_reporting_tasks.view.lkml"
include: "//hub_looker_production/platform_integrity/pi_leo_fte_zd_qa_scores.view.lkml"
label: "Community Ops lk2"

access_grant: can_view_merlin_data {
  user_attribute: email
  allowed_values: ["aaltschuler@snapchat.com", "aantony@snapchat.com", "abelskikh@snapchat.com", "achavdaroff@snapchat.com", "adatta@snapchat.com", "aedelsburg@snapchat.com", "agangadharaiah@snapchat.com", "akumar4@snapchat.com", "alexander.osborne@snapchat.com", "atupper@snapchat.com", "amarinenko@snapchat.com", "amashrabov@snapchat.com", "amikhailiuk@snapchat.com", "abenharosh@snapchat.com", "amourtzouni@snapchat.com", "aplisner@snapchat.com", "atodi@snapchat.com", "azakharov2@snapchat.com", "benjamin.hollis@snapchat.com", "bhobbs@snapchat.com", "bkotsopoulos@snapchat.com", "blu2@snapchat.com", "david.boyle@snapchat.com", "bpandya@snapchat.com", "brandon.francis@snapchat.com", "brooke.winn@snapchat.com", "cburckle@snapchat.com", "cchan@snapchat.com", "cmelbye@snapchat.com", "christie.heikkinen@snapchat.com", "cmourkogiannis@snapchat.com", "ctaylor3@snapchat.com", "cyang4@snapchat.com", "damitay@snapchat.com", "dmoreno@snapchat.com", "drakhamimov@snapchat.com", "daniel.jonik@snapchat.com", "dcaslin@snapchat.com", "dishchenko@snapchat.com", "dmatov@snapchat.com", "dshkolnikov@snapchat.com", "eclaudet@snapchat.com", "edwin.jacintobringuez@snapchat.com", "fruttledge@snapchat.com", "gmartinrichter@snapchat.com", "gtkachenko@snapchat.com", "gmoura@snapchat.com", "hbaker@snapchat.com", "hgong@snapchat.com",
"hhuang@snapchat.com", "ibabanin@snapchat.com", "jack.brody@snapchat.com", "jacob.andreou@snapchat.com", "jrojas@snapchat.com", "jami.holtzclaw@snapchat.com", "jbeauchere@snapchat.com", "jbrewer@snapchat.com", "jcatalano@snapchat.com", "jboniakowski@snapchat.com", "jeremy.voss@snapchat.com", "jkrzemien@snapchat.com", "joshua.siegel@snapchat.com", "jschumacher@snapchat.com", "jstout@snapchat.com", "kderkits@snapchat.com", "kent.tam@snapchat.com", "kgiltz@snapchat.com", "kvantklooster@snapchat.com", "kwainscott@snapchat.com", "kxiao@snapchat.com", "lbook@snapchat.com", "maichi.tran@snapchat.com", "matthew.beebe@snapchat.com", "mchen6@snapchat.com", "mcherneff@snapchat.com", "mcunningham2@snapchat.com", "mehrdad.jahangiri@snapchat.com", "mjackson3@snapchat.com", "mli@snapchat.com", "mqian@snapchat.com", "nima.khajehnouri@snapchat.com", "nona.farahnik@snapchat.com", "ovais.khan@snapchat.com", "peter.duong@snapchat.com", "psavchenkov@snapchat.com", "rachel.racusen@snapchat.com", "rharper@snapchat.com", "rhochhauser@snapchat.com", "rhuang3@snapchat.com", "rmihairoman@snapchat.com", "rsingh7@snapchat.com", "rsiniscalchi@snapchat.com", "rstack@snapchat.com", "rudani@snapchat.com", "samuel.young@snapchat.com", "sghayyur@snapchat.com", "spabbiti@snapchat.com", "ssmetanin@snapchat.com", "subhash.sankuratripati@snapchat.com",
"subra@snapchat.com", "tdesai@snapchat.com", "tgao@snapchat.com", "thickler@snapchat.com", "tmotwani@snapchat.com", "tzhou@snapchat.com", "vinay.kola@snapchat.com", "waiho.au@snapchat.com", "wchen6@snapchat.com", "william.mulligan@snapchat.com", "xfang@snapchat.com", "xiaohan.zhao@snapchat.com", "xin.liu@snapchat.com", "xzhou@snapchat.com", "ybai2@snapchat.com", "ykang@snapchat.com", "yluo2@snapchat.com", "yshi@snapchat.com", "oolatunji@snapchat.com", "jsager@snapchat.com", "iramadan@snapchat.com", "aliu4@snapchat.com", "elamb@snapchat.com", "aliu5@snapchat.com", "kheinze@snapchat.com", "cortiz@snapchat.com", "efeng@snapchat.com", "adixoncalliste@snapchat.com", "aevans5@snapchat.com", "fsassanelli@snapchat.com", "awong4@snapchat.com", "cdublin@snapchat.com", "jderamusbrown@snapchat.com", "iarbisser@snapchat.com", "kkim2@snapchat.com", "scalatrava@snapchat.com", "jjones@snapchat.com", "jack.agopian@snapchat.com", "obystrova2@snapchat.com"]
## this parameter gates access to conversation fields in in_app_reports_stdsql view; https://docs.google.com/spreadsheets/d/1dKLOp2q1ZfymYvo138xL388eJhPaEkOEY3zt4IqGE_8/edit?usp=sharing
}

week_start_day: monday     # DO NOT CHANGE

explore: community_help_center {
  label: "Snapchat Support Site"
  always_filter: {
    filters: [date_filter: "30 days", hits.date_filter: "30 days"]
  }
  join: hits {
    relationship: one_to_one
    type: left_outer
    sql_on: ${community_help_center.hits_pk} = ${hits.id} ;;
  }

  # join: chc_support_site_csat {
  #   view_label: "Support Site CSAT"
  #   relationship: many_to_many
  #   type: full_outer
  #   sql_on: ${community_help_center.pk} = ${chc_support_site_csat.pk} ;;
  # }

  join: localetolanguage {
    relationship: one_to_many
    sql_on: ${localetolanguage.locale} = ${community_help_center.language_code} ;;
    fields: []
  }

  join: localetolanguage2 {
    relationship: one_to_many
    sql_on: ${localetolanguage2.locale} = ${hits.website_language_code} ;;
    fields: []
  }

  join: chc_timeonpage {
    view_label: "Time on Page"
    relationship: one_to_one
    type: left_outer
    sql_on: ${community_help_center.pagepath_raw} = ${chc_timeonpage.Page} AND ${community_help_center.thedate} = ${chc_timeonpage.thedate} ;;
  }

  join: chc_orderofpages {
    view_label: "Page Order"
    relationship: one_to_many
    type: left_outer
    sql_on: ${community_help_center.pk} = ${chc_orderofpages.SessionIdentity} ;;
  }

  join: chc_nextprev {
    view_label: "Page Sequence"
    relationship: one_to_many
    type: left_outer
    sql_on: ${community_help_center.pk} = ${chc_nextprev.SessionIdentity} ;;
  }

  join: chc_blurb {
    relationship: one_to_many
    type: left_outer
    sql_on: ${hits.event_Label} = ${chc_blurb.blurb_id} ;;
    fields: []
  }

##  join: search_console {
##    relationship: many_to_many
##    type: full_outer
##    sql_on: ${hits.host_plus_landing_date} = ${search_console.page_plus_date} ;;
##    sql_where: ${search_console.site_url} = "https://support.snapchat.com/" ;;
##  }

  join: support_site_experiment_schedule {
    view_label: "Experiments Schedule"
    relationship: many_to_one
    type: left_outer
    sql_on: ${community_help_center.date_hour} = ${support_site_experiment_schedule.hour_id} ;;
  }

  join: zendesk_guide_metadata {
    view_label: "Zendesk Guide Metadata"
    relationship: many_to_one
    type: left_outer
    sql_on: ${hits.page_id} = ${zendesk_guide_metadata.page_id} ;;
  }
}

explore: chc_service_errors {
  label: "Support Site Errors"
  always_filter: {
    filters: [date_filter: "30 days"]
  }

}

explore: appinstall_matched_events {
  label: "App Attribution 🎯"

  always_filter: {
    filters: {
      field: date_filter
      value: "Last 7 Days"
    }
  }

  join: attribution_events {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(appinstall_matched_events.attribution_events) as attribution_events ;;
  }

  join: mobile_app {
    relationship: one_to_many
    type: left_outer
    sql_on: ${appinstall_matched_events.snapappid} = ${mobile_app.id} ;;
  }
}

explore: inapp_abuse_reporting_taskhistories {
  label: "In-App Abuse Task Histories"
  view_label: "Task Histories"
  persist_for: "30 minutes"

  join: inapp_abuse_reporting_queues {
    view_label: "Queues Names"
    type: inner
    relationship: many_to_one
    foreign_key: inapp_abuse_reporting_taskhistories.queue
  }

  join: inapp_abuse_reporting_tasks {
    view_label: "Tasks"
    type: inner
    relationship: one_to_many
    foreign_key: inapp_abuse_reporting_taskhistories.task_id
  }

  always_filter: {
    filters: {
      field: inapp_abuse_reporting_taskhistories.th_created_at
      value: "14 days ago for 14 days"
    }
    filters: {
      field: inapp_abuse_reporting_tasks.t_created_at
      value: "7 days ago for 7 days"
    }
    filters:  {
      field: inapp_abuse_reporting_taskhistories.action_filter
      value: "-CHECKOUT,-GET,-REAP,-RETURN,-REPRIORITIZE"
    }
  }
}

explore: twitter_sprinklr_archive {
  join: twitter_case_count_agent {
    type: left_outer
    relationship: one_to_many
    sql_on: ${twitter_sprinklr_archive.pk} = ${twitter_case_count_agent.pk} ;;
  }

  join: twitter_macro_usage {
    type: left_outer
    relationship: one_to_many
    sql_on: ${twitter_sprinklr_archive.pk} = ${twitter_macro_usage.pk} ;;
  }

  join: twitter_subcategory {
    type: left_outer
    relationship: one_to_many
    sql_on: ${twitter_sprinklr_archive.pk} = ${twitter_subcategory.pk} ;;
  }
}

explore: inapp_abuse_reporting_tasks {
  label: "In-App Abuse Reporting"
  view_label: "Reports"
  persist_for: "30 minutes"

  join: inapp_abuse_reporting_queues {
    view_label: "Queues Names"
    type: inner
    relationship: many_to_one
    foreign_key: queue_id
  }

  join: inapp_abuse_reporting_taskhistories {
    view_label: "Task Histories"
    type: left_outer
    relationship: many_to_one
    sql_on: ${inapp_abuse_reporting_tasks.task_id} = ${inapp_abuse_reporting_taskhistories.task_id} ;;
  }

  always_filter: {
    filters: {
      field: inapp_abuse_reporting_tasks.t_created_at
      value: "7 days ago for 7 days"
    }
    filters: {
      field: inapp_abuse_reporting_taskhistories.th_created_at
      value: "7 days ago for 7 days"
    }
  }
}

explore: social_cases {
  label: "Social Support [Twitter]"

  join: social_agent {
    relationship: many_to_one
    type: left_outer
    sql_on: ${social_cases.OwnerId} = ${social_agent.id} ;;
  }

  join: vendor_roster_ssql {
    relationship: one_to_one
    type: left_outer
    sql_on: ${social_agent.email} = ${vendor_roster_ssql.email} ;;
  }

##  join: social_persona { --removed social_persona since this data is no longer available in Sprinklr
##    relationship: many_to_one
##    type: left_outer
##    sql_on: ${social_cases.contact_id} = ${social_persona.parent_id} ;;
##  }

  join: social_post {
    relationship: one_to_many
    type: left_outer
    sql_on: ${social_cases.id} = ${social_post.parent_id} ;;
  }

  join: social_events {
    relationship: one_to_many
    type: left_outer
    sql_on: ${social_cases.id} = ${social_events.case_id} ;;
  }

  join: social_agentwork {
    relationship: one_to_many
    type: left_outer
    sql_on: ${social_cases.id} = ${social_agentwork.work_item_id}   ;;
  }
}

explore: in_app_support_customer {
  label: "In-App Support Customer Actions"
  always_filter: {
    filters: [in_app_support_customer.date_filter: "1 month ago", in_app_support_customer.event_name: "-EMPTY"]
  }
}

explore: social_agent {
  join: social_agentwork {
    relationship: one_to_many
    type: full_outer
    sql_on: ${social_agent.id} = ${social_agentwork.user_id} ;;
  }

  join: vendor_roster_ssql {
    relationship: one_to_one
    type: left_outer
    sql_on: ${social_agent.email} = ${vendor_roster_ssql.email} ;;
  }
}

explore: in_app_reports_stdsql {
  label: "In-App Contacts📱 (Std SQL)"
  view_label: "In App Contacts"

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
      value: "Shake, InSetting, RatingInApp, InCanvas, InMap, InSnapPro, CallFeedback"
    }
  }

  join: in_app_reports_stdsql__ab_tests {
    view_label: "Real Time ABs"
    sql: LEFT JOIN UNNEST(
      ARRAY(
      SELECT AS STRUCT
        JSON_VALUE(item, "$.name") AS Segment,
        CONCAT(JSON_VALUE(item, "$.name"), "(", JSON_VALUE(item, "$.value"), ")") AS ExperimentID
      FROM UNNEST(JSON_QUERY_ARRAY(JSON_EXTRACT(preferenceInfo, '$.experiment'))) AS item)
      ) as in_app_reports_stdsql__ab_tests ;;
    relationship: one_to_many
  }

  join: ab_study_usermap {
    type: inner
    sql_on: ${in_app_reports_stdsql.userId} = ${ab_study_usermap.ghost_user_id} AND ${in_app_reports_stdsql.event_date} >= ${ab_study_usermap.initial_timestamp} ;;
    relationship: many_to_one
  }

  join: latest_appversions {
    type: left_outer
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.appVersion} = ${latest_appversions.app_version_full} ;;
  }

  join: ios_top3 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.appVersion_Primary} = ${ios_top3.top_3_ios_version} ;;
    fields: []
  }

  join: android_top3 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.appVersion_Primary} = ${android_top3.top_3_android_version} ;;
    fields: []
  }

  join: snap_pro_user_meta {
    type: full_outer
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.userId} = ${snap_pro_user_meta.ghost_user_id} ;;
  }

  join: persona_v3 {
    type: left_outer
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.userId} = ${persona_v3.ghost_user_id} ;;
  }

  join: games_first_source {
    type: left_outer
    relationship: many_to_many
    sql_on: ${games_first_source.ghost_user_id} = ${in_app_reports_stdsql.userId} ;;
    fields: []
  }

  join: identity_ssql {
    view_label: "Identity"
    type: inner
    sql_on: ${in_app_reports_stdsql.userId} = ${identity_ssql.ghost_user_id} ;;
    relationship: many_to_one
  }

  join: inclusive_region {
    type: left_outer
    sql_on: ${in_app_reports_stdsql.country} = ${inclusive_region.country_code} ;;
    relationship: many_to_many
    fields: []
  }

  join: device_cluster_latest_stdsql {
    type: left_outer
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.deviceModel} = ${device_cluster_latest_stdsql.device_model} ;;
    view_label: "Device Cluster"
  }

  join: snapchat_plus_subs {
    view_label: "Snapchat+"
    type: left_outer
    sql_on: ${in_app_reports_stdsql.userId} = ${snapchat_plus_subs.ghost_id} ;;
    relationship: many_to_one
    sql_where: ${in_app_reports_stdsql.event_date} >= "2022-06-29" ;;
  }

  join: premium_feature_enrollment {
    type: inner
    relationship: many_to_many
    sql_on: ${in_app_reports_stdsql.userId} = ${premium_feature_enrollment.ghost_id} AND ${in_app_reports_stdsql.event_string} = ${premium_feature_enrollment.event_string}  ;;
    sql_where: ${in_app_reports_stdsql.event_date} >= "2022-06-29" ;;

  }

  join: reports_labeled_data {
    view_label: "Label Data"
    type: inner
    relationship: many_to_one
    sql_on: ${in_app_reports_stdsql.userId} = ${reports_labeled_data.user_id} AND  ABS(TIMESTAMP_DIFF(${in_app_reports_stdsql.event_date}, ${reports_labeled_data.event_date}, HOUR)) <= 24 ;;
  }

  join: device_model_dau_distribution {
    view_label: "Device Model DAU Distribution"
    type: left_outer
    relationship: many_to_many
    sql_on:  concat(lower(${in_app_reports_stdsql.deviceModel}), '-',${in_app_reports_stdsql.event_date}) =  ${device_model_dau_distribution.device_model_dau_date} ;;
  }

  join: us_13_17_ios_dau_device_model {
    view_label: "US 13-17 IOS DAU Device Model Distribution"
    type: left_outer
    relationship: many_to_many
    sql_on:  concat(lower(${in_app_reports_stdsql.deviceModel}), '-',${in_app_reports_stdsql.event_date}) =  ${us_13_17_ios_dau_device_model.device_model_dau_date} ;;
  }

  # join: creator_profile {
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${in_app_reports_stdsql.userId} = ${creator_profile.creator_ghost_user_id} ;;
  # }
}

explore: device_model_dau_distribution {
  label: "Device Model DAU Distribution"
  always_filter: {
    filters: {
      field: datefilter
      value: "Last 7 Days"
    }
  }
}

explore: us_13_17_ios_dau_device_model {
  label: "US 13-17 IOS DAU Device Model Distribution"
  always_filter: {
    filters: {
      field: datefilter
      value: "Last 7 Days"
    }
  }
}

explore: snap_pro_user_meta {}

explore: jira_history {
  label: "Jira History"
}

explore: snap_pro_meta_cumulative {
  always_filter: {
    filters: {
      field: date_filter
      value: "Last 7 Days"
    }
  }
}

explore: snapchat_plus_subs {}

explore: premium_feature_enrollment {}

# explore: cognac_games_daily {
#   label: "Ice Cream Flavors Daily"
#   persist_for: "24 hours"

#   join: in_app_reports_stdsql {
#     type: full_outer
#     relationship: many_to_one
#     sql_on: ${cognac_games_daily.ghost_user_id} = ${in_app_reports_stdsql.userId} ;;
#   }

#   join: inclusive_region {
#     type: left_outer
#     sql_on: ${in_app_reports_stdsql.country} = ${inclusive_region.country_code} ;;
#     relationship: many_to_many
#     fields: []
#   }

#   join: games_first_source {
#     type: left_outer
#     relationship: many_to_many
#     sql_on: ${games_first_source.ghost_user_id} = ${in_app_reports_stdsql.userId} ;;
#     fields: []
#   }

# } not accurate

explore: zendesk_guide_metadata {
  label: "Zendesk Guide Metadata"
  description: "Article, Section, and Category metadata for Snapchat Support Site"

}
