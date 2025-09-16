# most active contributor jbabra@snapchat.com
view: mobile_app {
  derived_table: {
    sql:
         SELECT *
        FROM  `sc-analytics.prod_metadata_mpp.mobile_app_*`
        WHERE {% condition date_filter %} TIMESTAMP(PARSE_DATE('%E4Y%m%d', _TABLE_SUFFIX)) {% endcondition %}
    ;;
  }

  filter: date_filter {
    label: "Table Filter"
    description: "Adding this filter will only query specific tables in the YYYYMMDD format. Not adding this filter will query all tables, all time"
    type: date
    convert_tz: no
  }

  dimension: id {
    sql: ${TABLE}.id ;;
    label: "Snap App ID"
    type: string
  }

  dimension_group: updated_at {
    sql: ${TABLE}.updated_at ;;
    timeframes: [date, week, month,quarter, year]
    type: time
  }

  dimension_group: created_at {
    sql: ${TABLE}.created_at ;;
    timeframes: [date, week, month,quarter, year]
    type: time
  }

  dimension: name {
    sql: ${TABLE}.name ;;
    type: string
  }

  dimension: container_id {
    sql: ${TABLE}.container_id ;;
    type: string
  }

  dimension: visible_to_string {
    sql: ${TABLE}.visible_to_string ;;
    type: string
  }


}
