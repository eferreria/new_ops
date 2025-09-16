# most active contributor jbabra@snapchat.com
view: inclusive_region {
  sql_table_name: `sc-analytics.report_app.country_mapping` ;;

  dimension: country_code {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: continent {
    type: string
  }

  dimension: inclusive_region {
    type: string
  }



  }
