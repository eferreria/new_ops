view: custops_appeal_users {
 derived_table: {
  interval_trigger: "24 hours"
  sql:

SELECT
  appeals.ghostId AS ghost_user_id,
  appeals.taskId AS appeal_taskId,
  appeals.created_date AS appeal_created_date,
  appeals.updated_at AS appeal_updated_date,
  CASE
    WHEN finals.reason IN ('TS_INCORRECT_ENFORCEMENT', 'TS_ADDITIONAL_CONTEXT', 'TS_MISC_OTHER_APPROVE') THEN 'APPROVED'
    WHEN finals.reason IS NOT NULL THEN 'DENIED'
    ELSE 'OPEN'
  END AS appeal_status,
  finals.reason AS appeal_result,
  ohsnap.finalActionAt,
  ohsnap.finalAction,
  ohsnap.enforcement_reason
FROM (
  SELECT
    td.id AS taskId,
    mu.reporterGhostId AS ghostId,
    td.createdAt AS created_date,
    td.updated_at
  FROM
    [sc-analytics:report_customer_ops.taskservice_tasks_distinct] AS td
  JOIN
    (SELECT
      *
    FROM TABLE_DATE_RANGE(
      [sc-analytics:report_customer_ops.taskservice_iaa_mapped_users_],
      TIMESTAMP(DATE_ADD(CURRENT_DATE(), -5, "DAY")),
      TIMESTAMP(DATE_ADD(CURRENT_DATE(), -1, "DAY"))
      )
    )
      AS mu
  ON
    mu.id = td.id
  WHERE
    td.workflow LIKE '%Appeal%'
    AND DATE(td.createdAt) >= DATE_ADD(CURRENT_DATE(), -185, "DAY")
    AND REGEXP_EXTRACT(STRING(CURRENT_TIMESTAMP(), 'UTC'), r'^([0-9]{4}[0-9]{2}[0-9]{2})') = REGEXP_EXTRACT(STRING(CURRENT_TIMESTAMP(), 'UTC'), r'^([0-9]{4}[0-9]{2}[0-9]{2})')
) AS appeals
LEFT JOIN (
  SELECT
    iaa.reportedGhostId,
    iaa.finalActionAt,
    iaa.finalAction,
    iaa.enforcement_reason
  FROM (
    SELECT
      iaa.reportedGhostId,
      iaa.finalActionAt,
      iaa.finalAction,
      iaa.enforcement_reason,
      RANK() OVER (PARTITION BY iaa.reportedGhostId ORDER BY iaa.finalActionAt ASC) AS rn
    FROM
      [sc-analytics:report_customer_ops.taskservice_iaa_keyevents] AS iaa
    WHERE
      iaa.tierType = 'Overall'
      AND iaa.enforcementFinal = 1
      AND (iaa.finalAction LIKE '%lock_user_v2%' OR iaa.finalAction LIKE '%delete_user%')
      AND DATE(iaa.finalActionAt) >= DATE_ADD(CURRENT_DATE(), -185, "DAY")
  ) AS ranked
  WHERE rn = 1
) AS ohsnap
ON ohsnap.reportedGhostId = appeals.ghostId
LEFT JOIN
  [sc-analytics:report_customer_ops.taskservice_taskfinals] AS finals
ON appeals.taskId = finals.taskId;;

  # persist_for: "24 hours"
}

  dimension: ghost_user_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.ghost_user_id ;;
    label: "Ghost ID"
    hidden: yes
  }

  dimension: appeal_taskId {
    sql: ${TABLE}.appeal_taskId ;;
    type: string
  }

  dimension: appeal_created_date {
    sql: ${TABLE}.appeal_created_date ;;
    type: date
  }

  dimension: appeal_updated_date {
    sql: ${TABLE}.appeal_updated_date ;;
    type: date
  }

# dimension: ghost_id {
#   type: string
#   sql: ${TABLE}.ghostId ;;
# }

}
