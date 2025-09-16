# most active contributor gcheung@snapchat.com
view: snapads_inapp_task_agents {
  derived_table: {
    sql: SELECT
                 th.agentLocation
                ,th.agentType
                ,th.user
          FROM snapchat_task_service_production.TaskHistories th
          WHERE th.agentType IS NOT NULL
          AND {% condition th_created_at %} th.createdAt {% endcondition %}
          GROUP BY 1,2,3
 ;;
  }

  filter: th_created_at {
    label: "Date Range Filter"
    type: date
    default_value: "14 days ago for 14 days"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: agent_location {
    type: string
    sql: ${TABLE}.agentLocation ;;
  }

  dimension: agent_type {
    type: string
    sql: ${TABLE}.agentType ;;
  }

  dimension: user {
    type: string
    primary_key: yes
    sql: ${TABLE}.user ;;
  }

  set: detail {
    fields: [agent_location, agent_type, user]
  }
}
