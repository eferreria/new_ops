# most active contributor jbabra@snapchat.com
view: twitter_sprinklr_archive {

sql_table_name: `sc-analytics.report_customer_ops.twitter_volume` ;;

  dimension_group: tweet_date {
    type: time
    sql: CAST(${TABLE}.date AS TIMESTAMP) ;;
      }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.date,"_pk") ;;
  }

  measure: case_count {
  type: sum
}

  measure: inbound_tweets {
    type: sum
  }

  measure: outbound_tweets {
    type: sum
  }

  measure: tier_l1 {
    type: sum
  }

  measure: tier_l2 {
    type: sum
  }

  measure: case_first_response_time_avg_seconds {
    type: average
  }

  measure: bot_handled {
    type: sum
  }

  measure: agent_handled {
    type: sum
  }

  measure: bot_and_agent_handled {
    type: sum
  }


}

view: twitter_case_count_agent {

  sql_table_name: `sc-analytics.report_customer_ops.twitter_case_count_agent` ;;

  dimension_group: tweet_date {
    type: time
    sql: CAST(${TABLE}.date AS TIMESTAMP) ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.date,"_pk") ;;
  }

  measure: case_count {
    type: sum
    label: "Agent Case Count"
  }

 dimension: agent_name {
   type: string
 }

}

view: twitter_macro_usage {

  sql_table_name: `sc-analytics.report_customer_ops.twitter_macro_usage` ;;

  dimension_group: tweet_date {
    type: time
    sql: CAST(${TABLE}.date AS TIMESTAMP) ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.date,"_pk") ;;
  }

  measure: case_count {
    type: sum
    label: "Macro Case Count"
  }

  dimension: macro {
    type: string
  }

}

view: twitter_subcategory {

  sql_table_name: `sc-analytics.report_customer_ops.twitter_subcategory` ;;

  dimension_group: tweet_date {
    type: time
    sql: CAST(${TABLE}.date AS TIMESTAMP) ;;
  }

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.date,"_pk") ;;
  }

  measure: case_count {
    type: sum
    label: "Subcategory Case Count"
  }

  dimension: subcategory {
    type: string
  }

}
