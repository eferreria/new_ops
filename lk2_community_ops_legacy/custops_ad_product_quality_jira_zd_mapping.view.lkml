# most active contributor jbabra@snapchat.com
view: custops_ad_product_quality_jira_zd_mapping {
    derived_table: {
      sql:
      SELECT jira_id, zendesk_id FROM
      (SELECT issue_key AS jira_id,
                 CAST(SUBSTR(REGEXP_EXTRACT(description, r'https://snapchat.zendesk.com/agent/tickets/([^?&#]*)'), 0,8) AS integer) AS zendesk_id
           FROM [sc-analytics:report_customer_ops.ad_product_quality_jira_detail]),
          (SELECT REPLACE(REPLACE(REPLACE(extract,"'",""),",",""),"]","") as jira_id,
                 id AS zendesk_id
              FROM (SELECT id,
                      CASE
                          WHEN tag LIKE '%deli%' THEN CONCAT("DELI-",SUBSTR(REGEXP_EXTRACT(tag, r'deli-([^?&#]*)'), 0,6))
                          WHEN tag LIKE '%ads%'  THEN CONCAT("ADS-",SUBSTR(REGEXP_EXTRACT(tag, r'ads-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%bro%' THEN CONCAT("BRO-",SUBSTR(REGEXP_EXTRACT(tag, r'bro-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%create%' THEN CONCAT("CREATE-",SUBSTR(REGEXP_EXTRACT(tag, r'create-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%cur%' THEN CONCAT("CUR-",SUBSTR(REGEXP_EXTRACT(tag, r'cur-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%datp%' THEN CONCAT("DATP-",SUBSTR(REGEXP_EXTRACT(tag, r'datp-([^?&#]*)'), 0,6))

                           WHEN tag LIKE '%maps%' THEN CONCAT("MAPS-",SUBSTR(REGEXP_EXTRACT(tag, r'maps-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%mes%' THEN CONCAT("MES-",SUBSTR(REGEXP_EXTRACT(tag, r'mes-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%monp%' THEN CONCAT("MONP-",SUBSTR(REGEXP_EXTRACT(tag, r'monp-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%opera%' THEN CONCAT("OPERA-",SUBSTR(REGEXP_EXTRACT(tag, r'opera-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%sct%' THEN CONCAT("SCT-",SUBSTR(REGEXP_EXTRACT(tag, r'sct-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%speceng%' THEN CONCAT("SPECENG-",SUBSTR(REGEXP_EXTRACT(tag, r'speceng-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%spt%' THEN CONCAT("SPT-",SUBSTR(REGEXP_EXTRACT(tag, r'spt-([^?&#]*)'), 0,6))
                           WHEN tag LIKE '%tools%' THEN CONCAT("TOOLS-",SUBSTR(REGEXP_EXTRACT(tag, r'tools-([^?&#]*)'), 0,6))
                      ELSE NULL END as extract,
                  FROM  [sc-analytics:report_zendesk.ticket_distinct]
                  )
                  WHERE extract IS NOT NULL)
                  GROUP BY 1,2


      ;;
    }

######################
##### DIMENSIONS #####
######################


    dimension: jira_id {
      type: string
    }

  dimension: zendesk_id {
    type: string
  }


  }
