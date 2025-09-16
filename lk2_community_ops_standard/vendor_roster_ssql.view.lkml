view: vendor_roster_ssql {
  view_label: "Agent Roster"
  sql_table_name: `platform-integrity.vendor_ops.vendor_roster` ;;

    dimension: email {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.email ;;
      type: string
    }

    dimension: workday_id {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_contingent_worker_id ;;
      type: string
      hidden: yes
    }

    dimension: supplier {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_supplier ;;
      type: string
    }

    dimension: cost_center {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_cost_center ;;
      type: string
    }

    dimension: active {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_active ;;
      type: yesno
    }

    dimension: workday_location {
      group_label: "Workday Dimensions"
      label: "Location"
      sql: ${TABLE}.workday_location ;;
      type: string
    }

    dimension: google_permissions {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_google_permissions ;;
      type: string
      hidden: yes
    }

    dimension: end_date {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_end_date ;;
      type: date
    }

    dimension: hire_date {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_hire_date ;;
      type: date
    }

    dimension: preferred_name {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_preferred_name ;;
      type: string
    }

    dimension: title {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_title ;;
      type: string
    }

    dimension: department {
      group_label: "Workday Dimensions"
      sql: ${TABLE}.workday_department ;;
      type: string
    }

    dimension: workday_team {
      label: "Team"
      group_label: "Workday Dimensions"
      sql:  ${TABLE}.workday_team ;;
      type: string
    }

    dimension: updated_at {
      group_label: "Workday Dimensions"
      sql: DATE(${TABLE}.workday_updated_at) ;;
      type: date
    }

    dimension: vendor_name {
      group_label: "Workday Dimensions"
      type: string
      sql: ${TABLE}.vendor_name ;;
      case_sensitive: no
    }

    dimension: name {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_name ;;
      type: string
      hidden: no
    }

    dimension: team {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_team ;;
      type: string
      hidden: no
    }

    dimension: location {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_location ;;
      type: string
      hidden: no
    }

    dimension: position {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_position ;;
      type: string
      hidden: yes
    }

    dimension: language_fulfilled {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_language_fulfilled ;;
      type: string
      hidden: yes
    }

    dimension: subteam_primary {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_subteam_primary ;;
      type: string
      hidden: yes
    }

    dimension: subteams_combined {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_subteams_combined ;;
      type: string
      hidden: yes
    }

    dimension: subteams_ultimate {
      group_label: "GSheet Dimensions"
      description: "All 4 subteams combined"
      sql: ${TABLE}.sheet_subteams_ultimate ;;
      type: string
      hidden: yes
    }

    dimension: team_lead {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_team_lead ;;
      type: string
      hidden: yes
    }

    dimension: billing_date {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_billing_date ;;
      type: date
      hidden: yes
    }

    dimension: start_date {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_start_date ;;
      type: date
      hidden: yes
    }

    dimension: status {
      group_label: "GSheet Dimensions"
      sql: ${TABLE}.sheet_status ;;
      type: string
      hidden: yes
    }

    dimension: is_tenured {
      group_label: "GSheet Dimensions"
      description: "91 days or longer since first Billing Date"
      type: yesno
      hidden: yes
      sql: TIMESTAMP_DIFF(CAST(COALESCE(${TABLE}.sheet_billing_date, ${TABLE}.sheet_start_date) AS TIMESTAMP), NOW(), DAY) ;;
    }

    # CUSTOM


    dimension: fte_or_vendor {
      type: string
      sql: CASE
          WHEN ${email} LIKE '%@c.snap.com%' THEN "Vendor"
          WHEN ${email} LIKE '%@snapchat.com%' THEN "FTE"
          WHEN ${email} LIKE '%@snap.com%' THEN "FTE"
          ELSE NULL
          END
        ;;
      description: "Is the agent full time or vendor"
    }

    dimension: main_vendor_name {
      sql: CASE
              WHEN ${supplier} LIKE '%Accenture%' THEN "Accenture"
              WHEN ${supplier} LIKE '%Vox%' THEN "Voxpro"
              WHEN ${supplier} LIKE '%ZG Subpoena Solutions%' THEN "ZGSS"
              ELSE ${supplier}
             END ;;
      type: string
      case_sensitive: no
      description: "Vendor name extracted from supplier"
    }

    dimension: workflow {
      sql: CASE
              WHEN ${fte_or_vendor}  = "FTE" THEN ${subteams_ultimate}
              WHEN ${supplier} LIKE '%Bus Support L2' OR ${supplier} LIKE '%Bus Support L1' THEN "Business Support"
              WHEN ${supplier} LIKE '%ODG%' THEN "ODG"
              WHEN ${supplier} LIKE '%Community%' THEN "Community Support"
              ELSE ${supplier}
              END ;;
      type: string
      case_sensitive: no
      hidden: yes
      description: "Agent's workflow according to supplier, ex bus support, comm support"
    }

    # dimension: workflow_tier {
    #   sql: CASE
    #           WHEN ${supplier} LIKE '%L2%'  THEN "VL2"
    #           WHEN ${supplier} LIKE '%L1%' THEN "L1"
    #           WHEN ${subteams_ultimate} = "Ad Product Quality" THEN "APQ"
    #           WHEN ${fte_or_vendor}  = "FTE" THEN "L2"
    #           ELSE ${supplier}
    #           END ;;
    #   type: string
    #   case_sensitive: no
    #   hidden: yes
    #   description: "Agent's tier according to supplier, ex L1, L2"
    # }



    measure: count_agents {
      type: count_distinct
      sql: ${TABLE}.email ;;
      drill_fields: [details*]
    }

    set: details {
      fields: [
        email,
        preferred_name,
        department,
        supplier,
        workday_location,
        vendor_name,
        workday_team
      ]
    }
  }
