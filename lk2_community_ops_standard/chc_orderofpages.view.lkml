# most active contributor jbabra@snapchat.com
view: chc_orderofpages {

  derived_table: {
    sql:
  SELECT
    REGEXP_EXTRACT(Landing_Page, r'/([^/]+)/?$') AS Landing_Page,
    REGEXP_EXTRACT(second_page_path, r'/([^/]+)/?$')AS second_page,
    REGEXP_EXTRACT(third_page_path, r'/([^/]+)/?$') AS third_page,
    REGEXP_EXTRACT(fourth_page_path, r'/([^/]+)/?$') AS fourth_page,
    REGEXP_EXTRACT(fifth_page_path, r'/([^/]+)/?$') AS fifth_page,
    REGEXP_EXTRACT(sixth_page_path, r'/([^/]+)/?$') AS sixth_page,
    REGEXP_EXTRACT(seventh_page_path, r'/([^/]+)/?$') AS seventh_page,
    fullVisitorId,
    SessionIdentity
  FROM (
    SELECT
      CASE
        WHEN totals.visits=1 THEN CONCAT( fullvisitorid,"|", visitId,"|",CAST(date AS string))
    END
      AS SessionIdentity,

      CASE
        WHEN hits.isEntrance=TRUE THEN hits.page.pagePath
    END
      AS Landing_Page,

      CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,1) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS second_page_path,

        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,2) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS third_page_path,

        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,3) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS fourth_page_path,

        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,4) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS fifth_page_path,

        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,5) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS sixth_page_path,

        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,6) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS seventh_page_path,

        fullVisitorId

    FROM
     `businesshelpcenteranalytics.123256751.ga_sessions_*`
     ,UNNEST(hits) as hits
      WHERE _TABLE_SUFFIX BETWEEN '20201201' and REPLACE(CAST(current_date() AS STRING), "-","")

   ORDER BY
      SessionIdentity,
      Landing_Page)

  WHERE
    SessionIdentity IS NOT NULL
    AND landing_page IS NOT NULL

  GROUP BY
    Landing_Page,
    second_page,
    third_page,
    fourth_page,
    fifth_page,
    sixth_page,
    seventh_page,
    fullVisitorId,
    SessionIdentity
;;
  }

  dimension: Landing_Page {
    type: string
    label: "First Page"
    sql: CASE WHEN ${TABLE}.Landing_Page LIKE '%search_results%' THEN ${TABLE}.Landing_Page
              ELSE SPLIT(${TABLE}.Landing_Page , '?')[OFFSET(0)]
              END;;
  }

  dimension: second_page {
    type: string
    sql: CASE WHEN ${TABLE}.second_page LIKE '%search_results%' THEN ${TABLE}.second_page
          ELSE SPLIT(${TABLE}.second_page , '?')[OFFSET(0)]
          END;;
  }

  dimension: third_page {
    type: string
    sql: CASE WHEN ${TABLE}.third_page LIKE '%search_results%' THEN ${TABLE}.third_page
    ELSE SPLIT(${TABLE}.third_page , '?')[OFFSET(0)]
    END;;
  }

  dimension: fourth_page {
    type: string
    sql: CASE WHEN ${TABLE}.fourth_page LIKE '%search_results%' THEN ${TABLE}.fourth_page
    ELSE SPLIT(${TABLE}.fourth_page , '?')[OFFSET(0)]
    END;;
  }

  dimension: fifth_page {
    type: string
    sql: CASE WHEN ${TABLE}.fifth_page LIKE '%search_results%' THEN ${TABLE}.fifth_page
    ELSE SPLIT(${TABLE}.fifth_page , '?')[OFFSET(0)]
    END;;
  }

  dimension: sixth_page {
    type: string
    sql: CASE WHEN ${TABLE}.sixth_page LIKE '%search_results%' THEN ${TABLE}.sixth_page
    ELSE SPLIT(${TABLE}.sixth_page , '?')[OFFSET(0)]
    END;;
  }

  dimension: seventh_page {
    type: string
    sql: CASE WHEN ${TABLE}.seventh_page LIKE '%search_results%' THEN ${TABLE}.seventh_page
    ELSE SPLIT(${TABLE}.seventh_page , '?')[OFFSET(0)]
    END;;
  }

  dimension: fullVisitorId {
    type: string
    hidden: yes
  }

  dimension: SessionIdentity {
    type: string
    primary_key: yes
    hidden: yes
  }

  measure: Sessions  {
    type: count
    hidden: yes
  }


}
