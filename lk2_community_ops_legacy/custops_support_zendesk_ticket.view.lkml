# most active contributor jbabra@snapchat.com
view: custops_support_zendesk_ticket {
  view_label: "OLD Business Support Zendesk Ticket"
  derived_table: {
    sql:
        SELECT tix.id AS ticket_id
                ,tix.url AS url
                ,tix.type AS type
                ,tix.subject AS subject
                ,tix.raw_subject AS raw_subject
                ,tix.description AS description
                ,tix.status AS status
                ,tix.requester_id AS requester_id
                ,tix.submitter_id AS submitter_id
                ,tix.assignee_id AS assignee_id
                ,tix.group_id AS group_id
                ,tix.category AS category
                ,tix.subcategory AS subcategory
                ,tix.ml_issue_category_l1 AS ml_issue_category_l1
                ,tix.ml_issue_category_l2 AS ml_issue_category_l2
                ,tix.ml_issue_category_l3 AS ml_issue_category_l3
                ,tix.via_channel AS via_channel
                ,cat.field_option_name AS odg_category
                ,sub.field_option_name AS odg_subcategory
                ,tix.device_os_version AS device_os_version
                ,tix.device_marketing_name AS device_marketing_name
                ,tix.device_model AS device_model
                ,tix.snapchat_version_primary AS snapchat_version_primary
                ,tix.snapchat_version_secondary AS snapchat_version_secondary
                ,tix.ticket_form_id AS ticket_form_id
                ,tix.created_at AS created_at
                ,CASE WHEN tix.country IS NULL OR tix.country = '' THEN 'ZZ' ELSE UPPER(tix.country) END AS country
                ,tix.total_time_spent AS total_time_spent
                ,tix.general_support_reason AS general_support_reason
                ,tix.time_spent_last_update AS time_spent_last_update
                ,bz.field_option_name AS business_support_issue_category
                ,IF(tix.business_support_issue_category="",NULL,tix.business_support_issue_category) AS business_support_issue_category_id
                ,tix.tag AS tag
                ,tix.buy_type AS buy_type
                ,tix.ad_type AS ad_type
                ,tix.goal AS goal
                ,tix.bid_strategy AS bid_strategy
                ,tix.external_facing_tool AS external_facing_tool
                ,tix.web_platform AS web_platform
                ,tix.implementation_method AS implementation_method
                ,tix.measurement_vendor AS measurement_vendor
                ,tix.mmp AS mmp
                ,tix.funding_source_type AS funding_source_type
                ,tix.custom_audience_type AS custom_audience_type
                ,tix.targeting_type AS targeting_type
                ,tix.campaign_setting AS campaign_setting
                ,tix.biz_account_access_issue AS biz_account_access_issue
                ,tix.ad_review_task_url AS ad_review_task_url
                ,tix.execution_date AS execution_date
                ,tix.resolution_category AS resolution_category
                ,IF(tix.snap_employee_name="",NULL,tix.snap_employee_name) AS snap_employee_name
                ,IF(tix.snap_employee_email="",NULL,tix.snap_employee_email) AS snap_employee_email
                ,IF(tix.business_unit="",NULL,tix.business_unit) AS business_unit
                ,IF(tix.sales_pod="",NULL,tix.sales_pod) AS sales_pod
                ,IF(tix.sales_product="",NULL,tix.sales_product) AS sales_product
                ,IF(tix.business_name="",NULL,tix.business_name) AS business_name
                ,IF(tix.buy_model="",NULL,tix.buy_model) AS buy_model
                ,IF(tix.business_account_id="",NULL,tix.business_account_id) AS business_account_id
                ,org.name AS organization_name
                ,org.country AS organization_country
                ,CASE WHEN org.country = 'US' THEN 'United States (US)'
                      WHEN org.country = 'GB' THEN 'Great Britain (GB)'
                      WHEN org.country = 'AE' THEN 'United Arab Emirates (AE)'
                      WHEN org.country = 'CA' THEN 'Canada (CA)'
                      WHEN org.country = 'DE' THEN 'Germany (DE)'
                      WHEN org.country = 'NL' THEN 'Netherlands (NL)'
                      WHEN org.country = 'NO' THEN 'Norway (NO)'
                      WHEN org.country = 'AU' THEN 'Australia (AU)'
                      WHEN org.country = 'IN' THEN 'India (IN)'
                      WHEN org.country = 'IE' THEN 'Republic Of Ireland (IE)'
                      WHEN org.country = 'FR' THEN 'France (FR)'
                      WHEN org.country = 'HK' THEN 'Hong Kong (HK)'
                      WHEN org.country = 'NZ' THEN 'New Zealand (NZ)'
                      WHEN org.country = 'KW' THEN 'Kuwait (KW)'
                      WHEN org.country = 'IL' THEN 'Israel (IL)'
                      WHEN org.country = 'SE' THEN 'Sweden (SE)'
                      WHEN org.country = 'SG' THEN 'Singapore (SG)'
                      WHEN org.country = 'ZA' THEN 'South Africa (ZA)'
                      WHEN org.country = 'QA' THEN 'Qatar (QA)'
                      WHEN org.country = 'EG' THEN 'Egypt (EG)'
                      WHEN org.country = 'TR' THEN 'Turkey (TR)'
                      WHEN org.country = 'CH' THEN 'Switzerland (CH)'
                      WHEN org.country = 'CY' THEN 'Cyprus (CY)'
                      WHEN org.country = 'ES' THEN 'Spain (ES)'
                      WHEN org.country = 'SA' THEN 'Saudia Arabia (SA)'
                      WHEN org.country = 'MT' THEN 'Malta (MT)'
                      WHEN org.country = 'AT' THEN 'Austria (AT)'
                      WHEN org.country = 'BE' THEN 'Belgium (BE)'
                      WHEN org.country = 'FI' THEN 'Finland (FI)'
                      WHEN org.country = 'RU' THEN 'Russia (RU)'
                      WHEN org.country = 'JO' THEN 'Jordan (JO)'
                      ELSE org.country
                 END AS organization_country_display
                ,IF(tix.ad_account_id="",NULL,tix.ad_account_id) AS ad_account_id
                ,IF(tix.ghost_mode_url="",NULL,tix.ghost_mode_url) AS ghost_mode_url
                ,form.name AS form_name
                ,group.name as group_name
                ,agent.name as assignee_name
                ,agent.email as agent_email
                ,tms.solved_at
                ,CASE WHEN tix.tag LIKE '%biz_chat_form_account_setup%' THEN 'Account Setup'
                      WHEN tix.tag LIKE '%biz_chat_form_campaign_issue%' THEN 'Ad Campaign Issue'
                      WHEN tix.tag LIKE '%biz_chat_form_ad_reject_clarify%' THEN 'Ad Rejection Clarification'
                      WHEN tix.tag LIKE '%biz_chat_form_billing%' THEN 'Billing & Payments'
                      WHEN tix.tag LIKE '%biz_chat_form_other%' THEN 'Other'
                ELSE NULL
                END as pre_chat_form_category,
        FROM [sc-analytics:report_zendesk.ticket_distinct]  AS tix
          LEFT JOIN ${zendesk_form.SQL_TABLE_NAME} AS form ON form.id = tix.ticket_form_id
          LEFT JOIN ${zendesk_group.SQL_TABLE_NAME} AS group ON group.id = tix.group_id
          LEFT JOIN ${zendesk_agent.SQL_TABLE_NAME} AS agent ON agent.id = tix.assignee_id
          LEFT JOIN
                    (
                        SELECT
                          field_option_value,
                          field_option_name,
                          FROM
                          TABLE_QUERY([sc-analytics:report_zendesk],
                            "table_id IN (SELECT table_id FROM [sc-analytics:report_zendesk.__TABLES__]
                                               WHERE REGEXP_MATCH(table_id, r'^ticket_fields_[0-9]{8}$')
                                               ORDER BY table_id DESC
                                               LIMIT 1)") Group by 1,2)
                              AS bz ON bz.field_option_value = tix.business_support_issue_category
          LEFT JOIN (SELECT ticket_id, solved_at FROM ${zendesk_ticket_metric_sets.SQL_TABLE_NAME}) tms ON tms.ticket_id = tix.id
          LEFT JOIN (
                        SELECT
                          field_option_value,
                          field_option_name,
                          FROM
                            TABLE_QUERY([sc-analytics:report_zendesk],
                              "table_id IN (SELECT table_id FROM [sc-analytics:report_zendesk.__TABLES__]
                                                 WHERE REGEXP_MATCH(table_id, r'^ticket_fields_[0-9]{8}$')
                                                 ORDER BY table_id DESC
                                                 LIMIT 1)") Group by 1,2)
                                  AS cat ON cat.field_option_value = tix.category
          LEFT JOIN (
                        SELECT
                          field_option_value,
                          field_option_name,
                        FROM
                          TABLE_QUERY([sc-analytics:report_zendesk],
                            "table_id IN (SELECT table_id FROM [sc-analytics:report_zendesk.__TABLES__]
                                               WHERE REGEXP_MATCH(table_id, r'^ticket_fields_[0-9]{8}$')
                                               ORDER BY table_id DESC
                                               LIMIT 1)") Group by 1,2)
                                  AS sub ON tix.subcategory = sub.field_option_value
          LEFT JOIN [sc-analytics:prod_metadata_mpp.organization] org ON tix.business_account_id = org.id
        WHERE DATE(tix.created_at) >= '2017-01-01'
         ;;
    }

################################################################################################################################################################################################################################
###Date Dimensions###
################################################################################################################################################################################################################################
    dimension_group: created {
      type: time
      sql: DATE_ADD(${TABLE}.created_at, -8, "HOUR") ;;
    }

    dimension_group: last_solved {
      hidden: yes
      type: time
      sql: DATE_ADD(${TABLE}.solved_at, -8, "HOUR") ;;
    }

    dimension: ticket_age_lifetime {
      type: number
      value_format: "0"
      sql: (TIMESTAMP_TO_SEC(TIMESTAMP(NOW()))-TIMESTAMP_TO_SEC(TIMESTAMP(${created_time})))/60;;
    }

################################################################################################################################################################################################################################
###Standard Ticket Attributes###
################################################################################################################################################################################################################################
    dimension: ticket_id {
      label: "ID"
      group_label: "Ticket Attributes"
      description: "Unique ID given to an individual ticket"
      type: number
      primary_key: yes
      sql: ${TABLE}.ticket_id ;;
    }

    dimension: ticket_url {
      group_label: "Ticket Attributes"
      type: string
      label: "URL"
      description: "Link directly to the ticket in Zendesk"
      sql: CONCAT('https://snapchat.zendesk.com/agent/tickets/',STRING(${TABLE}.ticket_id)) ;;
      html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
    }

    dimension: ticket_type {
      label: "Type"
      description: "Type of ticket, can be a question or a problem"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.type ;;
    }

    dimension: ticket_subject {
      label: "Subject"
      description: "The string value of the Subject line of the ticket"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.subject ;;
    }

    dimension: ticket_status {
      label: "Status"
      description: "The status of the ticket in Zendesk, can be New, Open, Solved, Closed, On-Hold"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.status ;;
    }

    dimension: assignee_name {
      label: "Assigned Agent Name"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.assignee_name ;;
    }

    dimension: group_id {
      label: "Group ID"
      type: number
      group_label: "Ticket Attributes"
      sql: ${TABLE}.group_id ;;
    }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    case_sensitive: no
  }

  dimension: subcategory {
    type: string
    sql: ${TABLE}.subcategory ;;
    case_sensitive: no
  }

# Monkey Learn Output Categories

  dimension: ml_issue_category_l1 {
    type: string
    sql: ${TABLE}.ml_issue_category_l1 ;;
    case_sensitive: no
    group_label: "Monkey Learned Categories"
  }

  dimension: ml_issue_category_l2 {
    type: string
    sql: ${TABLE}.ml_issue_category_l2 ;;
    case_sensitive: no
    group_label: "Monkey Learned Categories"
  }

  dimension: ml_issue_category_l3 {
    type: string
    sql: ${TABLE}.ml_issue_category_l3 ;;
    case_sensitive: no
    group_label: "Monkey Learned Categories"
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
    case_sensitive: no
  }

    dimension: group_name {
      label: "Group Name"
      type: string
      group_label: "Ticket Attributes"
      sql: CASE WHEN ${TABLE}.group_name = "Ad Platform Support" THEN "Ad Product Quality"
                ELSE ${TABLE}.group_name
            END;;
    }

    dimension: via_channel {
      label: "Channel"
      description: "The channel that the ticket came from. Values can be API, Email, Chat"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.via_channel ;;
    }

    dimension: ticket_tags {
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.tag ;;
    }

  dimension: device_os_version {
    type: string
    sql: ${TABLE}.device_os_version ;;
    case_sensitive: no
  }

  dimension: device_marketing_name {
    type: string
    sql: ${TABLE}.device_marketing_name ;;
    case_sensitive: no
  }

  dimension: snapchat_version_primary {
    type: string
    sql: ${TABLE}.snapchat_version_primary ;;
  }

  dimension: snapchat_version_secondary {
    type: string
    sql: ${TABLE}.snapchat_version_secondary ;;
  }


#   dimension: business_support_issue_category {
#     label: "Issue Category: OLD Business Support "
#     type: string
#     group_label: "Ticket Attributes"
#     sql: ${TABLE}.business_support_issue_category;;
#   }

    dimension: pre_chat_form_category {
      label: "Pre-Chat Form Category"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.pre_chat_form_category;;
    }

    dimension: ticket_issue_category {
      label: "Issue Category: Business Support "
      type: string
      group_label: "Ticket Attributes"

      sql: CASE
           WHEN ${ticket_issue_category_id} = "new_-_measurement__general_measurement" THEN "Measurement::First-Party Reporting"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__r_f_lens" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features__mercury_dashboards" THEN "Measurement::First-Party Reporting"
              WHEN ${ticket_issue_category_id} = "new_-_create/publish__creative_publisher" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_-_odg__creation" THEN "CYO::CYO Creation"
              WHEN ${ticket_issue_category_id} = "new_-_odg__general_odg" THEN "CYO::CYO Creation"
              WHEN ${ticket_issue_category_id} = "new_-_measurement__reporting" THEN "Measurement::First-Party Reporting"
              WHEN ${ticket_issue_category_id} = "new_features__snap_select" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features__commercial_attachments" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__snap_ad_to_lens" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features__premium_content_targeting" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features___persisting_app_information" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_-_create/publish__campaign_creation" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features__business_details" THEN "Administrative::Biz Account Setup::Business Details"
              WHEN ${ticket_issue_category_id} = "new_features__moat_auto-tagging" THEN "Measurement::Third-Party Reporting"
              WHEN ${ticket_issue_category_id} = "new_-_odg__multi-fence" THEN "CYO::CYO Adjustments/Visibility"
              WHEN ${ticket_issue_category_id} = "new_features__business_manager" THEN "Administrative::Biz Account Setup::Business Details"
              WHEN ${ticket_issue_category_id} = "new_features__offer_platform" THEN "Administrative::Billing and Payments::Coupons"
              WHEN ${ticket_issue_category_id} = "new_-_manage__general_campaign_management" THEN "Create/Publish::Edit Campaign Settings"
              WHEN ${ticket_issue_category_id} = "new_features__shopify_integration" THEN "Measurement::Pixel::Pixel Implementation"
              WHEN ${ticket_issue_category_id} = "new_features__ad_set_editing" THEN "Create/Publish::Edit Ad Set Settings"
              WHEN ${ticket_issue_category_id} = "new_features__cloning_and_editing" THEN "Create/Publish::Edit Ad Set Settings"
              WHEN ${ticket_issue_category_id} = "new_features__provisional_charge" THEN "Administrative::Billing and Payments::Declined Charge"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__account_recovery" THEN "Administrative::Biz Account Access::Login Troubleshooting"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__general_administrative" THEN "Administrative::Biz Account Setup::Business Details"
              WHEN ${ticket_issue_category_id} = "new_-_manage__editing" THEN "Create/Publish::Edit Ad Set Settings"
              WHEN ${ticket_issue_category_id} = "new_features__entity_limits" THEN "Administrative::Biz Account Setup::Ad Account Settings"
              WHEN ${ticket_issue_category_id} = "new_-_create/publish__general_creation/publishing" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__biz_account_setup" THEN "Administrative::Biz Account Setup::Business Details"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__billing_and_payments__loc" THEN "Administrative::Billing and Payments::Funding Source"
              WHEN ${ticket_issue_category_id} = "cyo__visibility" THEN "CYO::CYO Adjustments/Visibility"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__reach___frequency" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_-_manage__optimization" THEN "Optimization Guidance::Delivery under budget"
              WHEN ${ticket_issue_category_id} = "new_features__estimation_updates" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features__saved_views" THEN "Measurement::First-Party Reporting"
              WHEN ${ticket_issue_category_id} = "create/publish__lens_studio" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_features___placements" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "ad_review__ad_feedback" THEN "Ad Review::General Ad Review"
              WHEN ${ticket_issue_category_id} = "new_features__sam_phone_numbers" THEN "Measurement::Custom Audience"
              WHEN ${ticket_issue_category_id} = "new_features___conversion_gbbs" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_-_odg__annual" THEN "CYO::Annual::CYO Creative Swap"
              WHEN ${ticket_issue_category_id} = "new_features__delivery_status" THEN "Create/Publish::Edit Ad Set Settings"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__looker_dashboard" THEN "Measurement::First-Party Reporting"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__biz_account_access" THEN "Administrative::Biz Account Access::Login Troubleshooting"
              WHEN ${ticket_issue_category_id} = "new_features__target_cost_bidding" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features___managed_table" THEN "Measurement::First-Party Reporting"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__internal_requests" THEN "Other::Internal Access Request"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__story_ads" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_-_administrative__product/feature_inquiry" THEN "Other::Product/Feature Inquiry"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__threshold_billing" THEN "Administrative::Billing and Payments::Funding Source"
              WHEN ${ticket_issue_category_id} = "new_-_other__unclassified" THEN "Other::Product/Feature Inquiry"
              WHEN ${ticket_issue_category_id} = "new_-_new_features__auto-bidding" THEN "Create/Publish::Edit Ad Set Settings"
              WHEN ${ticket_issue_category_id} = "new_features__accelerated_delivery" THEN "Create/Publish::Edit Ad Set Settings"
              WHEN ${ticket_issue_category_id} = "new_-_manage__bulk_tools" THEN "Create/Publish::Campaign Creation"
              WHEN ${ticket_issue_category_id} = "new_features__product_ads" THEN "Create/Publish::Create Creative"
              WHEN ${ticket_issue_category_id} = "new_-_measurement__pixel__pixel_reporting" THEN "Measurement::Pixel::Other"
              WHEN ${ticket_issue_category_id} = "new_-_measurement__pixel__implementation" THEN "Measurement::Pixel::Other"
                ELSE ${ticket_issue_category_id}
            END;;
    }

  dimension: general_support_reason {
    type: string
    sql: CASE
          WHEN ${TABLE}.general_support_reason = 'gs_001' THEN 'Friends::Snaps'
          WHEN ${TABLE}.general_support_reason = 'gs_002' THEN 'Friends::Chats::Saving or Erasing'
          WHEN ${TABLE}.general_support_reason = 'gs_003' THEN 'Friends::Chats::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_004' THEN 'Friends::Calling'
          WHEN ${TABLE}.general_support_reason = 'gs_005' THEN 'Friends::Group Chat'
          WHEN ${TABLE}.general_support_reason = 'gs_006' THEN 'Friends::General UI'
          WHEN ${TABLE}.general_support_reason = 'gs_007' THEN 'Friends::Best Friends'
          WHEN ${TABLE}.general_support_reason = 'gs_008' THEN 'Friends::Friend Emojis'
          WHEN ${TABLE}.general_support_reason = 'gs_009' THEN 'Friends::Snapstreaks::Restoration Request'
          WHEN ${TABLE}.general_support_reason = 'gs_010' THEN 'Friends::Snapstreaks::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_011' THEN 'Friends::Friending'
          WHEN ${TABLE}.general_support_reason = 'gs_012' THEN 'Camera::Capture::Quality'
          WHEN ${TABLE}.general_support_reason = 'gs_013' THEN 'Camera::Capture::Send To Screen'
          WHEN ${TABLE}.general_support_reason = 'gs_014' THEN 'Camera::Capture::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_015' THEN 'Camera::Creative Tools::Multi Snap'
          WHEN ${TABLE}.general_support_reason = 'gs_016' THEN 'Camera::Creative Tools::Captions or Drawing'
          WHEN ${TABLE}.general_support_reason = 'gs_017' THEN 'Camera::Creative Tools::Stickers'
          WHEN ${TABLE}.general_support_reason = 'gs_018' THEN 'Camera::Creative Tools::Filters'
          WHEN ${TABLE}.general_support_reason = 'gs_019' THEN 'Camera::Creative Tools::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_020' THEN 'Camera::Lenses::Availability'
          WHEN ${TABLE}.general_support_reason = 'gs_021' THEN 'Camera::Lenses::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_022' THEN 'Camera::Shazam'
          WHEN ${TABLE}.general_support_reason = 'gs_023' THEN 'Discover::Stories::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_024' THEN 'Discover::Stories::Content'
          WHEN ${TABLE}.general_support_reason = 'gs_025' THEN 'Discover::Stories::Subscriptions'
          WHEN ${TABLE}.general_support_reason = 'gs_026' THEN 'Discover::General UI'
          WHEN ${TABLE}.general_support_reason = 'gs_027' THEN 'Profile::Trophies or Snapscore'
          WHEN ${TABLE}.general_support_reason = 'gs_028' THEN 'Profile::Stories::My Story'
          WHEN ${TABLE}.general_support_reason = 'gs_029' THEN 'Profile::Stories::Our Story'
          WHEN ${TABLE}.general_support_reason = 'gs_030' THEN 'Profile::Stories::Custom Story'
          WHEN ${TABLE}.general_support_reason = 'gs_031' THEN 'Profile::Settings::Privacy Settings'
          WHEN ${TABLE}.general_support_reason = 'gs_032' THEN 'Profile::Settings::Other'
          WHEN ${TABLE}.general_support_reason = 'gs_033' THEN 'Profile::Insights'
          WHEN ${TABLE}.general_support_reason = 'gs_034' THEN 'Profile::Snapcode'
          WHEN ${TABLE}.general_support_reason = 'gs_035' THEN 'Memories::Editing Content'
          WHEN ${TABLE}.general_support_reason = 'gs_036' THEN 'Memories::Viewing Content'
          WHEN ${TABLE}.general_support_reason = 'gs_037' THEN 'Memories::Lost Memories::Unintentional'
          WHEN ${TABLE}.general_support_reason = 'gs_038' THEN 'Memories::Lost Memories::Self-Deleted'
          WHEN ${TABLE}.general_support_reason = 'gs_039' THEN 'Memories::My Eyes Only'
          WHEN ${TABLE}.general_support_reason = 'gs_040' THEN 'Memories::Exporting Content'
          WHEN ${TABLE}.general_support_reason = 'gs_041' THEN 'Memories::Saving Content'
          WHEN ${TABLE}.general_support_reason = 'gs_042' THEN 'Search'
          WHEN ${TABLE}.general_support_reason = 'gs_043' THEN 'Maps::General'
          WHEN ${TABLE}.general_support_reason = 'gs_044' THEN 'Maps::Location Inquiry'
          WHEN ${TABLE}.general_support_reason = 'gs_045' THEN 'Account::Username'
          WHEN ${TABLE}.general_support_reason = 'gs_046' THEN 'Account::Display Name'
          WHEN ${TABLE}.general_support_reason = 'gs_047' THEN 'Account::Birthday'
          WHEN ${TABLE}.general_support_reason = 'gs_048' THEN 'Account::Login'
          WHEN ${TABLE}.general_support_reason = 'gs_049' THEN 'Account::Information Request::GDPR or Download My Data'
          WHEN ${TABLE}.general_support_reason = 'gs_050' THEN 'Account::Information Request::Snaps, Chats, and Stories'
          WHEN ${TABLE}.general_support_reason = 'gs_051' THEN 'Account::Official Story Request'
          WHEN ${TABLE}.general_support_reason = 'gs_052' THEN 'Bitmoji'
          WHEN ${TABLE}.general_support_reason = 'gs_053' THEN 'Other::Advertisements'
          WHEN ${TABLE}.general_support_reason = 'gs_054' THEN 'Other::Snapcash'
          WHEN ${TABLE}.general_support_reason = 'gs_055' THEN 'Other::Unclassified'
          WHEN ${TABLE}.general_support_reason = 'gs_056' THEN 'Other::Snap Camera'
          WHEN ${TABLE}.general_support_reason = 'gs_057' THEN 'Other::Notifications'
          WHEN ${TABLE}.general_support_reason = 'gs_058' THEN 'Other::Beta'
          WHEN ${TABLE}.general_support_reason = 'gs_059' THEN 'Account::Deactivation'
          WHEN ${TABLE}.general_support_reason = 'gs_060' THEN 'Profile::General UI'
          WHEN ${TABLE}.general_support_reason = 'gs_061' THEN 'Games:: First Party Games Gameplay'
          WHEN ${TABLE}.general_support_reason = 'gs_062' THEN 'Games::First Party Games Chat'
          WHEN ${TABLE}.general_support_reason = 'gs_063' THEN 'Games::Third Party Games Gameplay'
          WHEN ${TABLE}.general_support_reason = 'gs_064' THEN 'Games:: Third Party Games Chat'
          WHEN ${TABLE}.general_support_reason = 'gs_065' THEN 'Games::Availability'
          WHEN ${TABLE}.general_support_reason = 'gs_066' THEN 'Games::Other'
          ELSE null
          END;;
    case_sensitive: no
  }


    dimension: ticket_issue_category_id {
      label: "Issue Category: Business Support ID"
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.business_support_issue_category_id ;;
    }

    dimension: ticket_organization_id {
      group_label: "Ticket Attributes"
      label: "Organization ID"
      description: "Organization ID that is determined through authentication in Ads Maanger. This field is mostly populated for chat tickets currently."
      type: string
      sql: ${TABLE}.business_account_id ;;
    }

    dimension: organization_name {
      group_label: "Ticket Attributes"
      label: "Organization Name"
      description: "Organization Name that is determined through authentication in Ads Maanger. This field is mostly populated for chat tickets currently."
      type: string
      sql: ${TABLE}.organization_name ;;
    }

  dimension: organizationcountry {
    group_label: "Ticket Attributes"
    label: "Organization Country"
    description: "Organization Country that is determined through authentication in Ads Maanger. This field is mostly populated for chat tickets currently."
    type: string
    sql: ${TABLE}.organization_country ;;
  }

  dimension: organization_country_display {
    group_label: "Ticket Attributes"
    label: "Organization Country Display"
    type: string
    sql: ${TABLE}.organization_country_display ;;
  }

    dimension: odg_category {
      label: "Issue Category: ODG Category"
      group_label: "Ticket Attributes"
      type: string
      sql: ${TABLE}.odg_category ;;
    }

    dimension: odg_subcategory {
      label: "Issue Category: ODG Subcategory"
      group_label: "Ticket Attributes"
      type: string
      sql: ${TABLE}.odg_subcategory ;;
    }

    dimension: ticket_calculated_source {
      group_label: "Ticket Attributes"
      description: "A custom SQL query to determine if a ticket was a General Email Submission, Sales Form Submission, Online Chats, or Missed Chats"
      type: string
      sql: CASE WHEN ${ticket_tags} LIKE '%zopim_chat%' AND ${ticket_tags} NOT LIKE '%zopim_chat_missed%' AND ${via_channel} = 'chat' THEN "Online Chat"
                WHEN (${ticket_tags} LIKE '%zopim_offline_message%' OR ${ticket_tags} LIKE '%zopim_chat_missed%')  AND ${via_channel} = 'chat' THEN "Offline Chat"
                WHEN ${ticket_tags} NOT LIKE '%zopim%' AND ${via_channel} != 'chat' AND (${ticket_form} = 'BHC: General Support (Updated)' OR ${ticket_form} = 'BHC: Advertiser Request (Updated)') THEN "Advertiser Form"
                WHEN ${ticket_tags} LIKE '%ghost-mode-sales-ticket-form%' AND ${via_channel} != 'chat'  THEN "Ghost Mode Sales Form"
                WHEN (${ticket_tags} NOT LIKE '%zopim%' OR ${ticket_tags} NOT LIKE '%ghost-mode-sales-ticket-form%') AND ${via_channel} != 'chat' AND ${ticket_form} = 'BHC: Hidden Sales Form' THEN "Sales Form"
                ELSE "Other Source"
           END;;
    }

  dimension: is_ghost_mode_form {
    description: "Is the ticket coming from ghost mode form"
    group_label: "Ticket Attributes"
    type: string
    sql: CASE WHEN ${ticket_tags} LIKE '%ghost-mode-sales-ticket-form%' AND ${via_channel} != 'chat' THEN "Ghost Mode Sales Form"
           ELSE "Other"
           END;;
  }

dimension: sales_or_advertiser {
  group_label: "Ticket Attributes"
  description: "Is it Sales or Advertiser contact"
  type: string
  sql: CASE
  WHEN (${ticket_calculated_source} = "Online Chat" OR ${ticket_calculated_source} = "Offline Chat" OR ${ticket_calculated_source} = "Advertiser Form" OR ${ticket_calculated_source} = "Other Source") THEN "Advertiser Contact"
  WHEN (${ticket_calculated_source} = "Sales Form" OR  ${ticket_calculated_source} = "Ghost Mode Sales Form") THEN "Sales Contact"
  ELSE "Other"
  END;;
}

  dimension: ticket_calculated_group {
    group_label: "Ticket Attributes"
    description: "Determine if a ticket was a solved by Tier 1/V2/2, Pixel or APQ"
    type: string
    sql: CASE WHEN ${group_id} = 360000252243 THEN "1- Business Support L1 (Accenture)"
              WHEN ${group_id} = 360000489803 THEN "2 - Business Support VL2 (Accenture)"
              WHEN ${group_id} = 24929186 AND ${ticket_tags} NOT LIKE "%route_tech_support%" THEN "3 - Business Support L2 (FTE)"
              WHEN ${group_id} = 360000300043 OR (${group_id} IN (360000252243, 24929186, 360000351683, 27913686, 360000300043) AND ${ticket_tags} LIKE "%route_tech_support%") THEN "4 - Ad Product Quality"
              WHEN ${group_id} = 360000351683 THEN "5- Pixel Support (Accenture)"
              ELSE "Other Group"
           END;;
  }


    dimension: is_email_or_chat{
      group_label: "Ticket Attributes"
      type: string
      description: "Is the ticket a chat or an email contact. Missed chats that are handled as email contacts are categorized as email contacts"
      sql: CASE WHEN ${ticket_calculated_source} = "Online Chat" THEN "Chat"
           ELSE "Email"
           END;;
    }

    dimension: ticket_tag_jira_ticket_id {
      group_label: "Ticket Attributes"
      type: string
      sql: CASE WHEN tix.tag LIKE '%ads%' AND tag NOT LIKE "%ads-other%"THEN CONCAT("ADS-",SUBSTR(REGEXP_EXTRACT(tag, r'ads-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%bro%' THEN CONCAT("BRO-",SUBSTR(REGEXP_EXTRACT(tag, r'bro-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%create%' AND tag NOT LIKE "%create-a-bus%" THEN CONCAT("CREATE-",SUBSTR(REGEXP_EXTRACT(tag, r'create-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%cur%' THEN CONCAT("CUR-",SUBSTR(REGEXP_EXTRACT(tag, r'cur-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%datp%' THEN CONCAT("DATP-",SUBSTR(REGEXP_EXTRACT(tag, r'datp-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%deli%' THEN CONCAT("DELI-",SUBSTR(REGEXP_EXTRACT(tag, r'deli-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%maps%' AND tag NOT LIKE "%maps-other%" THEN CONCAT("MAPS-",SUBSTR(REGEXP_EXTRACT(tag, r'maps-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%mes%' THEN CONCAT("MES-",SUBSTR(REGEXP_EXTRACT(tag, r'mes-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%monp%' THEN CONCAT("MONP-",SUBSTR(REGEXP_EXTRACT(tag, r'monp-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%opera%' THEN CONCAT("OPERA-",SUBSTR(REGEXP_EXTRACT(tag, r'opera-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%sct%' THEN CONCAT("SCT-",SUBSTR(REGEXP_EXTRACT(tag, r'sct-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%speceng%' THEN CONCAT("SPECENG-",SUBSTR(REGEXP_EXTRACT(tag, r'speceng-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%spt%' THEN CONCAT("SPT-",SUBSTR(REGEXP_EXTRACT(tag, r'spt-([^?&#]*)'), 0,6))
              WHEN tix.tag LIKE '%tools%' THEN CONCAT("TOOLS-",SUBSTR(REGEXP_EXTRACT(tag, r'tools-([^?&#]*)'), 0,6))
              ELSE NULL
          END ;;
    }


  dimension: account_tier {
    description: "Tier 1, 2, 3 or No tier"
    #group_label: "Ticket Attributes"
    sql: CASE WHEN ${ticket_tags} LIKE '%di8iiyoh%'  THEN "Tier 1"
              WHEN ${ticket_tags} LIKE '%iet4aefi%'  THEN "Tier 2"
              WHEN ${ticket_tags} LIKE '%waray7um%'  THEN "Tier 3"
              WHEN ${ticket_tags} LIKE '%tiev5roh%'  THEN "No Tier"
           ELSE "Other"
           END;;
  }

    ### HIDDEN FIELDS - DON'T THINK THEY ARE NECESSARY ###

    dimension: requester_id {
      label: "Ticket Requestor ID"
      hidden: yes
      type: number
      sql: ${TABLE}.requester_id ;;
    }

    dimension: ticket_description {
      description: "The description text from when the ticket was submitted."
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.description ;;
      html: {{ rendered_value }}
        ;;
    }

    dimension: submitter_id {
      label: "Ticket Submitter ID"
      hidden: yes
      type: number
      sql: ${TABLE}.submitter_id ;;
    }


    dimension: country {
      type: string
      hidden: yes
      sql: ${TABLE}.country ;;
    }


    dimension: ticket_form_id {
      type: number
      hidden: yes
      sql: ${TABLE}.ticket_form_id ;;
    }

    dimension: ticket_form {
      type: string
      group_label: "Ticket Attributes"
      sql: ${TABLE}.form_name;;
    }

    dimension: assignee_id {
      label: "Assigned Agent ID"
      hidden: yes
      type: number
      sql: ${TABLE}.assignee_id ;;
    }

    dimension: agent_email {
      label: "Assigned Agent Email"
      type: string
      sql: ${TABLE}.agent_email ;;
    }

################################################################################################################################################################################################################################
###Sales Form Fields###
################################################################################################################################################################################################################################
    dimension: ghost_mode_url {
      group_label: "Sales Form Fields"
      type: string
      sql: ${TABLE}.ghost_mode_url ;;
    }

    dimension: ad_account_id {
      group_label: "Sales Form Fields"
      type: string
      sql: ${TABLE}.ad_account_id ;;
    }

    dimension: snap_employee_name {
      group_label: "Sales Form Fields"
      type: string
      sql: ${TABLE}.snap_employee_name ;;
    }

    dimension: snap_employee_email {
      group_label: "Sales Form Fields"
      type: string
      sql: ${TABLE}.snap_employee_email ;;
    }


    dimension: sales_pod {
      group_label: "Sales Form Fields"
      type: string
      sql: CASE
              WHEN ${TABLE}.sales_pod = "sales-pod_australia" THEN "Australia"
              WHEN ${TABLE}.sales_pod = "sales-pod_automotive" THEN "US Enterprise: Automotive"
              WHEN ${TABLE}.sales_pod = "sales-pod_canada" THEN "Canada"
              WHEN ${TABLE}.sales_pod = "sales-pod_china" THEN "China"
              WHEN ${TABLE}.sales_pod = "sales-pod_cpg" THEN "US Enterprise: CPG"
              WHEN ${TABLE}.sales_pod = "sales-pod_emerging__commerce" THEN "US Emerging: Commerce"
              WHEN ${TABLE}.sales_pod = "sales-pod_energy/travel/business_services" THEN "US Enterprise: Travel, Industrial, Energy"
              WHEN ${TABLE}.sales_pod = "sales-pod_entertainment" THEN "US Enterprise: Entertainment"
              WHEN ${TABLE}.sales_pod = "sales-pod_france" THEN "France"
              WHEN ${TABLE}.sales_pod = "sales-pod_germany" THEN "Germany"
              WHEN ${TABLE}.sales_pod = "sales-pod_government___health" THEN "US Enterprise: Government & Health"
              WHEN ${TABLE}.sales_pod = "sales-pod_israel" THEN "Israel"
              WHEN ${TABLE}.sales_pod = "sales-pod_mena" THEN "MENA"
              WHEN ${TABLE}.sales_pod = "sales-pod_netherlands" THEN "Netherlands"
              WHEN ${TABLE}.sales_pod = "sales-pod_resellers" THEN "Resellers"
              WHEN ${TABLE}.sales_pod = "sales-pod_restaurants" THEN "US Enterprise: Restaurants"
              WHEN ${TABLE}.sales_pod = "sales-pod_retail" THEN "US Enterprise: Retail"
              WHEN ${TABLE}.sales_pod = "sales-pod_smb_uk" THEN "International Emerging: UK"
              WHEN ${TABLE}.sales_pod = "sales-pod_tech" THEN "US Enterprise: Tech"
              WHEN ${TABLE}.sales_pod = "sales-pod_teleco___finserv" THEN "US Enterprise: Telco & Finserv"
              WHEN ${TABLE}.sales_pod = "sales-pod_uk" THEN "UK"

            WHEN ${TABLE}.sales_pod = "sales-pod_scaled" THEN "Scaled Sales"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__uk" THEN "International Emerging: UK"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__n_n" THEN "International Emerging: Nordics & Netherland"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__france" THEN "International Emerging: France"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__apac" THEN "International Emerging: APAC"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__dach" THEN "International Emerging: Dach"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__cee" THEN "International Emerging: CEE"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__incubator" THEN "Emerging: Incubator"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__israel" THEN "International Emerging: Israel"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__mena" THEN "International Emerging: MENA"
            WHEN ${TABLE}.sales_pod = "sales-pod_latam" THEN "Latin America"
            WHEN ${TABLE}.sales_pod = "sales-pod_apps_media___services_tech" THEN "US Emerging: Apps, Media and Services"
            WHEN ${TABLE}.sales_pod = "sales-pod_emerging__apps_media___services" THEN "US Emerging: Apps, Media and Services"
              ELSE ${TABLE}.sales_pod
            END ;;
    }

  dimension: sales_group {
    type: string
    group_label: "Business Dimensions"
    case_sensitive: no
    sql: CASE
           WHEN ${sales_pod} LIKE "%US Enterprise%" THEN "US Enterprise"
           WHEN ${sales_pod} = "Canada" THEN "International Enterprise"
           WHEN ${sales_pod} = "Netherlands" THEN "International Enterprise"
           WHEN ${sales_pod} = "Israel" THEN "International Enterprise"
           WHEN ${sales_pod} = "Australia" THEN "International Enterprise"
           WHEN ${sales_pod} = "UK" THEN "International Enterprise"
           WHEN ${sales_pod} = "MENA" THEN "International Enterprise"
           WHEN ${sales_pod} = "Germany" THEN "International Enterprise"
           WHEN ${sales_pod} = "France" THEN "International Enterprise"
           WHEN ${sales_pod} LIKE "%US Emerging%" THEN "US Emerging"

          WHEN ${sales_pod} LIKE "International Emerging: UK" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: France" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: MENA" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: Israel" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "Emerging: Incubator" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: APAC" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: CEE" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: Dach" THEN "International Emerging"
          WHEN ${sales_pod} LIKE "International Emerging: Nordics & Netherland" THEN "International Emerging"

          WHEN ${sales_pod} LIKE "Scaled Sales" THEN "Scaled"
          WHEN ${sales_pod} LIKE "Resellers" THEN "Resellers"
          ELSE ${sales_pod}
            END  ;;
  }



  dimension: resolution_category {
    type: string
    group_label: "Business Dimensions"
    sql: CASE
    WHEN ${TABLE}.resolution_category = "bs_resolution_education_-_info_available" THEN "Education - Info Available"
    WHEN ${TABLE}.resolution_category = "bs_resolution_education_-_no_info" THEN "Education - No info"
    WHEN ${TABLE}.resolution_category = "bs_resolution_problem" THEN "Problem"
    WHEN ${TABLE}.resolution_category = "bs_resolution_strategy___performance" THEN "Strategy & Performance"
    ELSE ${TABLE}.resolution_category
    END;;
  }

    dimension: sales_product {
      group_label: "Sales Form Fields"
      type: string
      sql: CASE WHEN ${TABLE}.sales_product = "sales_support_snap_ads" THEN "Snap Ads"
              WHEN ${TABLE}.sales_product = "sales_support_odg" THEN "On-Demand Geofilter"
              WHEN ${TABLE}.sales_product = "sales_support_publisher" THEN "Publisher"
              WHEN ${TABLE}.sales_product = "sales_support_ghostmode" THEN "Ghostmode"
              ELSE ${TABLE}.sales_product
          END;;
    }

    dimension: business_name {
      group_label: "Sales Form Fields"
      type: string
      sql: ${TABLE}.business_name ;;
    }

    dimension: buy_model {
      group_label: "Sales Form Fields"
      type: string
      sql: CASE WHEN ${TABLE}.buy_model = "biz_payment_insertion_order" THEN "Reserved"
              WHEN ${TABLE}.buy_model = "biz_payment_self_serve" THEN "Self-Serve"
              ELSE ${TABLE}.buy_model
            END;;
    }

  #"Biz Conditional Fields July 2019"
  dimension: buy_type {
    type: string
    sql: ${TABLE}.buy_type ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: goal {
    type: string
    sql: ${TABLE}.goal ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: bid_strategy {
    type: string
    sql: ${TABLE}.bid_strategy ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: external_facing_tool {
    type: string
    sql: ${TABLE}.external_facing_tool ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: web_platform {
    type: string
    sql: ${TABLE}.web_platform ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: implementation_method {
    type: string
    sql: ${TABLE}.implementation_method ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: measurement_vendor {
    type: string
    sql: ${TABLE}.measurement_vendor ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: mmp {
    type: string
    sql: ${TABLE}.mmp ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: funding_source_type {
    type: string
    sql: ${TABLE}.funding_source_type ;;
    group_label: "Biz Conditional Fields"
  }


  dimension: custom_audience_type {
    type: string
    sql: ${TABLE}.custom_audience_type ;;
    group_label: "Biz Conditional Fields"
  }


  dimension: targeting_type {
    type: string
    sql: ${TABLE}.targeting_type ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: campaign_setting {
    type: string
    sql: ${TABLE}.campaign_setting ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: biz_account_access_issue {
    type: string
    sql: ${TABLE}.biz_account_access_issue ;;
    group_label: "Biz Conditional Fields"
  }

  dimension: ad_review_task_url {
    type: string
    sql: ${TABLE}.ad_review_task_url ;;
    group_label: "Biz Conditional Fields"
  }

################################################################################################################################################################################################################################
###Business Support Specific###
################################################################################################################################################################################################################################
    dimension: is_business_support {
      label: "Is Business Support"
      group_label: "Ticket Workflow Grouping"
      description: "L1, L2, VL2 & Pixel"
      type: yesno
      sql: CASE WHEN ${group_id} = 360000252243 AND ${ticket_tags} NOT LIKE '%odg-l2%'  THEN TRUE    --L1
              WHEN ${group_id} = 24929186 AND ${ticket_tags} NOT LIKE '%odg-l2%'  THEN TRUE    --L2
              WHEN ${group_id} = 360000351683 THEN TRUE     --pixel
              WHEN ${group_id} = 360000489803 AND ${ticket_tags} NOT LIKE '%odg-l2%' THEN TRUE --vl2
              ELSE FALSE
           END
          ;;
    }

    dimension: business_support_volume_exclusion{
      label: "Business Support Volume Inclusion"
      group_label: "Ticket Volume Inclusion"
      type: yesno
      sql: CASE WHEN ${assignee_id} = 919733069 THEN FALSE
                WHEN ${ticket_tags} NOT LIKE '%zopim_chat%' AND ${custops_support_zendesk_metric_sets.count_ticket_replies} = 0 THEN FALSE
                WHEN ${TABLE}.business_support_issue_category_id = "new_-_other__internal_test_ticket" THEN FALSE
                WHEN ${ticket_tags} LIKE '%biz_dupe%' THEN FALSE
                ELSE TRUE
           END;;
    }

################################################################################################################################################################################################################################
###ODG Support Specific###
################################################################################################################################################################################################################################
    dimension: is_odg_support {
      label: "Is ODG Support"
      group_label: "Ticket Workflow Grouping"
      type: yesno
      sql: CASE
              WHEN ${group_id} = 23731746  THEN TRUE   --ODG L1
              WHEN ${group_id} = 24624846 THEN TRUE    --ODG L2
              WHEN ${group_id} = 24929186 AND ${ticket_tags} LIKE '%odg-l2%' THEN TRUE --L2
              ELSE FALSE
           END
          ;;
    }

    dimension: odg_support_volume_inclusion{
      group_label: "Ticket Volume Inclusion"
      type: yesno
      sql: CASE WHEN ${ticket_tags} LIKE '%auto_solve%' THEN FALSE
              WHEN ${ticket_tags} LIKE '%sca-odg-spam%' THEN FALSE
              WHEN ${ticket_tags} LIKE '%odg_duplicate%' THEN FALSE
              WHEN ${ticket_tags} LIKE '%closed_by_merge%' THEN FALSE
              WHEN ${assignee_id} = 3452812363 THEN FALSE
                ELSE TRUE
           END;;
    }

################################################################################################################################################################################################################################
###Ad Product Quality Support Specific###
################################################################################################################################################################################################################################
    dimension: is_ad_product_quality {
      label: "Is Ad Product Quality"
      group_label: "Ticket Workflow Grouping"
      type: yesno
      sql: CASE
                WHEN ${group_id} IN (360000252243, 24929186, 360000351683, 27913686, 360000300043) AND ${ticket_tags} LIKE "%route_tech_support%" THEN TRUE
                WHEN ${group_id} = 360000300043 THEN TRUE
                ELSE FALSE
           END
          ;;
    }

    dimension: apq_support_volume_inclusion{
      hidden: yes
      label: "Ad Product Quality Volume Inclusion"
      group_label: "Ticket Volume Inclusion"
      type: yesno
      sql: CASE WHEN ${ticket_id} IS NOT NULL THEN FALSE
              ELSE TRUE
          END;;
    }


#   dimension: all_support_workflow_volume_inclusion{
#     label: "All Business Support Volume Inclusion"
#     group_label: "Ticket Volume Inclusion"
#     type: yesno
#     sql: CASE WHEN ${ticket_tags} NOT LIKE '%zopim_chat%' AND ${custops_support_zendesk_metric_sets.count_ticket_replies} = 0 THEN FALSE
#               WHEN ${TABLE}.business_support_issue_category_id = 'new_-_other__internal_test_ticket' THEN FALSE
#               WHEN ${assignee_id} = 919733069 THEN FALSE
#               ELSE TRUE
#           END;;
#   }

  dimension: is_all_business_support{
    label: "Is All Business Support"
    group_label: "Ticket Workflow Grouping"
    description: "Includes Business Support L1/VL2/L2 and APQ (excludes ODG)"
    type: yesno
    sql: CASE WHEN ${group_id} = 360000252243 AND ${ticket_tags} NOT LIKE '%odg-l2%'  THEN TRUE --L1
              WHEN ${group_id} = 24929186 AND ${ticket_tags} NOT LIKE '%odg-l2%'  THEN TRUE   --L2
              WHEN ${group_id} = 360000351683 THEN TRUE --Pixel sup
              WHEN ${group_id} = 360000300043 THEN TRUE -- AD PQ
              WHEN ${group_id} = 360000489803 THEN TRUE -- Vl2
              ELSE FALSE
          END;;
  }

################################################################################################################################################################################################################################
### Community Support Group ###
################################################################################################################################################################################################################################

  dimension: is_community_support {
    label: "Is Community Support"
    group_label: "Ticket Workflow Grouping"
    description: "This group includes Feedback, GS L1 & L2, support@support.snapchat.com"
    type: yesno
    sql: CASE WHEN ${group_id} = 23670733  THEN TRUE    --feedback
              WHEN ${group_id} = 23691673 THEN TRUE  --gs L1
              WHEN ${group_id} = 22167859 THEN TRUE  --support@
              WHEN ${group_id} = 360000396943 THEN TRUE  -- gs L2
              ELSE FALSE
           END
          ;;
  }

################################################################################################################################################################################################################################
### Product Quality Support Group ###
################################################################################################################################################################################################################################

  dimension: is_PQ_support {
    label: "Is App Product Quality Support"
    group_label: "Ticket Workflow Grouping"
    description: "This group includes Bugs"
    type: yesno
    sql: CASE WHEN ${group_id} = 23741939  THEN TRUE
              ELSE FALSE
           END
          ;;
  }
################################################################################################################################################################################################################################
### Measures ###
################################################################################################################################################################################################################################
    measure: count_tickets {
      hidden: yes
      type: count_distinct
      sql: count(distinct ${ticket_id},1000000) ;;
      drill_fields: [detail*]
    }

    measure:  count_requesters {
      description: "Unique Requesters"
      type: number
      hidden: yes
      sql: count(distinct ${requester_id},1000000);;
    }


  set: detail {
    fields: [
      ticket_url,
      created_time,
      ticket_subject,
      ticket_description,
      ticket_status,
      category,
      subcategory,
      #ticket_form,
      zendesk_group.name,
      group_name,
      device_os_version,
      device_marketing_name,
      device_model,
      snapchat_version_primary,
      snapchat_version_secondary,
      country,
      ticket_tags

    ]
  }



  }
