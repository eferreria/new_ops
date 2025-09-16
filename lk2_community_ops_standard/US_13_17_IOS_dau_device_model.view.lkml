view: us_13_17_ios_dau_device_model {
  derived_table: {
    sql:

select
      a.device_model,
      a.event_date,
      count(distinct a.ghost_user_id) as dau
from
      (select
                    device_model,
                    event_date,
                    ghost_user_id
            FROM `sc-analytics.report_app.dau_user_device_model_top_*`
            WHERE _TABLE_SUFFIX between FORMAT_TIMESTAMP("%Y%m%d",{% date_start datefilter %}) AND FORMAT_TIMESTAMP("%Y%m%d",timestamp_sub(IFNULL({% date_end datefilter %},CURRENT_TIMESTAMP()), interval 1 day))
                  and app_open_count > 0
      ) a
join
      (
      select
            ghost_user_id,
            event_date
      from
            `sc-analytics.report_app.attributed_duc_*`
      where
            app_application_open_count > 0
            and lower(country) = 'us'
            and ios = 1
            and reported_age_bucket = '13-17'
            and _table_suffix between FORMAT_TIMESTAMP("%Y%m%d",{% date_start datefilter %}) AND FORMAT_TIMESTAMP("%Y%m%d",timestamp_sub(IFNULL({% date_end datefilter %},CURRENT_TIMESTAMP()), interval 1 day))
      ) b
on date(a.event_date) = date(b.event_date)
and a.ghost_user_id = b.ghost_user_id
group by 1,2
       ;;
  }# # You can specify the table name if it's different from the view name:

  filter: datefilter {
    type: date
  }

  dimension: device_model  {
    description: "Device Model"
    label: "Device Model"
    type: string
    case_sensitive: no
    sql: ${TABLE}.device_model ;;
  }


  dimension: event_date {
    label: "Event Date"
    type: date
    sql: ${TABLE}.event_date;;
    convert_tz: no
  }

  dimension: device_model_dau_date{
    label: "Device Model and Date"
    type:  string
    primary_key: yes
    sql: CONCAT(lower(${TABLE}.device_model), '-',date(${TABLE}.event_date)) ;;
  }

  # measure: dau  {
  #   type: sum
  #   sql: ${TABLE}.dau ;;
  # }

  measure: dau_average  {
    type: average
    sql: ${TABLE}.dau ;;
  }

 # measure: dau_average_rank  {
 #   type: average
 #   value_format: "0"
 #   sql: ${TABLE}.dau_rank ;;
 # }

  # measure: daily_average_dau  {
  #   type: average
  #   sql: ${TABLE}.dau ;;
  # }
}
