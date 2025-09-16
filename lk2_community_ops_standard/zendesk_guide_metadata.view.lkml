# most active contributor abenharosh@snapchat.com
view: zendesk_guide_metadata {
  view_label: "Zendesk Guide Metadata"
  derived_table: {

    sql:
          with table_dates AS (SELECT _TABLE_SUFFIX AS max_table_date
          FROM `sc-analytics.report_zendesk.articles_*`
          ORDER BY PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) DESC LIMIT 1)

          SELECT
            cast(a.id as string) as page_id
            ,"Article" as page_type
            ,a.locale
            ,a.title as title
            ,a.body as body_inc_html
            ,REGEXP_REPLACE(a.body,r'</?\S+[^<>]*>','') as body_exc_html
            ,cast(cast(a.created_at as timestamp) as date) as created_at
            ,cast(cast(a.edited_at as timestamp) as date) as edited_at
            ,cast(cast(a.updated_at as timestamp) as date) as updated_at
            ,concat('https://help.snapchat.com/hc/articles/',a.id) as url
            ,a.section_id
            ,s.section_name
            ,s.full_location_path
            ,a.position
            ,cast(a.draft as string) as draft
            ,ARRAY_TO_STRING(a.label_names,", ") as labels
            ,cast(a.permission_group_id as string) as permission_group_id
            ,cast(a.user_segment_id as string) as user_segment_id
            ,cast(a.author_id as string) as author_id
            ,ea.title as english_title
            ,ea.body as english_body_inc_html
            ,REGEXP_REPLACE(ea.body,r'</?\S+[^<>]*>','') as english_body_exc_html

      FROM `sc-analytics.report_zendesk.articles_*` as a
      LEFT JOIN ( SELECT
                    s.id as section_id
                    ,s.name as section_name
                    ,s1.name as parent_section_name_l1
                    ,s2.name as parent_section_name_l2
                    ,c.name as category_name
                    ,concat(c.name," > ",IF(s2.name is null,'',concat(s2.name," > ")),IF(s1.name is null,'',concat(s1.name," > ")),s.name) as full_location_path

                    FROM `sc-analytics.report_zendesk.sections_*` as s
                      LEFT JOIN (select * from `sc-analytics.report_zendesk.sections_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as s1 on s1.id=s.parent_section_id
                      LEFT JOIN (select * from `sc-analytics.report_zendesk.sections_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as s2 on s2.id=s1.parent_section_id
                      LEFT JOIN (SELECT * FROM `sc-analytics.report_zendesk.categories_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as c on c.id=s.category_id
                      where s.locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as s on s.section_id=a.section_id

      LEFT JOIN (select id,title,body from `sc-analytics.report_zendesk.articles_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as ea on ea.id=a.id

      WHERE 1=1
      AND _TABLE_SUFFIX = (select max_table_date from table_dates)

      UNION ALL

          SELECT
            cast(s.id as string) as page_id
            ,"Section" as page_type
            ,s.locale
            ,s.name as title
            ,NULL as body_inc_html
            ,NULL as body_exc_html
            ,cast(cast(s.created_at as timestamp) as date) as created_at
            ,cast(cast(s.edited_at as timestamp) as date) as edited_at
            ,cast(cast(s.updated_at as timestamp) as date) as updated_at
            ,concat('https://help.snapchat.com/hc/sections/',s.id) as url
            ,NULL as section_id
            ,NULL as section_name
            ,concat(c.name," > ",IF(s2.name is null,'',concat(s2.name," > ")),IF(s1.name is null,'',concat(s1.name," > ")),es.name) as full_location_path
            ,s.position
            ,cast(s.draft as string) as draft
            ,NULL as labels
            ,cast(s.permission_group_id as string) as permission_group_id
            ,cast(s.user_segment_id as string) as user_segment_id
            ,cast(s.author_id as string) as author_id
            ,es.name as english_title
            ,NULL as english_body_inc_html
            ,NULL as english_body_exc_html

      FROM `sc-analytics.report_zendesk.sections_*` as s
      LEFT JOIN (select * from `sc-analytics.report_zendesk.sections_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as s1 on s1.id=s.parent_section_id
      LEFT JOIN (select * from `sc-analytics.report_zendesk.sections_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as s2 on s2.id=s1.parent_section_id
      LEFT JOIN (SELECT * FROM `sc-analytics.report_zendesk.categories_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as c on c.id=s.category_id
      LEFT JOIN (select id,name from `sc-analytics.report_zendesk.sections_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as es on es.id=s.id

      WHERE _TABLE_SUFFIX = (select max_table_date from table_dates)

UNION ALL

          SELECT
            cast(c.id as string) as page_id
            ,"Category" as page_type
            ,c.locale
            ,c.name as title
            ,NULL as body_inc_html
            ,NULL as body_exc_html
            ,cast(cast(c.created_at as timestamp) as date) as created_at
            ,cast(cast(c.edited_at as timestamp) as date) as edited_at
            ,cast(cast(c.updated_at as timestamp) as date) as updated_at
            ,concat('https://help.snapchat.com/hc/categories/',c.id) as url
            ,NULL as section_id
            ,NULL as section_name
            ,NULL as full_location_path
            ,c.position
            ,cast(c.draft as string) as draft
            ,NULL as labels
            ,cast(c.permission_group_id as string) as permission_group_id
            ,cast(c.user_segment_id as string) as user_segment_id
            ,cast(c.author_id as string) as author_id
            ,ec.name as english_title
            ,NULL as english_body_inc_html
            ,NULL as english_body_exc_html

            FROM `sc-analytics.report_zendesk.categories_*` as c
            LEFT JOIN (select id,name from `sc-analytics.report_zendesk.categories_*` where locale="en-us" AND _TABLE_SUFFIX = (select max_table_date from table_dates)) as ec on ec.id=c.id
            WHERE _TABLE_SUFFIX = (select max_table_date from table_dates)

UNION ALL

          SELECT
            SAFE_CAST(JSON_VALUE(v, '$.id') AS string) AS id,
            "Dynamic Content" AS content_type,
            CASE SAFE_CAST(JSON_VALUE(v, '$.locale_id') AS INT64)
              WHEN 1 THEN 'en-us'
              WHEN 66 THEN 'ar'
              WHEN 2 THEN 'es'
              WHEN 1365 THEN 'fr-fr'
              WHEN 1503 THEN 'pt-pt'
              WHEN 1176 THEN 'en-gb'
              WHEN 1003 THEN 'sk'
              WHEN 74 THEN 'hr'
              WHEN 93 THEN 'el'
              WHEN 78 THEN 'cs'
              WHEN 94 THEN 'bg'
              WHEN 1009 THEN 'hu'
              WHEN 72 THEN 'sl'
              WHEN 27 THEN 'ru'
              WHEN 8 THEN 'de'
              WHEN 1474 THEN 'hi-in'
              WHEN 23 THEN 'ro'
              WHEN 19 THEN 'pt-br'
              WHEN 1005 THEN 'nl'
              WHEN 84 THEN 'fi'
              WHEN 88 THEN 'tr'
              WHEN 34 THEN 'no'
              WHEN 13 THEN 'pl'
              WHEN 92 THEN 'sv'
              WHEN 1000 THEN 'da'
              WHEN 22 THEN 'it'
              WHEN 67 THEN 'ja'
              WHEN 1186 THEN 'es-es'
              WHEN 1092 THEN 'lt'
              WHEN 1101 THEN 'lv'
              WHEN 101 THEN 'et'
              WHEN 1352 THEN 'ga'
              WHEN 1397 THEN 'mt'
              ELSE CAST(NULL AS STRING)
            END AS variant_locale,
            t.name,
            TRIM(JSON_VALUE(v, '$.content'))                                         AS variant_content,
            REGEXP_REPLACE(TRIM(JSON_VALUE(v, '$.content')),r'</?\S+[^<>]*>','') as body_exc_html,
            cast(SAFE.PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S%Ez', JSON_VALUE(v, '$.created_at')) as date) as created_at,
            cast(SAFE.PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S%Ez', JSON_VALUE(v, '$.updated_at')) as date) as edited_at,
            cast(SAFE.PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S%Ez', JSON_VALUE(v, '$.updated_at')) as date) as updated_at,
            concat('https://snapchat.zendesk.com/dynamic_content/items/',t.id,'/variants/',SAFE_CAST(JSON_VALUE(v, '$.id') AS INT64)) as url,
            t.id as section_id,
            t.placeholder as section_name,
            NULL as full_location_path,
            NULL as position,
            SAFE_CAST(JSON_VALUE(v, '$.active') AS string) as draft,
            SAFE_CAST(JSON_VALUE(v, '$.outdated') AS string) as labels, --used for whether the variant is outdated, not labels
            NULL as permission_group_id,
            NULL as user_segment_id,
            NULL as author_id,
            t.name as english_title,
            ed.english_content as english_body_inc_html,
            REGEXP_REPLACE(ed.english_content,r'</?\S+[^<>]*>','') as english_body_exc_html,

          FROM `sc-analytics.report_zendesk.dynamic_content_items_*` AS t
          LEFT JOIN UNNEST(t.variants) AS v
          LEFT JOIN (SELECT
                      id,TRIM(JSON_VALUE(v, '$.content')) AS english_content

                      FROM `sc-analytics.report_zendesk.dynamic_content_items_*` AS t
                      LEFT JOIN UNNEST(t.variants) AS v
                      WHERE _TABLE_SUFFIX = (select max_table_date from table_dates)
                      AND SAFE_CAST(JSON_VALUE(v, '$.locale_id') AS INT64) = 1
                      AND placeholder LIKE "%snapchat_support%"
                     ) as ed on ed.id=t.id
          WHERE _TABLE_SUFFIX = (select max_table_date from table_dates)
          AND placeholder LIKE "%snapchat_support%"
      ;;
  }

  dimension: page_id {
    label: "Page ID"
    type: string
    primary_key: yes
    sql: ${TABLE}.page_id ;;
    description: "Unique page ID"
    link: {
      label: "Page Link"
      url: "{{ url }}"
    }
  }

  dimension: page_type {
    label: "Page Type"
    type: string
    sql: ${TABLE}.page_type ;;
    description: "Whether the page is an Article, Section, or Category"
  }

  dimension: locale {
    label: "Locale"
    type: string
    sql: ${TABLE}.locale ;;
    description: "Locale version of the Page ID; curretly only showing en-us variants"
  }

  dimension: title {
    label: "Title"
    type: string
    description: "User-visible title of the article / section / category using the en-us English variant"
    sql: ${TABLE}.english_title ;;
    link: {
      label: "Page Link"
      url: "{{ url }}"
    }
  }

  dimension: localized_title {
    label: "Localized Title"
    type: string
    description: "User-visible title of the article / section / category in the language it was localized to"
    sql: ${TABLE}.title ;;
    group_label: "Localized Fields"
    link: {
      label: "Page Link"
      url: "{{ url }}"
    }
  }

  dimension: body_inc_html {
    label: "English Body (with HTML)"
    description: "The English text body of the en-us variant of the article, including HTML formatting. Only applicable to Articles"
    type: string
    sql: ${TABLE}.english_body_inc_html ;;
  }

  dimension: body_exc_html {
    label: "English Body (without HTML)"
    description: "The English text body of the en-us variant of the article, stripped of all HTML formatting. Only applicable to Articles"
    type: string
    sql: ${TABLE}.english_body_exc_html ;;
  }

  dimension: localized_body_inc_html {
    label: "Localized Body (with HTML)"
    description: "The localized text body of the specific variant of the article, including HTML formatting. Only applicable to Articles"
    type: string
    sql: ${TABLE}.body_inc_html ;;
    group_label: "Localized Fields"
  }

  dimension: localized_body_exc_html {
    label: "Localized Body (without HTML)"
    description: "The localized text body of the specific variant of the article, stripped of all HTML formatting. Only applicable to Articles"
    type: string
    sql: ${TABLE}.body_exc_html ;;
    group_label: "Localized Fields"
  }

  dimension_group: created_at {
    label: "Created PST"
    description: "The date in PST that the page was created in Zendesk Guide"
    type: time
    convert_tz: no
    sql: cast(${TABLE}.created_at AS TIMESTAMP) ;;
    timeframes: [date, week, day_of_week, month, year, quarter, week_of_year]
  }

  dimension_group: edited_at {
    label: "Edited PST"
    description: "The most recent date the page was edited in Zendesk Guide"
    type: time
    convert_tz: no
    sql: cast(${TABLE}.edited_at AS TIMESTAMP) ;;
    timeframes: [date, week, day_of_week, month, year, quarter, week_of_year]
  }

  dimension_group: updated_at {
    label: "Updated PST"
    description: "The most recent date the page was updated in Zendesk Guide"
    type: time
    convert_tz: no
    sql: cast(${TABLE}.updated_at AS TIMESTAMP) ;;
    timeframes: [date, week, day_of_week, month, year, quarter, week_of_year]
  }

  dimension: url {
    label: "URL"
    description: "URL for the page without locale"
    type: string
    sql: ${TABLE}.url ;;
    link: {
      label: "Page Link"
      url: "{{ url }}"
    }
  }

  dimension: section_id {
    label: "Section ID"
    description: "For articles, this is the section ID that the article is placed in. Only applicable to Articles"
    type: string
    sql: ${TABLE}.section_id ;;
    group_label: "Page Location / Placement"
  }

  dimension: section_name {
    label: "Section Title"
    description: "For article, this is the section name that the article is placed in. Only applicable to Articles"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" THEN NULL ELSE ${TABLE}.section_name END ;;
    group_label: "Page Location / Placement"
  }

  dimension: full_location_path {
    label: "Full Location Path"
    description: "For articles and sections, this is the full path of sections that shows how to get to that particular page. Only applicable to Articles and Sections"
    type: string
    sql: ${TABLE}.full_location_path ;;
    group_label: "Page Location / Placement"
  }

  dimension: position {
    label: "Position"
    description: "The rank / position of the article, section, or category showing the order it has for end users"
    type: string
    sql: ${TABLE}.position ;;
    group_label: "Page Location / Placement"
  }

  dimension: publication_status {
    label: "Publication Status"
    description: "Whteher the article is published or still in draft status"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" THEN NULL
    WHEN ${TABLE}.draft="true" THEN "Draft" ELSE "Published" END ;;
    group_label: "Access"
  }

  dimension: labels {
    label: "Labels"
    description: "Text labels manually added to articles for internal categorization / tagging purposes. Only applicable to Articles"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" then null else ${TABLE}.labels end ;;
  }

  dimension: dc_active {
    label: "Dynamic Content Active"
    description: "Whteher the DC is active or not"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" THEN ${TABLE}.draft
      ELSE NULL END ;;
    group_label: "Dynamic Content"
  }

  dimension: dc_outdated {
    label: "Dynamic Content Outdated"
    description: "Whteher the localized variant is most recently saved before the default variant"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" THEN ${TABLE}.labels
      ELSE NULL END ;;
    group_label: "Dynamic Content"
  }

  dimension: dc_placeholder {
    label: "Dynamic Content Placeholder"
    description: "The DC placeholder used in ZD"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" THEN ${TABLE}.section_name
      ELSE NULL END ;;
    group_label: "Dynamic Content"
  }

  dimension: dc_type {
    label: "Dynamic Content Type"
    description: "the main purpose and placement of the DC"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" AND (
                    (LOWER(${TABLE}.title) LIKE "%-v2%" AND LOWER(${TABLE}.title) LIKE "%cuf-blurb%") OR
                    LOWER(${TABLE}.title) LIKE "%instructions%" OR
                    LOWER(${TABLE}.title) LIKE "%snippet%" )
            THEN "Support Site Content"
            WHEN ${page_type}!="Dynamic Content" THEN NULL
      ELSE "Other" END ;;
    group_label: "Dynamic Content"
  }

  dimension: article_category {
    label: "Article Category"
    description: "Buckets all support articles into 3 categories: General, Policy, and No Resolution, based on nature of the support content; derived from labels"
    type: string
    sql:
        CASE
          WHEN ${page_type}="Article" AND ${labels} LIKE '%policy%' then "Policy"
          WHEN ${page_type}="Article" AND ${labels} LIKE '%no_resolution%' then "No Resolution"
          WHEN ${page_type}="Article" then "General"
          ELSE NULL END
    ;;
  }

  dimension: permission_group_id {
    label: "Permission Group"
    description: "The group of Zendesk Guide users that can manage the page; controlled via the article page;"
    type: string
    sql:
        CASE
          WHEN ${TABLE}.permission_group_id="207726" THEN "Administrators"
          WHEN ${TABLE}.permission_group_id="207766" THEN "Agents and Admins"
          ELSE NULL END
    ;;
    group_label: "Access"
  }

  dimension: user_segment_id {
    label: "User Segment"
    description: "Viewing permissions for the article - who can view it based on settings on the article page"
    type: string
    sql: CASE WHEN ${page_type}="Dynamic Content" THEN NULL
          WHEN ${TABLE}.permission_group_id="69123" THEN "Visible to Agents and Admins only"
          ELSE "Visible to Everyone" END
    ;;
    group_label: "Access"
  }

  dimension: localization_status {
    label: "Localization Status"
    description: ""
    type: string
    sql: CASE
          WHEN (${page_type}="Article" OR ${page_type}="Dynamic Content") AND ${body_inc_html}=${localized_body_inc_html} AND ${locale} NOT IN ("en-us", "en-gb") THEN "Not Localized"
          WHEN ${page_type}!="Dynamic Content" AND ${title}=${localized_title} AND ${locale} NOT IN ("en-us", "en-gb") THEN "Not Localized"
          ELSE "Localized" END
    ;;
    group_label: "Localized Fields"
  }


  ##measures

  measure: count_distinct {
    type: count_distinct
    label: "Distinct Page IDs"
    sql: ${page_id} ;;
  }

  measure: count {
    type: count
    label: "Page ID Variants"
##    sql: ${page_id} ;;
  }

  measure: average_body_length {
    type: average
    description: "Only applicable to Articles; uses the English variant"
    value_format: "0"
    sql: length(${body_exc_html}) ;;
  }

  measure: average_title_length {
    type: average
    description: "Uses the English variant"
    value_format: "0"
    sql: length(${title}) ;;
  }

drill_fields: [page_id,page_type,title,created_at_date,full_location_path,body_exc_html,count_distinct]

}
