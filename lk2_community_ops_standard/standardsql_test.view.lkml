# most active contributor jbabra@snapchat.com
view: standardsql_test {
  view_label: "Jas standard"
  derived_table: {
    sql:
         SELECT *
        FROM  `sc-analytics.report_zendesk.zendesk_chat_engagements_*`
        WHERE {% condition date_filter %} TIMESTAMP(PARSE_DATE('%E4Y%m%d', _TABLE_SUFFIX)) {% endcondition %}
    ;;

  }

  filter: date_filter {
    label: "Table Filter"
    description: "Adding this filter will only query specific tables in the YYYYMMDD format. Not adding this filter will query all tables, all time"
    type: date
    convert_tz: no
  }

  dimension_group: timestamp {
  type: time
  timeframes: [date,week,year,month,day_of_week,quarter]
  sql: TIMESTAMP(${TABLE}.timestamp) ;;
  }

dimension: zendesk_ticket_id {
  type: string
  primary_key: yes
}

dimension: agent_name {
  type: string
}

measure: count {
  type: count
}


}


# sql: SELECT
#            *,
#            DATE '2016-11-02' AS _LATEST_DATE,
#            PARSE_DATE('%E4Y%m%d', _TABLE_SUFFIX) AS _DATA_DATE
#          FROM `dataset_name.table_name_with_table_suffix_*`
#         ;;
