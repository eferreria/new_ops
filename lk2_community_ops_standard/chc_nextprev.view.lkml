# most active contributor jbabra@snapchat.com
view: chc_nextprev {
view_label: "Page Sequence"
  derived_table: {

    sql:

     SELECT
     CONCAT( fullvisitorid,"|", visitId,"|",CAST(date AS string)) AS SessionIdentity,
     hits.page.pagePath AS pagePath,
     LEAD(hits.page.pagePath) OVER (PARTITION BY fullVisitorId, visitStartTime ORDER BY hits.hitNumber) AS next_page_path,
     LAG(hits.page.pagePath) OVER (PARTITION BY fullVisitorId, visitStartTime ORDER BY hits.hitNumber) AS prev_page_path,

   FROM
     `businesshelpcenteranalytics.123256751.ga_sessions_*`
     ,UNNEST(hits) as hits
      WHERE _TABLE_SUFFIX BETWEEN '20201201' and REPLACE(CAST(current_date() AS STRING), "-","")

and
     hits.type="PAGE"

      ;;
  }


  dimension: SessionIdentity {
    type: string
    primary_key: yes
    hidden: yes
  }

  dimension: pagePath {
    type: string
    label: "Middle Page"

    sql:
--    CASE
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'en-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'da-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'de-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') = "es" THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'fr-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'it-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'nl-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'ja-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'nb-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'pt-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'fi-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'sv-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$') LIKE 'ar-__%' THEN "Main Page"
--    ELSE REGEXP_EXTRACT(${TABLE}.pagePath, r'/([^/]+)/?$')
--    END
      ${TABLE}.pagePath

    ;;
  }

  dimension: next_page_path {
    type: string
    label: "Next Page"
    #sql: SPLIT(${TABLE}.next_page_path , '?')[OFFSET(0)] ;;

    sql:
--    CASE
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'en-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'da-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'de-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') = "es" THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'fr-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'it-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'nl-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'ja-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'nb-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'pt-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'fi-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'sv-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$') LIKE 'ar-__%' THEN "Main Page"
--    ELSE
--    REGEXP_EXTRACT(${TABLE}.next_page_path, r'/([^/]+)/?$')
--    END
    ${TABLE}.next_page_path
    ;;
  }

  dimension: prev_page_path {
    type: string
    label: "Previous Page"
    #sql: SPLIT(${TABLE}.prev_page_path , '?')[OFFSET(0)] ;;

    sql:
--    CASE
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'en-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'da-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'de-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') = "es" THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'fr-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'it-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'nl-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'ja-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'nb-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'pt-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'fi-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'sv-__%' THEN "Main Page"
--    WHEN REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$') LIKE 'ar-__%' THEN "Main Page"
--    ELSE REGEXP_EXTRACT(${TABLE}.prev_page_path, r'/([^/]+)/?$')
--    END
      ${TABLE}.prev_page_path
    ;;
  }

  dimension: pagePath_type {
    type: string
    label: "Middle Page Type"

    sql: CASE
          WHEN ${TABLE}.pagePath LIKE '%/404%' THEN "Error"
          WHEN ${TABLE}.pagePath LIKE '%/article/%' OR ${TABLE}.pagePath LIKE '%/a/%' OR ${TABLE}.pagePath LIKE '%/articles/%' THEN "Article"
          WHEN ${TABLE}.pagePath LIKE '%/i-need-help%' OR ${TABLE}.pagePath LIKE '%/requests%'  THEN "Contact Us"
          WHEN ${TABLE}.pagePath LIKE '%/search%' THEN "Search"
          WHEN ${TABLE}.pagePath LIKE '%/success%' THEN "Success"
          WHEN ${TABLE}.pagePath LIKE '%/news%' THEN "Whats New"
          WHEN ${TABLE}.pagePath LIKE '%/category/%' OR ${TABLE}.pagePath LIKE '%/categories/%'  THEN "Category"
          WHEN ${TABLE}.pagePath LIKE '%/sections/%'  THEN "Section"
          WHEN ${TABLE}.pagePath LIKE '%/preview%' THEN "Other"
          WHEN ${TABLE}.pagePath IS NULL THEN NULL
          ELSE "Home Page" END;;
  }

  dimension: prev_page_path_type {
    type: string
    label: "Previous Page Type"
    #sql: SPLIT(${TABLE}.next_page_path , '?')[OFFSET(0)] ;;

    sql: CASE
          WHEN ${TABLE}.prev_page_path LIKE '%/404%' THEN "Error"
          WHEN ${TABLE}.prev_page_path LIKE '%/article/%' OR ${TABLE}.prev_page_path LIKE '%/a/%' OR ${TABLE}.prev_page_path LIKE '%/articles/%' THEN "Article"
          WHEN ${TABLE}.prev_page_path LIKE '%/i-need-help%' OR ${TABLE}.prev_page_path LIKE '%/requests%'  THEN "Contact Us"
          WHEN ${TABLE}.prev_page_path LIKE '%/search%' THEN "Search"
          WHEN ${TABLE}.prev_page_path LIKE '%/success%' THEN "Success"
          WHEN ${TABLE}.prev_page_path LIKE '%/news%' THEN "Whats New"
          WHEN ${TABLE}.prev_page_path LIKE '%/category/%' OR ${TABLE}.prev_page_path LIKE '%/categories/%'  THEN "Category"
          WHEN ${TABLE}.prev_page_path LIKE '%/sections/%'  THEN "Section"
          WHEN ${TABLE}.prev_page_path LIKE '%/preview%' THEN "Other"
          WHEN ${TABLE}.prev_page_path IS NULL THEN NULL
          ELSE "Home Page" END;;
  }

  dimension: next_page_path_type {
    type: string
    label: "Next Page Type"
    #sql: SPLIT(${TABLE}.next_page_path , '?')[OFFSET(0)] ;;

    sql: CASE
          WHEN ${TABLE}.next_page_path LIKE '%/404%' THEN "Error"
          WHEN ${TABLE}.next_page_path LIKE '%/article/%' OR ${TABLE}.next_page_path LIKE '%/a/%' OR ${TABLE}.next_page_path LIKE '%/articles/%' THEN "Article"
          WHEN ${TABLE}.next_page_path LIKE '%/i-need-help%' OR ${TABLE}.next_page_path LIKE '%/requests%'  THEN "Contact Us"
          WHEN ${TABLE}.next_page_path LIKE '%/search%' THEN "Search"
          WHEN ${TABLE}.next_page_path LIKE '%/success%' THEN "Success"
          WHEN ${TABLE}.next_page_path LIKE '%/news%' THEN "Whats New"
          WHEN ${TABLE}.next_page_path LIKE '%/category/%' OR ${TABLE}.next_page_path LIKE '%/categories/%'  THEN "Category"
          WHEN ${TABLE}.next_page_path LIKE '%/sections/%'  THEN "Section"
          WHEN ${TABLE}.next_page_path LIKE '%/preview%' THEN "Other"
          WHEN ${TABLE}.next_page_path IS NULL THEN NULL
          ELSE "Home Page" END;;
  }

  }
