# most active contributor jbabra@snapchat.com
view: device_cluster_latest_stdsql {

  derived_table: {

    sql:
    select
        LOWER(device_model) as device_model,
        cluster,
        common_name,
        branding,
        platform
 FROM `sc-analytics.report_quest_performance.device_cluster_2*`
WHERE _TABLE_SUFFIX = (select max(_TABLE_SUFFIX) from `sc-analytics.report_quest_performance.device_cluster_2*`)
 ;;
  }

  dimension:device_model  {
    description: "iphone11,2"
    label: "Device Model"
    type: string
    case_sensitive: no
    primary_key: yes
  }

  dimension:cluster  {
    description: "cluster - 0, 1, ..6"
    type: number
  }

  dimension:common_name  {
    description: "iphone X or Galaxy S10"
    type: string
    case_sensitive: no
  }

  dimension: branding {
    description: "phone brand- apple, samsung"
    type: string
    case_sensitive: no
  }

  dimension: platform {
    description: "ios or android"
    type: string
    case_sensitive: no

  }

}
