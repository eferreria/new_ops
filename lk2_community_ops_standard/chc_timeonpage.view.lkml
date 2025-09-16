# most active contributor jbabra@snapchat.com
view: chc_timeonpage {

derived_table: {
  sql:

      SELECT
  thedate,
  Page,
  SUM(TIMEOnPage) AS TimeOnPage,
  SUM(Exits) AS Exits,
  SUM(Pageviews) AS Pageviews,
  safe_divide(SUM(TIMEOnPage), (SUM(Pageviews)-SUM(Exits))) AS Avg_Time_On_Page
FROM (
  SELECT
    Sessions,
    Page,
    Pageviews,
    thedate,
    CASE
      WHEN exit =TRUE THEN LastInteraction-hitTime
    ELSE  LEAD(hitTime) OVER (PARTITION BY Sessions ORDER BY hitseq) - hitTime  END   AS TimeOnPage,
  Exits

  FROM (
    SELECT
      CASE
        WHEN totals.visits=1 THEN CONCAT( fullvisitorid,"-",CAST(visitNumber AS string),"-",CAST(visitStartTime AS string))  END AS Sessions,

      hits.Page.pagePath AS Page,
      hits.IsExit AS exit,

      CAST(PARSE_DATE("%Y%m%d", date) AS DATE) as thedate,

      CASE
        WHEN hits.Isexit =TRUE THEN 1
      ELSE
      0
    END
      AS Exits,

      hits.hitNUmber AS hitSeq,
      hits.Type AS hitType,
      hits.time/1000 AS hitTime,

      CASE
        WHEN type="PAGE" AND totals.visits=1 THEN 1
      ELSE
      0
    END
      AS PageViews,

      MAX(
      IF
        (hits.isInteraction =TRUE,
          hits.time / 1000,
          0)) OVER (PARTITION BY fullVisitorId, visitStartTime) AS LastInteraction,

    FROM
     `businesshelpcenteranalytics.123256751.ga_sessions_*`
     ,UNNEST(hits) as hits
      WHERE _TABLE_SUFFIX BETWEEN '20201201' and REPLACE(CAST(current_date() AS STRING), "-","")

    ORDER BY
      Sessions,
      hitSeq )
  WHERE
    hitType='PAGE' )
GROUP BY
  thedate,Page
ORDER BY
  Pageviews DESC


        ;;
}

    dimension: pk_ {
      sql: CONCAT(${Page}, "_", ${thedate}) ;;
      primary_key: yes
      hidden: yes
    }

  dimension: thedate {
    hidden: yes
  }

  dimension: Page {
    hidden: yes
  }

  measure: TimeOnPage {
    type: sum_distinct
   value_format_name: decimal_0
    description: "seconds"
    label: "Sum Time on Page(s)"
  }

  measure: TimeOnPage_m {
    type: number
    label: "Sum Time on Page(m)"
    value_format_name: decimal_2
    description: "Sum of all time on page in minutes, Example 4.12 is 4 minutes and 12 seconds"
    sql: CAST (CONCAT(CONCAT(FLOOR(${TimeOnPage}/60.0), '.'), MOD(CAST(${TimeOnPage} AS INT64), 60)) AS FLOAT64) ;;
  }

  measure: Exits {
    type: sum_distinct
    value_format: "0"
    hidden: yes
  }

  measure: Pageviews {
    type: sum_distinct
    value_format_name: decimal_0
    hidden: yes
  }

  measure: Avg_Time_On_Page {
    type: average
    value_format_name: decimal_0
    description: "seconds"
    label: "Avg Time on Page(s)"
  }

  measure: Avg_Time_On_Page_m {
    type: number
    label: "Avg Time on Page(m)"
    value_format_name: decimal_2
    description: "Avg time on page in minutes, Example 4.12 is 4 minutes and 12 seconds"

    sql:  FLOOR(${Avg_Time_On_Page}/60) + 0.01 * MOD(CAST(${Avg_Time_On_Page} AS INT64), 60) ;;
  }




  }
