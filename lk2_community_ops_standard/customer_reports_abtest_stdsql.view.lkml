# most active contributor jbabra@snapchat.com
view: customer_reports_abtest_stdsql {

  view_label: "Customer A/B Test"
  derived_table: {
    sql:
    SELECT *
    FROM `sc-analytics.report_user.customer_reports_abtest__agg_by_user__*`
              ;;
  }

  ##### Dimensions #####

  dimension: ghost_user_id {
    type: string
    label: "Ghost Id"
    sql: ${TABLE}.ghost_user_id ;;
    primary_key: yes
  }

  dimension: exps {
    type: string
    label: "Experiments"
    sql: ${TABLE}.exps ;;
  }

  dimension: report_ids {
    type: string
    label: "Report ID"
    sql: ${TABLE}.reports ;;
  }

  ##### Measures #####

  dimension: number_of_experiments {
    type: number
    label: "Number of Experiments"
    sql: ${TABLE}.num_exps ;;
  }

  dimension: number_of_reports {
    type: number
    label: "Number of Reports"
    sql: ${TABLE}.num_reports ;;
  }


  }
