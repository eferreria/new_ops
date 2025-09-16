view: reports_labeled_data {
  derived_table: {
    sql:
SELECT
  u.ghost_id AS user_id,
  p.*
FROM (
  SELECT
    metadata.*,
    moderation.is_ncv,
    moderation.is_suggestive,
    moderation.is_acv,
    moderation.is_nisc
  FROM (
    SELECT
      *
    FROM (
      SELECT
        reporterUserId,
        reportedUserId,
        feature,
        isIgnored,
        timestamp,
        ROW_NUMBER() OVER (PARTITION BY reporterUserId, DATE(timestamp)
        ORDER BY
          timestamp DESC) AS Rownumber
      FROM
        `snap-report-processor.shepherd_production.report_metadata`
      WHERE
        DATE(timestamp) > '2023-05-01')
    WHERE
      Rownumber = 1 ) metadata
  LEFT JOIN (
    SELECT
      user_id,
      snap_id,
      flags,
      moderated_timestamp,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'nobody_can_view') AS is_ncv,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'is_suggestive') AS is_suggestive,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'anyone_can_view') AS is_acv,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'nobody_in_sensitive_country_can_view') AS is_nisc
    FROM (
      SELECT
        user_id,
        snap_id,
        flags,
        moderated_timestamp
      FROM (
        SELECT
          user_id,
          snap_id,
          flags,
          moderated_timestamp,
          ROW_NUMBER() OVER (PARTITION BY user_id, DATE(moderated_timestamp)
          ORDER BY
            moderated_timestamp DESC) AS Rownumber
        FROM
          `context-prod.moderation_30d.publisher_story_moderation_*`,
          UNNEST(reporter_ids) AS user_id)
      WHERE
        Rownumber = 1)
    UNION ALL
    SELECT
      user_id,
      snap_id,
      flags,
      moderated_timestamp,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'nobody_can_view') AS is_ncv,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'is_suggestive') AS is_suggestive,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'anyone_can_view') AS is_acv,
      REGEXP_CONTAINS(ARRAY_TO_STRING(flags, ','), 'nobody_in_sensitive_country_can_view') AS is_nisc
    FROM (
      SELECT
        user_id,
        snap_id,
        flags,
        moderated_timestamp
      FROM (
        SELECT
          report.reporter_user_id AS user_id,
          snap_id,
          flags,
          moderated_timestamp,
          ROW_NUMBER() OVER (PARTITION BY report.reporter_user_id, DATE(moderated_timestamp)
          ORDER BY
            moderated_timestamp DESC) AS Rownumber
        FROM
          `context-prod.moderation_30d.reported_discover_ugc_snaps_moderation_result_*`)
      WHERE
        Rownumber = 1)) moderation
  ON
    metadata.reporterUserId = moderation.user_id
    AND ABS(TIMESTAMP_DIFF(moderation.moderated_timestamp, metadata.timestamp, HOUR)) <= 24) p
JOIN
  `sc-mjolnir.enigma.user_map_v2` u
ON
  u.user_id = p.reporterUserId
    ;;
  }

  ## dimensions

  dimension: user_id {
    sql: ${TABLE}.user_id ;;
    type: string
    group_label: "IDs"
    label: "Ghost ID"
  }

  dimension_group: event {
    label: "Event UTC"
    type: time
    sql: ${TABLE}.timestamp ;;
    convert_tz: no
  }

  dimension: is_ignored {
    type: yesno
    sql: ${TABLE}.isIgnored ;;
  }

  dimension: is_ncv {
    type: yesno
    sql: ${TABLE}.is_ncv ;;
  }

  dimension: is_acv {
    type: yesno
    sql: ${TABLE}.is_acv ;;
  }

  dimension: is_suggestive {
    type: yesno
    sql: ${TABLE}.is_suggestive ;;
  }

  dimension: is_nisc {
    type: yesno
    sql: ${TABLE}.is_nisc ;;
  }

  dimension: feature {
    type: string
    sql: ${TABLE}.feature ;;
  }
}
