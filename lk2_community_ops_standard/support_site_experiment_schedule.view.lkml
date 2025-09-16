view: support_site_experiment_schedule {
  view_label: "Experiment Schedule"
  derived_table: {

    sql:  SELECT *
        FROM
        `businesshelpcenteranalytics.experiments.schedule`
      ;;
  }

  dimension: hour_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.hour_pst ;;
    label: "Hour ID"
  }

  dimension: theme_type {
    type: string
    sql: ${TABLE}.theme_type ;;
    label: "Theme Type"
  }

  dimension: theme_name {
    type: string
    sql: ${TABLE}.theme_name ;;
    label: "Theme Name"
  }

  dimension: experiment_name {
    type: string
    sql: ${TABLE}.experiment_name ;;
    label: "Experiment Name"
  }

measure: count_hours {
  type: count_distinct
  sql: ${TABLE}.hour_pst ;;
}

}
