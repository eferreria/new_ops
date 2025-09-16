# most active contributor gcheung@snapchat.com
view: custops_business_operations_roster {
    view_label: "Business Support Zendesk Ticket"
    derived_table: {
      sql:
        SELECT name,
               email,
               status,
              location,
              CAST((CASE WHEN is_business_support_core_fte = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_business_support_core_fte,
              CAST((CASE WHEN is_busines_support_senior_specialist_fte = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_busines_support_senior_specialist_fte,
              CAST((CASE WHEN is_business_support_specialist_fte = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_business_support_specialist_fte,
              CAST((CASE WHEN is_business_operations_lead_manager_fte = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_business_operations_lead_manager_fte,
              CAST((CASE WHEN is_shared_services = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_shared_services,
              CAST((CASE WHEN is_ad_product_quality_fte = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_ad_product_quality_fte,
              CAST((CASE WHEN is_onshore_contractor = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_onshore_contractor,
              CAST((CASE WHEN is_accenture_lead = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_accenture_lead,
              CAST((CASE WHEN is_accenture_business_support_agent = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_accenture_business_support_agent,
              CAST((CASE WHEN is_accenture_pixel_agent = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_accenture_pixel_agent,
              CAST((CASE WHEN is_taskus_lead = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_taskus_lead,
              CAST((CASE WHEN is_taskus_agent_odg = 'TRUE' THEN 1 ELSE 0 END) AS BOOLEAN) AS is_taskus_agent_odg
        FROM [sc-analytics:report_customer_ops.business_support_agent_roster]
         ;;
      }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: is_business_support_core_fte {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_business_support_core_fte ;;
  }
  dimension: is_busines_support_senior_specialist_fte {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_busines_support_senior_specialist_fte ;;
  }

  dimension: is_business_support_specialist_fte {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_business_support_specialist_fte ;;
  }
  dimension: is_business_operations_lead_manager_fte {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_business_operations_lead_manager_fte ;;
  }
  dimension: is_shared_services {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_shared_services ;;
  }
  dimension: is_ad_product_quality_fte {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_ad_product_quality_fte ;;
  }

  dimension: is_apq_or_biz_support_fte {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: CASE WHEN ${is_ad_product_quality_fte} OR ${is_business_support_core_fte} THEN TRUE
         ELSE FALSE
        END;;
  }


  dimension: is_onshore_contractor {
    group_label: "Snapchat Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_onshore_contractor ;;
  }
  dimension: is_accenture_lead {
    group_label: "Accenture Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_accenture_lead ;;
  }
  dimension: is_accenture_business_support_agent {
    group_label: "Accenture Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_accenture_business_support_agent ;;
  }
  dimension: is_accenture_pixel_agent {
    group_label: "Accenture Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_accenture_pixel_agent ;;
  }
  dimension: is_taskus_lead {
    group_label: "TaskUs Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_taskus_lead ;;
  }
  dimension: is_taskus_agent_odg {
    group_label: "TaskUs Agent Groupings"
    type: yesno
    sql: ${TABLE}.is_taskus_agent_odg ;;
  }

}
