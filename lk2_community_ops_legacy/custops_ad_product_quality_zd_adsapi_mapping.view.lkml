# most active contributor jbabra@snapchat.com
view: custops_ad_product_quality_zd_adsapi_mapping {
    derived_table: {
      sql:
SELECT c.ticket_id as ticket_id,
       c.ticket_link as ticket_link,
       c.ad_account_id as ad_account_id,
       c.ad_account_name as ad_account_name,
       c.organization_id as organization_id,
      c.organization_name as organization_name,
      o.country as organization_country
FROM (SELECT b.ticket_id AS ticket_id,
       b.ticket_link AS ticket_link,
       b.ad_account_id AS ad_account_id,
       b.ad_account_name AS ad_account_name,
       CASE WHEN b.organization_id IS NOT NULL THEN b.organization_id
            ELSE o.id
       END AS organization_id,
      CASE WHEN b.organization_name IS NOT NULL THEN b.organization_name
            ELSE o.name
       END AS organization_name
FROM (SELECT a.ticket_id as ticket_id,
             a.ticket_link as ticket_link,
             CASE WHEN a.organization_id IS NULL AND a.ad_account_name IS NULL THEN a.ghost_mode_url
             ELSE a.organization_id
             END as organization_id,
             CASE WHEN a.organization_name IS NULL AND a.ad_account_name IS NULL then o.name
             ELSE a.organization_name
             END as organization_name,
             CASE WHEN a.ad_account_name IS NULL THEN NULL
             ELSE a.ad_account_id
             END as ad_account_id,
             a.ad_account_name as ad_account_name
FROM (
      SELECT ab.ticket_id as ticket_id,
             ab.ticket_link as ticket_link,
             CASE WHEN ab.ad_account_id IS NULL THEN ab.ghost_mode_url
             ELSE ab.ad_account_id
             END as ad_account_id,
             CASE WHEN ab.ad_account_name IS NULL THEN acc.name
             ELSE ab.ad_account_name
             END as ad_account_name,
             ab.ghost_mode_url AS ghost_mode_url,
             ab.organization_id as organization_id,
             ab.organization_name as organization_name
      FROM (SELECT t.ticket_id as ticket_id,
         CONCAT("https://snapchat.zendesk.com/agent/tickets/",CAST(t.ticket_id AS STRING)) as ticket_link,
         t.organization_id as organization_id,
         o.name as organization_name,
         t.ad_account_id as ad_account_id,
         acc.name as ad_account_name,
         t.ghost_mode_url as ghost_mode_url
FROM (SELECT id as ticket_id,
       CASE WHEN LENGTH(business_account_id) = 36 THEN business_account_id
            ELSE NULL
       END as organization_id,
       CASE WHEN LENGTH(ad_account_id) = 36 THEN ad_account_id
       ELSE NULL
       END AS ad_account_id,
      CASE WHEN ghost_mode_url LIKE '%https://softserve-prod.appspot.com/%' THEN SUBSTR(REGEXP_EXTRACT(ghost_mode_url, r'https://softserve-prod.appspot.com/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url LIKE '%https://snap-central.appspot.com/%' THEN SUBSTR(REGEXP_EXTRACT(ghost_mode_url, r'https://snap-central.appspot.com/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url LIKE '%https://ad-center.snapchat.com/orders/%' THEN SUBSTR(REGEXP_EXTRACT(ghost_mode_url, r'https://ad-center.snapchat.com/orders/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url LIKE '%https://ads.snapchat.com/%' THEN SUBSTR(REGEXP_EXTRACT(ghost_mode_url, r'https://ads.snapchat.com/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url IS NULL AND description LIKE '%https://business.snapchat.com/%' THEN SUBSTR(REGEXP_EXTRACT(description, r'https://business.snapchat.com/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url IS NULL AND description LIKE '%https://softserve-prod.appspot.com/%' THEN SUBSTR(REGEXP_EXTRACT(description, r'https://softserve-prod.appspot.com/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url IS NULL AND description LIKE '%https://snap-central.appspot.com/%' THEN SUBSTR(REGEXP_EXTRACT(description, r'https://snap-central.appspot.com/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url IS NULL AND description LIKE '%https://ad-center.snapchat.com/orders/%' THEN SUBSTR(REGEXP_EXTRACT(description, r'https://ad-center.snapchat.com/orders/([^?&#]*)'), 0,36)
           WHEN ghost_mode_url IS NULL AND description LIKE '%https://ads.snapchat.com/%' THEN SUBSTR(REGEXP_EXTRACT(description, r'https://ads.snapchat.com/([^?&#]*)'), 0,36)
      ELSE NULL
      END as ghost_mode_url
FROM [sc-analytics:report_zendesk.ticket_distinct]) as t
LEFT JOIN [sc-analytics:prod_metadata_mpp.organization] o ON o.id = t.organization_id
LEFT JOIN [sc-analytics:prod_metadata_mpp.ad_account] acc ON acc.id = t.ad_account_id) as ab
LEFT JOIN [sc-analytics:prod_metadata_mpp.ad_account] acc ON acc.id = ab.ghost_mode_url) as a
LEFT JOIN [sc-analytics:prod_metadata_mpp.organization] o ON o.id = a.ghost_mode_url
) b
      LEFT JOIN [sc-analytics:prod_metadata_mpp.ad_account] acc ON acc.id = b.ad_account_id
      LEFT JOIN [sc-analytics:prod_metadata_mpp.organization] o ON o.id = acc.organization_id) c
      LEFT JOIN [sc-analytics:prod_metadata_mpp.organization] o ON o.id = c.organization_id



      ;;
    }

######################
##### DIMENSIONS #####
######################


    dimension: ticket_id {
      type: string
    }

    dimension: ticket_link {
      type: string
    }

    dimension: organization_id {
      type: string
    }

    dimension: organization_name {
      type: string
    }

  dimension: organization_country {
    type: string
  }

    dimension: ad_account_id {
      type: string
    }

    dimension: ad_account_name {
      type: string
    }


  measure: count_ticket {
    type: count_distinct
    sql: ${ticket_id} ;;
  }
  }
