# most active contributor gcheung@snapchat.com
view: custops_support_zendesk_qa_sample {
  derived_table: {
    sql:(
        SELECT t.*
        FROM
            (SELECT
                   zendesk_ticket.id    AS zendesk_ticket_id
                  ,zendesk_agent.email  AS zendesk_agent_email
                  ,zendesk_group.name   AS zendesk_group_name
                  ,agent_group.team     AS agent_team
                  ,agent_group.position AS agent_position
                  ,agent_group.subteam_primary AS agent_subteam
                  ,agent_group.fte_contractor_or_vendor_name AS fte_vendor
                  ,RAND()               AS rand
                  ,DATE(DATE_ADD(zendesk_ticket.updated_at, -7, "HOUR")) AS updated_at
                  ,ROW_NUMBER() OVER (PARTITION BY zendesk_agent.email ORDER BY rand)  AS per_agent
            FROM [sc-analytics:report_zendesk.ticket_distinct] AS zendesk_ticket
            LEFT JOIN ${zendesk_agent.SQL_TABLE_NAME} AS zendesk_agent ON zendesk_ticket.assignee_id  = zendesk_agent.id
            LEFT JOIN ${zendesk_group.SQL_TABLE_NAME} AS zendesk_group ON zendesk_ticket.group_id  = zendesk_group.id
            LEFT JOIN ${custops_fte_vendor_users.SQL_TABLE_NAME} AS agent_group ON zendesk_agent.email = agent_group.email
            WHERE zendesk_ticket.status = 'solved'
            AND (zendesk_agent.email IS NOT NULL)
            AND {% condition updated_at %} zendesk_ticket.updated_at {% endcondition %}
            AND {% condition user_name %} zendesk_agent.email {% endcondition %}
            AND {% condition agent_team %} agent_group.team {% endcondition %}
            AND {% condition agent_position %} agent_group.position {% endcondition %}
            AND {% condition agent_subteam %} agent_group.subteam_primary {% endcondition %}
            AND {% condition fte_vendor %} agent_group.fte_contractor_or_vendor_name {% endcondition %}
            GROUP BY 1,2,3,4,5,6,7,8,9,zendesk_agent.email
            ) t
        WHERE {% condition per_agent %} t.per_agent {% endcondition %}
    ) ;;
  }

  filter: per_agent {
    label: "Qty / Agent Filter"
    description: "Provides quantity of records up to the number specified per agent"
    type: number
  }

  filter: updated_at {
    label: "Ticket Date Filter"
    type: date_time
  }

  filter: user_name {
    label: "Ticket Agent Filter"
    type: string
  }

  filter: agent_team {
    label: "Agent Team Filter"
    type: string
  }

  filter: agent_subteam {
    label: "Agent Subteam Filter"
    type: string
  }

  filter: agent_position {
    label: "Agent Position Filter"
    type: string
  }

  filter: fte_vendor {
    label: "FTE/Contractor/Vendor Filter"
    type: string
  }

  dimension: link {
    sql: CONCAT('https://snapchat.zendesk.com/agent/tickets/',STRING(${TABLE}.zendesk_ticket_id)) ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
    can_filter: no
  }

  dimension: id {
    sql: ${TABLE}.zendesk_ticket_id ;;
    label: "ID"
  }

  dimension: zendesk_agent_email {
    sql: ${TABLE}.zendesk_agent_email ;;
    type: string
    can_filter: no
    label: "Agent Email"
  }

  dimension: zendesk_group_name {
    sql: ${TABLE}.zendesk_group_name ;;
    type: string
    can_filter: no
    label: "Group Name"
  }

  dimension: system {
    type: string
    sql: "Zendesk" ;;
  }

  dimension_group: updated_at {
    sql: ${TABLE}.updated_at ;;
    type: time
    can_filter: no
    label: "Updated At"
  }


}
