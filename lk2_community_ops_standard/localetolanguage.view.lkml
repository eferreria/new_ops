# most active contributor jbabra@snapchat.com
view: localetolanguage {

  sql_table_name: `sc-analytics.report_meta.locale_meta` ;;

  dimension: locale {
    primary_key: yes
  }

  dimension: language {}

  }

view: localetolanguage2 {

  sql_table_name: `sc-analytics.report_meta.locale_meta` ;;

  dimension: locale {
    primary_key: yes
  }

  dimension: language {}

}
