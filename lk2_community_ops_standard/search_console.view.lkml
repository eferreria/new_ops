view: search_console {

derived_table: {
  sql:
        SELECT
          site_url,
          search_type,
          date,
          device,
          clicks,
          impressions,
          ctr,
          position,
          query,
          page,
          country,
          table_type
            FROM (
              SELECT
                site_url,
                search_type,
                date,
                device,
                clicks,
                impressions,
                ctr,
                position,
                NULL AS query,
                NULL AS page,
                NULL AS country,
                'device' AS table_type
              FROM
                `adswerve-search-console.google_search_console.snapchat_com_performance_report_device`
              UNION ALL
              SELECT
                site_url,
                search_type,
                date,
                NULL AS device,
                clicks,
                impressions,
                ctr,
                position,
                query,
                NULL AS page,
                NULL AS country,
                'query' AS table_type
              FROM
                `adswerve-search-console.google_search_console.snapchat_com_performance_report_query`
              UNION ALL
              SELECT
                site_url,
                search_type,
                date,
                NULL AS device,
                clicks,
                impressions,
                ctr,
                position,
                NULL AS query,
                page,
                NULL AS country,
                'pages' AS table_type
              FROM
                `adswerve-search-console.google_search_console.snapchat_com_performance_report_page`
              UNION ALL
              SELECT
                site_url,
                search_type,
                date,
                NULL AS device,
                clicks,
                impressions,
                ctr,
                position,
                NULL AS query,
                null as page,
                country,
                'country' AS table_type
              FROM
                `adswerve-search-console.google_search_console.snapchat_com_performance_report_country` )
          ;;

}

  dimension: site_url {
    type: string
    description: "url of the site"

    case: {
      when: {
        sql: ${TABLE}.site_url = 'https://story.snapchat.com/' ;;
        label: "https://story.snapchat.com/"
      }
      when: {
        sql: ${TABLE}.site_url = 'https://support.snapchat.com/' ;;
        label: "https://support.snapchat.com/"
      }
      else: "other"
    }
  }

  dimension: search_type {
    type: string
    description: "web, image or video"
    case: {
      when: {
        sql: ${TABLE}.search_type = 'web' ;;
        label: "web"
      }
      when: {
        sql: ${TABLE}.search_type = 'image' ;;
        label: "image"
      }
      when: {
        sql: ${TABLE}.search_type = 'video' ;;
        label: "video"
      }
      else: "none"
    }

  }

  dimension: table_type {
    type: string
    description: "select search console table - pages, query, device, country"
    case: {
      when: {
        sql: ${TABLE}.table_type = 'query' ;;
        label: "query"
      }
      when: {
        sql: ${TABLE}.table_type = 'pages' ;;
        label: "pages"
      }
      when: {
        sql: ${TABLE}.table_type = 'device' ;;
        label: "device"
      }
      when: {
        sql: ${TABLE}.table_type = 'country' ;;
        label: "country"
      }
      else: "none"
    }

  }

  dimension_group: date {
    type: time
    convert_tz: no
    timeframes: [date,day_of_month,day_of_week,day_of_week_index,year,week_of_year,quarter_of_year,month_name,month_num, week, month]
  }

  dimension: date_string {
    type: string
    sql: CAST(DATE(${TABLE}.date) AS STRING) ;;
    hidden: yes
  }

  dimension: page_plus_date {
    type: string
    sql: CONCAT(${page},${date_string}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: device {
    type: string
    description: "device - mobile or desktop"
  }

  dimension: query {
    type: string
    description: "url of landing page"
  }

  dimension: page {
    type: string
    description: "url of landing page"
  }

  dimension: country {
    type: string
    description: "Country of search"
  }

  measure: clicks {
    type: sum
    description: "The number clicks on your website URLs from a Google Search results page, not including clicks on paid Google Ads search results."
  }

  measure: impressions {
    type: sum
    description: "The number of times any URL from your site appeared in search results viewed by a user, not including paid Google Ads search impressions."
  }

  measure: ctr {
    type: number
    description: "Click through rate = Clicks / Impressions * 100."
    value_format_name: percent_1
    sql: ${clicks}/${impressions} ;;
  }

  measure: position {
    type: average
    description: "The average ranking of your website URLs for the query or queries. For example, if your site's URL appears at position 3 for one query and position 7 for another query, the average position would be 5 (3+7/2)."
    value_format_name: decimal_2
    label: "Average Position"
  }

  measure: min_position {
    type: min
    description: "The Min of average ranking of your website URLs for the query or queries. For example, if your site's URL appears at position 3 for one query and position 7 for another query, the average position would be 5 (3+7/2)."
    value_format_name: decimal_2
    label: "Min Average Position"
    sql: ${TABLE}.position ;;
  }


}
