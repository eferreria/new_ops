# most active contributor jbabra@snapchat.com
view: streaks_ticket_initials {

  derived_table: {
    sql: SELECT
            ticket_id,
            group_id,
            group_name,
            form_id,
            form_name,
            issue_category AS issue_category,
            issue_subcategory AS issue_subcategory,
            tags
         FROM TABLE_QUERY([sc-analytics:report_zendesk_snapstreaks],
          "table_id IN (SELECT table_id FROM [sc-analytics:report_zendesk_snapstreaks.__TABLES__]
          WHERE REGEXP_MATCH(table_id, r'^ticket_initials_[0-9]{8}$') ORDER BY table_id DESC LIMIT 1)")
         ;;
  }

  dimension: ticket_id {
    sql: ${TABLE}.ticket_id ;;
    type: number
    primary_key: yes
  }

  dimension: initial_category {
    sql: ${TABLE}.issue_category ;;
    type: string
    case_sensitive: no
  }

  dimension: initial_subcategory {
    sql: ${TABLE}.issue_subcategory ;;
    type: string
    case_sensitive: no
  }

  dimension: initial_group {
    sql: ${TABLE}.group_name ;;
    type: string
    case_sensitive: no
  }

  dimension: initial_group_id {
    sql: ${TABLE}.group_id ;;
    type: string
  }

  dimension: initial_form {
    sql: ${TABLE}.form_name ;;
    type: string
    case_sensitive: no
  }

  dimension: initial_form_id {
    sql: ${TABLE}.form_id ;;
    type: string
  }

  dimension: initial_tags {
    sql: ${TABLE}.tags ;;
    type: string
  }


}
