# most active contributor jbabra@snapchat.com
view: business_customer_record {

   sql_table_name: [sc-bq-gcs-billingonly.revdatascience_dag.customer_record] ;;

    dimension: ad_account_id {
      label: "Ad Account ID"
      sql: ${TABLE}.ad_account_id ;;
      type: string
      primary_key: yes
    }

    dimension: dominant_relationship_adjusted {
      sql: IF(${TABLE}.dominant_relationship_adjusted is null,"UNKNOWN",${TABLE}.dominant_relationship_adjusted) ;;
      description: "Low, Medium, High or Unmanaged"
      type: string
    }

  measure: count {
    label: "count of ad_account_id"
    type: count_distinct
    approximate_threshold: 1000000
    sql: ${TABLE}.ad_account_id  ;;
  }

 }
