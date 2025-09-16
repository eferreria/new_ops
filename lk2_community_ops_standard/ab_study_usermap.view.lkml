view: ab_study_usermap {
  derived_table: {
    sql:
      WITH latest_available_ab_date AS (
        SELECT _TABLE_SUFFIX AS latest_date
        FROM `sc-portal.usermap_cumulative.{%parameter study_name%}__{%parameter segment%}__*`
        ORDER BY latest_date DESC
      )
      SELECT
        ghost_user_id,
        MAX("{%parameter study_name%}") as study_name,
        MAX(exp_id) as exp_id,
        TIMESTAMP_MILLIS(CAST(MIN(initial_timestamp) AS INT64)) as initial_timestamp
      FROM `sc-portal.usermap_cumulative.{%parameter study_name%}__{%parameter segment%}__*`
      WHERE _TABLE_SUFFIX = (SELECT latest_date FROM latest_available_ab_date LIMIT 1)
      GROUP BY 1
      ;;
  }

  dimension: exp_id {
    type: string
  }

  dimension: ghost_user_id {
    hidden:  yes
    type:  string
  }

  dimension: initial_timestamp {
    hidden:  yes
    type:  date
  }

  parameter: segment {
    type:  unquoted
    default_value: ""
    description: "AB Segment  e.g. IMAGE_SUPER_RESOLUTION_MODEL_DELIVERY_CONFIG__110664 -> 110664"
  }

  # We need this to enable joins
  parameter: study_name {
    type:  unquoted
    description: "AB Study Name e.g. IMAGE_SUPER_RESOLUTION_MODEL_DELIVERY_CONFIG__110664 -> IMAGE_SUPER_RESOLUTION_MODEL_DELIVERY_CONFIG__110664"
  }
}
