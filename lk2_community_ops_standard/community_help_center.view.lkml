view: community_help_center {
  derived_table:{
    sql: SELECT * FROM `businesshelpcenteranalytics.analytics_371691264.ga4_unpivot_events`
            WHERE start_date BETWEEN
              CAST({% date_start date_filter %} AS DATE) and CAST({% date_end date_filter %} as DATE)
      ;;
  }

  # sql_table_name: `businesshelpcenteranalytics.analytics_371691264.ga4_unpivot_events` ;;

  filter: date_filter {
    type: date
    default_value: "30 days"
    # sql: ${TABLE}.start_date ;;
  }

    dimension: totals {
      hidden: yes
    }

    dimension: device {
      hidden: yes
    }

    dimension: geoNetwork {
      hidden: yes
    }

    # dimension: hits {
    #   hidden: yes
    # }

    #Dimensions

    dimension: session_id {
      label: "Session ID [ga4]"
      type: string
      sql: CONCAT(${clientId}, "-", ${visit_Number}) ;;
      hidden: yes
    }

    dimension: session_id_ga4 {
      label: "Session ID"
      type: string
      sql: ${TABLE}.sessionId ;;
    }

    dimension: clientId {
      type: string
      label: "Client Id [ga4]"
      sql: ${TABLE}.clientId ;;
      description: "Unhashed version of the Client ID for a given user associated with any given visit/session."
      hidden: yes
    }

    dimension: fullVisitorId {
      type: string
      sql: ${TABLE}.fullVisitorId ;;
      description: "The unique visitor ID."
      label: "Visitor ID [ga4]"
      #hidden: yes
    }

  dimension: visitor_page {
    type: string
    sql: CONCAT(${fullVisitorId}, "|", ${pagepath_raw}) ;;
    hidden: no
  }

    dimension: visit_Number {
      label: "Session Number [ga4]"
      type: string
      sql: CAST(${TABLE}.visitNumber AS STRING) ;;
      description: "The session index for a user. Each session from a unique user will get its own incremental index starting from 1 for the first session. Subsequent sessions do not change previous session indices. For example, if a user has 4 sessions to the website, sessionCount for that user will have 4 distinct values of '1' through '4'."
    }

    dimension: is_first_time_visitor {
      hidden: yes
      type: yesno
      sql: ${visit_Number} = 1 ;;
    }

    dimension: user_type {
      label: "User Type [ga4]"
      description: "Either New User or Returning User, indicating if the users are new or returning."
      sql: CASE
          WHEN ${visit_Number} = "1" THEN "New User"
          ELSE "Returning User"
         END;;
    }

    dimension: visit_number_tier {
      label: "Session Number Tier [ga4]"
      description: "Session Number dimension grouped in tiers between 1-100. See 'Session Number' for full description."
      type: tier
      tiers: [1,2,5,10,15,20,50,100]
      style: integer
      sql: ${visit_Number} ;;
    }

    dimension: visitId {
      label: "visitId [ga4]"
      type: string
      sql: ${TABLE}.visitId ;;
      hidden: yes
      description: "An identifier for this session. This is part of the value usually stored as the _utmb cookie. This is only unique to the user. For a completely unique ID, you should use a combination of fullVisitorId and visitId."
    }

    dimension: date_string {
      label: "Date String"
      type: string
      sql: ${TABLE}.date
      --format_date
      --AS TIMESTAMP))
      ;;
      hidden: no
      description: "The date of the session in YYYYMMDD format."
    }

  dimension: date_hour {
    type: string
    sql: (FORMAT_TIMESTAMP('%F %H', TIMESTAMP_SECONDS(${TABLE}.visitStartTime), 'America/Los_Angeles')) ;;
    hidden: yes
    description: "visit start time hour"
  }

    dimension: thedate {
      type: string
      sql: CAST(PARSE_DATE("%Y%m%d", ${TABLE}.date) AS DATE)  ;;
      hidden: no
    }

    dimension_group: date {
      type: time
      label: "Event [ga4]"
      sql: CAST(${TABLE}.date AS TIMESTAMP) ;;
      description: "The date of the session in YYYYMMDD format."
      convert_tz: no
      timeframes: [date,day_of_month,day_of_week,day_of_week_index,year,week_of_year,quarter_of_year,month_name,month_num, week, month, time, second]
    }

    dimension: pk {
      type: string
      sql: CONCAT(${fullVisitorId}, "|", ${visitId}, "|", ${date_string}) ;;
      primary_key: yes
      description: "The primary key of the community help center view. Concatenating the visitorId, visitId, and date."
      hidden: no
    }

    dimension: hits_pk {
      type: string
      sql: CONCAT(${fullVisitorId}, "|", ${visitId}, "|", ${date_string}, "|", ${TABLE}.visitNumber) ;;
      hidden: yes
    }

    dimension_group: visitStartTime {
      datatype: epoch
      type: time
      label: "Visit Start Time [ga4]"
      timeframes: [date,day_of_month,day_of_week,day_of_week_index,year,week_of_year,quarter_of_year,month_name,month_num, week, month,hour,time,time_of_day,hour_of_day]
      hidden: no
    }

    dimension: visitstarttime_h {
      type: number
      sql: ${TABLE}.visitStartTime ;;
      hidden: yes
    }

  dimension: macro_trigger {
    type: string
    group_label: "Traffic Source"
    label: "Macro / Trigger"
    sql:
    CASE
    WHEN ${traffic_source}="zd" AND ${trafficSource_campaign} LIKE 'm_%' THEN "Macro"
    WHEN ${traffic_source}="zd" AND ${trafficSource_campaign} LIKE 't_%' THEN "Trigger"
    ELSE NULL END
    ;;
    description: "Determines whether the source is a Zendesk Macro (m_) or trigger (t_)"
  }

  dimension: macro_trigger_id {
    type: string
    group_label: "Traffic Source"
    label: "Macro / Trigger ID"
    link: {
      label: "Link"
      url: "{{ community_help_center.macro_trigger_url._value }}"
      icon_url: "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/zendesk-1024.png"
    }
    sql:
    CASE
    WHEN ${macro_trigger} = 'Macro' THEN REPLACE(REGEXP_EXTRACT(${trafficSource_campaign}, r'(m_[^,]*)'),'m_','')
    WHEN ${macro_trigger} = 'Trigger' THEN REPLACE(REGEXP_EXTRACT(${trafficSource_campaign}, r'(t_[^,]*)'),'t_','')
    ELSE NULL END
    ;;
    description: "If the Campaign source of the entrance starts with m_ or t_, this dimension will link out to the corresponding item in Zendesk"
  }

  dimension: macro_trigger_url {
    type: string
    hidden: yes
    group_label: "Traffic Source"
    label: "Macro / Trigger URL"
    link: {
      label: "Link"
      url: "{{ value }}"
      icon_url: "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/zendesk-1024.png"
    }
    sql:
    CASE
    WHEN ${macro_trigger} = 'Macro' THEN concat("https://snapchat.zendesk.com/admin/workspaces/agent-workspace/macros/",${macro_trigger_id})
    WHEN ${macro_trigger} = 'Trigger' THEN concat("https://snapchat.zendesk.com/admin/objects-rules/rules/triggers/",${macro_trigger_id})
    ELSE NULL END
    ;;
    description: "URL"
  }

    dimension: trafficSource_campaign {
      type: string
      group_label: "Traffic Source"
      label: "Campaign [ga4]"
      sql: ${TABLE}.campaign ;;
      description: "The campaign value. Usually set by the utm_campaign URL parameter."
    }

    dimension: trafficSource_isTrueDirect {
      type: yesno
      sql: ${TABLE}.trafficSource.isTrueDirect ;;
      group_label: "Traffic Source"
      label: "is True Direct"
      description: "True if the source of the session was Direct (meaning the user typed the name of your website URL into the browser or came to your site via a bookmark),
      This field will also be true if 2 successive but distinct sessions have exactly the same campaign details. Otherwise NULL."
    }

    dimension: trafficSource_keyword {
      type: string
      sql: ${TABLE}.trafficSource.keyword ;;
      group_label: "Traffic Source"
      label: "Keyword"
      description: "The keyword of the traffic source, usually set when the trafficSource.medium is organic or cpc. Can be set by the utm_term URL parameter."
    }

    dimension: trafficSource_medium {
      type: string
      sql: ${TABLE}.medium ;;
      group_label: "Traffic Source"
      label: "Medium [ga4]"
      description: "The medium of the traffic source."
    }

    dimension: medium_agg {
      type: string
      group_label: "Traffic Source"
      label: "Medium Group [ga4]"
      description: "Aggregated Medium groups."
      sql: CASE
            WHEN ${trafficSource_medium} = '(none)' OR ${trafficSource_medium} = '(not set)' OR ${trafficSource_medium} = 'referral' THEN "(none)"
            WHEN ${trafficSource_medium} = 'cuf' OR ${trafficSource_medium} = 'hc' OR ${trafficSource_medium} = 'kb' THEN "Snapchat Support Site"
            WHEN ${trafficSource_medium} = 'email' OR ${trafficSource_medium} = 'Email' OR ${trafficSource_medium} = 'ml' THEN "Email"
            WHEN ${trafficSource_medium} = 'find_an_app' OR ${trafficSource_medium} = 'how_to_shake' OR ${trafficSource_medium} = 'licenses' OR ${trafficSource_medium} = 'privacy_question' OR ${trafficSource_medium} = 'support' OR ${trafficSource_medium} = 'voice_scan' THEN "In-App Settings"
            WHEN ${trafficSource_medium} = 'ls' OR ${trafficSource_medium} = 'login_help' OR ${trafficSource_medium} = 'invalid_number' THEN "Login Screen"
            WHEN ${trafficSource_medium} = 'organic' THEN "organic"
            WHEN ${trafficSource_medium} = 'chat' THEN "Team Snapchat"
            WHEN ${trafficSource_medium} = 'Tweet' OR ${trafficSource_medium} = 'dm' OR ${trafficSource_medium} = 'pst' THEN "Twitter"
            WHEN ${trafficSource_medium} = 'blog' OR ${trafficSource_medium} = 'cg' OR ${trafficSource_medium} = 'global_header' OR ${trafficSource_medium} = 'global_footer' OR ${trafficSource_medium} = 'bhc' THEN "Snap Website"
            WHEN ${trafficSource_medium} = 'report_problem' OR ${trafficSource_medium} = 'suggestion' THEN "Snapchat for Web"
            WHEN ${trafficSource_medium} = 'copyright' OR ${trafficSource_medium} = 'ip_infringement' OR ${trafficSource_medium} = 'ric' OR ${trafficSource_medium} = 'trademark' THEN "In-App Report"
            WHEN ${trafficSource_medium} = 'insights' OR ${trafficSource_medium} = 'delete_snap' OR ${trafficSource_medium} = 'faq' OR ${trafficSource_medium} = 'info' OR ${trafficSource_medium} = 'lm' OR ${trafficSource_medium} = 'lm_report' OR ${trafficSource_medium} = 'qm' OR ${trafficSource_medium} = 'tdm'  OR ${trafficSource_medium} = 'your_public_profile'  THEN "In-App Learn More"
            ELSE "Other" END;;
    }


    dimension: referralPath {
      type: string
      label: "Referral Path"
      sql: ${TABLE}.trafficSource.referralPath ;;
      description: "If medium is referral, then this is set to the path of the referrer."
      hidden: yes
    }

    dimension: prev_page_path {
      type: string
      label: "Previous Page [ga4]"
      group_label: "Page Sequence"
      sql: ${TABLE}.prev_page_path ;;
    }

    dimension: prev_page_path_type {
      type: string
      label: "Previous Page Type [ga4]"
      group_label: "Page Sequence"

      sql: CASE
            WHEN ${TABLE}.prev_page_path LIKE '%/404%' OR ${TABLE}.prev_page_path LIKE '%404/%' THEN "Error"
            WHEN ${TABLE}.prev_page_path LIKE '%/article/%' OR ${TABLE}.prev_page_path LIKE '%/a/%' OR ${TABLE}.prev_page_path LIKE '%/articles/%' THEN "Article"
            WHEN ${TABLE}.prev_page_path LIKE '%/i-need-help%' OR ${TABLE}.prev_page_path LIKE '%/requests%'  THEN "Contact Us"
            WHEN ${TABLE}.prev_page_path LIKE '%/search%' THEN "Search"
            WHEN ${TABLE}.prev_page_path LIKE '%/success%' THEN "Success"
            WHEN ${TABLE}.prev_page_path LIKE '%/news%' THEN "Whats New"
            WHEN ${TABLE}.prev_page_path LIKE '%/category/%' OR ${TABLE}.prev_page_path LIKE '%/categories/%'  THEN "Category"
            WHEN ${TABLE}.prev_page_path LIKE '%/sections/%'  THEN "Section"
            WHEN ${TABLE}.prev_page_path LIKE '%/preview%' THEN "Other"
            WHEN ${TABLE}.prev_page_path IS NULL THEN NULL
            ELSE "Home Page" END;;
    }

    dimension: middle_page_path {
      type: string
      label: "Middle Page [ga4]"
      group_label: "Page Sequence"
      sql: ${TABLE}.pagepath ;;
    }

    dimension: pagePath_type {
      type: string
      label: "Middle Page Type [ga4]"
      group_label: "Page Sequence"
      sql: CASE
            WHEN ${TABLE}.pagePath LIKE '%/404%' OR ${TABLE}.pagePath LIKE '%404/%' THEN "Error"
            WHEN ${TABLE}.pagePath LIKE '%/article/%' OR ${TABLE}.pagePath LIKE '%/a/%' OR ${TABLE}.pagePath LIKE '%/articles/%' THEN "Article"
            WHEN ${TABLE}.pagePath LIKE '%/i-need-help%' OR ${TABLE}.pagePath LIKE '%/requests%'  THEN "Contact Us"
            WHEN ${TABLE}.pagePath LIKE '%/search%' THEN "Search"
            WHEN ${TABLE}.pagePath LIKE '%/success%' THEN "Success"
            WHEN ${TABLE}.pagePath LIKE '%/news%' THEN "Whats New"
            WHEN ${TABLE}.pagePath LIKE '%/category/%' OR ${TABLE}.pagePath LIKE '%/categories/%'  THEN "Category"
            WHEN ${TABLE}.pagePath LIKE '%/sections/%'  THEN "Section"
            WHEN ${TABLE}.pagePath LIKE '%/preview%' THEN "Other"
            WHEN ${TABLE}.pagePath IS NULL THEN NULL
            ELSE "Home Page" END;;
    }

    dimension: traffic_source {
      type: string
      sql:
          COALESCE(${TABLE}.event_source,
            CASE
              WHEN ${TABLE}.traffic_source IS NULL OR ${TABLE}.traffic_source = 'Data Not Available' THEN ${TABLE}.manual_traffic_source
              ELSE ${TABLE}.traffic_source
            END) ;;
      group_label: "Traffic Source"
      label: "Source [ga4]"
      description: "The source of the traffic source. Could be the name of the search engine, the referring hostname, or a value of the utm_source URL parameter."
    }

  dimension: source_agg {
    type: string
    group_label: "Traffic Source"
    label: "Source Group [ga4]"
    description: "Aggregated Source groups."
    sql: CASE
              WHEN ${traffic_source} = "google" THEN "Google"
              WHEN ${traffic_source} = "bing" THEN "Bing"
              WHEN ${traffic_source} = "(direct)" OR ${traffic_source} = "ios_app" OR ${traffic_source} = "client_from_server" OR ${traffic_source} = "sc" THEN "Direct/In-App"
              WHEN ${traffic_source} = "zd" OR ${traffic_source} LIKE '%zendesk%' THEN "Zendesk"
              WHEN ${traffic_source} LIKE '%snap%' OR ${traffic_source} LIKE '%bitmoji%' THEN "Snap Website"
              WHEN ${traffic_source} = "se" THEN "Other Snap Email"
              WHEN ${traffic_source} = "t.co" OR ${traffic_source} = "sfdc" THEN "Twitter"

          ELSE "Other" END;;
  }

  dimension: traffic_adContent {
    type: string
    sql: ${TABLE}.trafficSource.adContent ;;
    group_label: "Traffic Source"
    label: "Ad Content"
    description: "The first line of each Google Ads ad and the utm_content tags that were used in tagged campaigns."
  }

    dimension: source_medium {
      type: string
      sql: CONCAT(${traffic_source}," / ", ${trafficSource_medium} ) ;;
      label: "Source/Medium"
      group_label: "Traffic Source"
      description: "Distribution of website sessions by the source—how users get to the website.
      The Source/Medium dimension is a combination of 2 dimensions:-
      Source - Name of the search engine, the referring website, or a value of the utm_source URL parameter.
      Medium - Could be organic, cpc, referral, or the value of the utm_medium URL parameter.

      Note - utm_source and utm_medium are custom url parameters and can be set to a custom name to distinguish traffic to our website from any other source.
      Example - utm_source = In-App and  utm_medium = Snap_Original would be custom parameters setup to pinpoint traffic from this source vs any other source. This is done to determine how many visits we get from a custom link we may have provided the end users via email, social media, support channels etc."
    }

    dimension: channel_Grouping {
      type: string
      sql: ${TABLE}.channelGrouping ;;
      group_label: "Traffic Source"
      label: "Channel"
      description: "The Default Channel Group associated with an end user's session for this View."
    }

    dimension: device_browser {
      group_label: "Device"
      label: "Browser [ga4]"
      type: string
      sql: ${TABLE}.browser ;;
      description: "The browser used (e.g., Chrome or Firefox)."
    }

    dimension: browser_type {
      group_label: "Device"
      label: "Browser Type [ga4]"
      type: string
      sql: CASE
        WHEN ${device_browser} LIKE '%Webview%' OR ${device_browser} LIKE '%in-app%' THEN "In-App Webview"
        ELSE "External Browser" END ;;
      description: "Browser is in-app webview or external"
    }

    dimension: device_browserSize {
      type: string
      sql: ${TABLE}.device.browserSize ;;
      description: ""
      hidden: yes
    }

    dimension: browserVersion {
      type: string
      label: "Browser Version [ga4]"
      sql: ${TABLE}.browserVersion ;;
      description: "Browser Version used (e.g., if user's browser was Android Webview, the version could be 126.0.6478.71)"
      hidden: yes
    }

    dimension: device_Category {
      type: string
      sql: ${TABLE}.deviceCategory ;;
      group_label: "Device"
      label: "Device Category [ga4]"
      description: "The type of device (Mobile, Tablet, Desktop)."
    }

    dimension: mobileDeviceInfo {
      type: string
      sql: ${TABLE}.device.mobileDeviceInfo ;;
      group_label: "Device"
      label: "Mobile Device Info"
      description: "The branding, model, and marketing name used to identify the mobile device."
    }

    dimension: mobileDeviceMarketingName {
      type: string
      sql: ${TABLE}.device.mobileDeviceMarketingName ;;
      group_label: "Device"
      label: "Mobile Device Marketing Name"
      description: "The marketing name used for the mobile device."
    }

    dimension: mobileDeviceModel {
      type: string
      sql: ${TABLE}.device.mobileDeviceModel ;;
      group_label: "Device"
      label: "Mobile Device Model"
      description: "The mobile device model."
    }

    dimension: mobileInputSelector {
      type: string
      sql: ${TABLE}.device.mobileInputSelector ;;
      description: "Selector (e.g., touchscreen, joystick, clickwheel, stylus) used on the mobile device."
      group_label: "Device"
      label: "Mobile Input Selector"
    }

    dimension: operatingSystem {
      type: string
      sql: ${TABLE}.operatingSystem ;;
      description: "The operating system of the device (e.g., Macintosh or Windows)."
      group_label: "Device"
      label: "Operating System [ga4]"
    }

    dimension: operatingSystemVersion {
      label: "Operating System Version [ga4]"
      type: string
      sql: ${TABLE}.operatingSystemVersion ;;
      description: ""
      hidden: yes
    }

    dimension: mobileDeviceBranding {
      type: string
      sql: ${TABLE}.device.mobileDeviceBranding ;;
      description: "The brand or manufacturer of the device."
      group_label: "Device"
      label: "Device Brand"
    }

    dimension: device_language {
      type: string
      sql: ${TABLE}.device.language ;;
      description: "The language the device is set to use. Expressed as the IETF language code."
      group_label: "Device"
      label: "Device Locale"
    }

    dimension: language_code {
      type: string
      sql: SUBSTR(${device_language}, 1, 2)  ;;
      group_label: "Device"
      label: "Extracted Language"
      hidden: yes
    }

    dimension: supported_language_user_access_device {
      type: string
      label: "User Device Language Support"
      sql: CASE WHEN
                    ${localetolanguage.language} LIKE '%English%' OR
                    ${localetolanguage.language} LIKE '%Danish%' OR
                    ${localetolanguage.language} LIKE '%German%' OR
                    ${localetolanguage.language} LIKE '%French%' OR
                    ${localetolanguage.language} LIKE '%Italian%' OR
                    ${localetolanguage.language} LIKE '%Dutch%' OR
                    ${localetolanguage.language} LIKE '%Japanese%' OR
                    ${localetolanguage.language} LIKE '%Norwegian%' OR
                    ${localetolanguage.language} LIKE '%Portuguese%' OR
                    ${localetolanguage.language} LIKE '%Finnish%' OR
                    ${localetolanguage.language} LIKE '%Swedish%' OR
                    ${localetolanguage.language} LIKE '%Arabic%' OR
                    ${localetolanguage.language} LIKE '%Spanish%' THEN "Supported"
                            ELSE "Not Supported" END;;
      description: "Reports on whether the Language the user has set on their device is supported by our support site (extracted from device language)"
    }

    dimension: langauge {
      type: string
      sql: ${localetolanguage.language}  ;;
      description: "The full language name the device is set to use."
      group_label: "Device"
      label: "Device Language"
    }

  dimension: localization_2023_langauge {
    type: string
    sql: CASE WHEN
                    ${localetolanguage.language} LIKE '%Turkish%' OR
                    ${localetolanguage.language} LIKE '%Polish%' OR
                    ${localetolanguage.language} LIKE '%Russian%' OR
                    ${localetolanguage.language} LIKE '%Hindi%' OR
                    ${localetolanguage.language} LIKE '%Romanian%' THEN "TBL"
                            ELSE NULL END
      ;;
    description: "TBL - To be Localized. Describes whether the device language is one of the languages included in the 2023 Localization project: Turkish, Polish, Russian, Hindi, or Romanian."
    group_label: "Device"
    label: "To be Localized (2023)"
  }

    dimension: continent {
      type: string
      group_label: "Location"
      label: "Continent"
      sql: ${TABLE}.geoNetwork.continent ;;
      description: "The continent from which sessions originated, based on IP address."
    }

    dimension: subContinent {
      type: string
      sql: ${TABLE}.geoNetwork.subContinent ;;
      description: "The sub-continent from which sessions originated, based on IP address of the visitor."
      group_label: "Location"
      label: "Sub-Continent"
    }

    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
      description: "The country from which sessions originated, based on IP address."
      group_label: "Location"
      label: "Country [ga4]"
      map_layer_name: countries
    }

  dimension: priority_market_country {
    type: yesno
    sql: CASE WHEN ${country} IN ('Spain', 'Italy', 'Brazil', 'Mexico', 'Japan', 'India') THEN TRUE
        ELSE FALSE END ;;
    description: "Growth Priority Markets for 2024: Spain, Italy, Brazil, Mexico, Japan, India"
    group_label: "Location"
    label: "Priority Market"

  }

  dimension: priority_market_country_code {
    type: string
    sql: CASE
            WHEN ${country}='India' THEN "IN"
            WHEN ${country}='Spain' THEN "ES"
            WHEN ${country}='Italy' THEN "IT"
            WHEN ${country}='Brazil' THEN "BR"
            WHEN ${country}='Mexico' THEN "MX"
            WHEN ${country}='Japan' THEN "JP"
            WHEN ${country}='United States' THEN "US"
            ELSE NULL END

    ;;
    description: "2 letter code for Growth Priority Markets for 2024: Spain, Italy, Brazil, Mexico, Japan, India"
    group_label: "Location"
    label: "Priority Market Country Code"

  }


    dimension: region {
      type: string
      sql: ${TABLE}.geoNetwork.region ;;
      group_label: "Location"
      label: "Region"
      description: "The region from which sessions originate, derived from IP addresses. In the U.S., a region is a state, such as New York."
      map_layer_name: us_states
    }

    dimension: metro {
      type: string
      sql: ${TABLE}.geoNetwork.metro ;;
      description: "The Designated Market Area (DMA) from which sessions originate."
      group_label: "Location"
      label: "Metro"
    }

    dimension: city {
      type: string
      sql: ${TABLE}.geoNetwork.city ;;
      description: "Users' city, derived from their IP addresses or Geographical IDs."
      group_label: "Location"
      label: "City"
    }

    dimension: time_on_site {
      hidden: yes
      sql: ${TABLE}.totals.timeonsite ;;
    }

    dimension: time_on_site_tier {
      label: "Session Duration Tiers"
      description: "The length of a session measured in seconds and reported in second increments."
      type: tier
      sql: ${time_on_site} ;;
      tiers: [10,30,60,120,180,240,300,600]
      style: integer
    }

    #Nested columns for - attribution_req_data column

    dimension: hits_page {
      type: number
      sql: ARRAY_TO_STRING(${TABLE}.hits.page, " , ") ;;
      hidden: yes
    }

    # dimension: arkose_challenge_event {
    #   label: "Arkose Challenge Event [ga4]"
    #   type: string
    #   sql: CASE
    #         WHEN ${TABLE}.eventName = 'challenge-suppressed' AND ${hits.eventCategory} = 'Arkose iframe' THEN 'Challenge Suppressed'
    #         WHEN ${TABLE}.eventName = 'challenge-complete' THEN 'Challenge Complete'
    #         WHEN ${TABLE}.eventName = 'challenge-show' THEN 'Challenge Show'
    #         WHEN ${TABLE}.eventName = 'challenge-error' THEN 'Challenge Error'
    #         WHEN ${TABLE}.eventName = 'challenge-warning' THEN 'Challenge Warning'
    #         WHEN ${TABLE}.eventName = 'challenge-hide' THEN 'Challenge Hide'
    #       ELSE null END;;
    #   group_label: "Arkose"
    #   description: "Please see design doc for explanation of events: https://docs.google.com/document/d/1NIUwT7qGOAhv8ARsXTeTKCzRDngvxdaNZGpn3qhYAC4/edit?usp=sharing"
    # }

#########MEASURES#############

    measure: count_sessions {
      label: "Count Sessions [ga4]"
      type: count_distinct
      sql: ${session_id} ;;
      group_label: "Session"
      description: "A session is the period time a user is actively engaged with your website, app, etc."
    }

    measure: count_engaged_sessions {
      label: "Count Engaged Sessions [ga4]"
      type: count_distinct
      group_label: "Session"
      sql: if(CAST(${TABLE}.sessionEngaged AS INT) > 0, ${session_id}, null) ;;
    }

    measure: count_users {
      label: "Count Users [ga4]"
      type: count_distinct
      sql: ${fullVisitorId} ;;
      group_label: "User"
      description: "Users who have initiated at least one session during the date range"
    }

    measure: total_pageviews {
      type: sum
      sql: ${TABLE}.totals.pageviews ;;
      group_label: "Session"
      description: "Total number of pageviews within the session. Use with Session-level dimensions only"
    }

    measure: page_views_session {
      group_label: "Session"
      label: "Pages / Session"
      description: "The average number of pages viewed during a session, including repeated views of a single page."
      type: number
      sql: 1.0 * ${total_pageviews} / NULLIF(${visits_total},0) ;;

      value_format_name: decimal_2
    }

    measure: total_bounces {
      type: sum
      sql: ${TABLE}.bounces ;;
      group_label: "Session"
      description: "Total bounces (for convenience). For a bounced session, the value is 1, otherwise it is null."
    }

    measure: bounce_rate {
      label: "Bounce Rate [ga4]"
      sql: 1-(${count_engaged_sessions}/${count_sessions})
        --(${total_bounces}/${count_sessions})
        ;;
      value_format_name: percent_2
      type: number
      group_label: "Session"
      description: "Bounce rate for any date on or after 6/3/24. Bounce Rate is single-page sessions divided by all sessions, or the percentage of all sessions on your site in which users viewed only a single page"
    }

    measure: bounce_rate_old {
      label: "Bounce Rate Old [ga4]"
      sql: (${total_bounces}/${count_sessions}) ;;
      value_format_name: percent_2
      type: number
      group_label: "Session"
      description: "Bounce rate for any date before 6/3/24. Bounce Rate is single-page sessions divided by all sessions, or the percentage of all sessions on your site in which users viewed only a single page"
    }

    measure: engagement_rate {
      label: "Engagement Rate [ga4]"
      sql: (${count_engaged_sessions}/${count_sessions})
          --(${total_bounces}/${count_sessions})
          ;;
      value_format_name: percent_2
      type: number
      group_label: "Session"
    }


    measure: total_hits {
      type: sum
      sql: ${TABLE}.totals.hits ;;
      group_label: "Session"
      description: "Total number of hits within the session."
    }

    measure: hits_per_session {
      group_label: "Session"
      label: "Hits / Session"
      description: "The average number of hits per session. Includes both PAGE and EVENT hits."
      type: number
      sql: ${total_hits} / NULLIF(${visits_total},0);;

      value_format_name: decimal_2
    }

    measure: total_new_visits {
      type: sum
      sql: ${TABLE}.totals.newVisits ;;
      group_label: "Session"
      description: "Total number of new users in session (for convenience). If this is the first visit, this value is 1, otherwise it is null."
    }

    measure: total_screenviews {
      type: sum
      sql: ${TABLE}.totals.screenviews ;;
      group_label: "Session"
      description: "Total number of screenviews within the session."
    }

    measure: time_on_site_total {
      type: sum
      sql: ${time_on_site};;
      group_label: "Session"
      description: "Raw Total time of the session expressed in seconds."
    }

    measure: timeonsite_total_formatted {
      group_label: "Session"
      label: "Time On Site"
      description: "Total duration of users' sessions in hours."
      type: sum
      sql: ${time_on_site} / 86400;;

      value_format_name: decimal_1
    }

    measure: timeonsite_average_per_session {
      group_label: "Session"
      label: "Avg. Session Duration (s)"
      description: "Total duration of users' sessions in seconds."
      type: number
      sql: (${time_on_site_total} / NULLIF(${visits_total},0));;

      value_format_name: decimal_0
    }

    measure: avg_session_duration_minutes {
      group_label: "Session"
      label: "Avg. Session Duration (m)"
      description: "Total duration of users' sessions in minutes. Example 1.23 is 1 minute 23 seconds"
      type: number
      #sql: ${timeonsite_average_per_session}/60.0 ;;
      value_format_name: decimal_2
      sql:  FLOOR(${timeonsite_average_per_session}/60) + 0.01 * MOD(CAST(${timeonsite_average_per_session} AS INT64), 60) ;;
    }

    measure: visits_total {
      description: "The number of sessions (for convenience). This value is 1 for sessions with interaction events. The value is null if there are no interaction events in the session."
      type: sum
      sql: ${TABLE}.totals.visits;;
      hidden: yes
      #this is same as count sessions
    }

    measure: first_time_visitors {
      description: "The total number of users for the requested time period where the visitNumber equals 1."
      group_label: "User"
      type: count_distinct
      allow_approximate_optimization: yes
      sql: ${fullVisitorId} ;;

      filters: {
        field: visit_Number
        value: "1"
      }

    }

    measure: first_time_sessions {
      group_label: "Session"
      label: "New Sessions"
      description: "The total number of sessions for the requested time period where the visitNumber equals 1."
      type: count_distinct
      allow_approximate_optimization: yes
      sql: ${pk} ;;

      filters: {
        field: visit_Number
        value: "1"
      }

    }

    measure: percent_new_sessions {
      label: "% New Sessions"
      group_label: "Session"
      description: "The percentage of sessions by users who had never visited the property before."
      type: number
      sql: ${first_time_sessions}/NULLIF(${visits_total}, 0) ;;
      value_format_name: percent_1

    }

    measure: percent_new_visitors {
      group_label: "User"
      label: "% New Users"
      description: "The total number of users for the requested time period where the visitNumber is not 1."
      type: number
      sql: ${first_time_sessions} / ${count_users};;

      value_format_name: percent_1
    }

    measure: returning_visitors {
      group_label: "User"
      label: "Returning Users"
      description: "The total number of users for the requested time period where the visitNumber is not 1."
      type: count_distinct
      allow_approximate_optimization: yes
      sql: ${fullVisitorId};;

      filters: {
        field: visit_Number
        value: "-1"
      }
    }

    measure: percent_returning_visitors {
      group_label: "User"
      label: "% Returning Users"
      description: "The total number of users for the requested time period where the visitNumber is not 1."
      type: number
      sql: ${returning_visitors} / ${count_users};;

      value_format_name: percent_1
    }

    measure: sessions_per_user {
      group_label: "User"
      label: "Average Sessions per User"
      description: "(Total Sessions / Unique Visitors). Should only be used at the Session-level."
      type: number
      sql: ${visits_total}/NULLIF(${count_users}, 0) ;;

      value_format_name: decimal_2
    }


    measure: unique_pageviews {
      label: "Unique pageviews [ga4]"
      type: count_distinct
      sql: CONCAT( ${fullVisitorId},"-",CAST(${visit_Number} AS string),"-",CAST(${TABLE}.visitstarttime AS string),"-",${TABLE}.pagepath) ;;
      description: "Unique pageviews combine the pageviews that are from the same person, on the same page, in the same session, and just count them as one.
      Unique pageviews are tracked for each page URL and page title combination."
    }

    dimension: pagepath_raw {
      label: "Pagepath Raw [ga4]"
      type: string
      hidden: no
      sql: ${TABLE}.pagepath ;;
    }

    dimension: visits_total_d {
      type: number
      sql: ${TABLE}.totals.visits;;
      hidden: yes
    }

    # measure: pageview_h {
    #   type: count
    #   filters: [hits.type_of_hit: "PAGE", visits_total_d: "1"  ]
    # }

    # dimension: LastInteraction {
    #   type: number
    #   sql:  MAX(
    #     IF
    #       (${hits.isInteraction} = TRUE ,
    #         ${hits.hitTime} / 1000,
    #         0)) OVER (PARTITION BY ${fullVisitorId}, ${TABLE}.visitstarttime) ;;
    # }

    measure: count_goal_1_cuf_Submission {
      type: number
      group_label: "Goals"
      sql: count(distinct case when regexp_contains(${TABLE}.pagePath,'/success')
            then concat(cast(${fullVisitorId} as string),cast(${visitstarttime_h} as string)) else null end) ;;
      description: "Count of sessions during which Goal 1: CUF submission, was completed"
    }

  measure: count_goal_2_read_articles {
    type: number
    group_label: "Goals"
    sql:   count(distinct case when regexp_contains(${TABLE}.pagePath,'article')
          then concat(cast(${fullVisitorId} as string),cast(${visitstarttime_h} as string)) else null end) ;;
    description: "Count of sessions during which Goal 2: Read an article, was completed"
  }

##########################
#### NEW VIEW - HITS #####
##########################

  }

  view: hits {
  label: "Pages and Events"
  # sql_table_name: `businesshelpcenteranalytics.analytics_371691264.ga4_unpivot_hits_fresh`;;

    derived_table:{
      sql: SELECT * FROM `businesshelpcenteranalytics.analytics_371691264.ga4_unpivot_hits_fresh`
            WHERE start_date BETWEEN
              CAST({% date_start date_filter %} AS DATE) and CAST({% date_end date_filter %} as DATE)
      ;;
    }

    filter: date_filter {
      type: date
      default_value: "30 days"
      # sql: ${TABLE}.start_date ;;
    }

    dimension: id {
      primary_key: yes
        type: string
        sql: CONCAT(${TABLE}.fullVisitorId, "|", ${TABLE}.visitId, "|", ${TABLE}.date, "|", ${TABLE}.visitNumber) ;;
        hidden: no
    }

    dimension: hitSeq {
      sql: ${TABLE}.hitNumber ;;
      type: number
      hidden: no
      description: "Sequence of hits"
      label: "Hit Sequence"
    }

    dimension: hitTime {
      type: number
      sql: ${TABLE}.time ;;
      hidden: yes
    }

    dimension: isInteraction {
      sql:  ${TABLE}.isInteraction  ;;
      hidden: yes
    }

    dimension: page  {
      group_label: "Pages"
      label: "Page URL [ga4]"
      sql: SPLIT(${TABLE}.pagePath , '?')[OFFSET(0)];;
      type: string
      description: "The URL path of the page."
      link: {
        url: "http://{{ value }}"
        label: "Link"
      }
    }

    dimension: pagepath  {
      sql: ${TABLE}.pagePath;;
      type: string
      hidden: no
      label: "Page [ga4]"
      description: "Raw page from GA"
    }

    dimension: pagepath_clean  {
      type: string
      hidden: no
      label: "Page without language marker [ga4]"
      description: "Clean page URL without language markers"
      sql: CASE
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'en-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'da-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'de-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') = "es" THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'fr-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'it-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'nl-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'ja-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'nb-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'pt-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'fi-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'sv-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$') LIKE 'ar-__%' THEN "Main Page"
           ELSE REGEXP_EXTRACT(${pagepath}, r'/([^/]+)/?$')
            END;;
    }

    dimension: is_snapstreak_page {
      label: "Snapstreak Page [ga4]"
      type: yesno
      sql: CASE WHEN ${pagepath} LIKE '%streak%'
                OR ${pagepath} LIKE '%149423%' -- form id for restoration form CUF
                OR ${pagepath} LIKE '%7012318024852%' -- lost my snapstreaks article on ZDG
                OR ${pagepath} LIKE '%7012394193684%' -- what are snapstreaks article on ZDG
                OR ${pagepath} LIKE '%5686234719636%' -- snapstreaks section on ZDG
                OR ${pagepath} LIKE '%5695496404336640%' --start link id for restoration form CUF
                THEN TRUE
        ELSE FALSE END;;
      description: "Whether the page visit was to the two existing Snapstreaks articles, their section, a search for 'streak', or the restoration CUF form"
    }


    dimension: pagePathLevel1 {
      group_label: "Pages"
      label: "Path Level 1 [ga4]"
      type: string
      sql: ${TABLE}.pagePathLevel1 ;;
      description: "This dimension rolls up all the page paths in the 1st hierarchical level in pagePath."
    }

    dimension: pagePathLevel2 {
      group_label: "Pages"
      label: "Path Level 2 [ga4]"
      type: string
      sql: ${TABLE}.pagePathLevel2 ;;
      description: "This dimension rolls up all the page paths in the 2nd hierarchical level in pagePath."
    }

    dimension: pagePathLevel3 {
      group_label: "Pages"
      label: "Path Level 3 [ga4]"
      type: string
      sql: ${TABLE}.pagePathLevel3 ;;
      description: "This dimension rolls up all the page paths in the 3rd hierarchical level in pagePath."
    }

    dimension: pagePathLevel4 {
      group_label: "Pages"
      label: "Path Level 4 [ga4]"
      type: string
      sql: ${TABLE}.pagePathLevel4 ;;
      description: "This dimension rolls up all the page paths in the 4th hierarchical level in pagePath."
    }

    dimension: hostname {
      type: string
      group_label: "Pages [ga4]"
      sql: ${TABLE}.hostname ;;
      description: "The hostname of the URL."
    }

    dimension: site_version {
      label: "Site Version [ga4]"
      type: string
      sql: CASE WHEN ${hostname} LIKE '%help.snapchat.com%' THEN "help-dot"
                WHEN ${hostname} LIKE '%support.snapchat.com%' THEN "support-dot"
                WHEN ${hostname} LIKE '%s.snapchat.com%' THEN "s-dot"
                WHEN ${hostname} LIKE '%wassupsnap%' THEN "wassupsnap"
                WHEN ${hostname} LIKE '%zendesk%' then "snapchat.zendesk"
               ELSE "other" END ;;
      description: "Is support site helo-dot or support-dot"
    }

    dimension: pageTitle {
      type: string
      group_label: "Pages"
      label: "Page Title [ga4]"
      sql: ${TABLE}.pageTitle ;;
      description: "The page title."
    }

    dimension: landing_page_title {
      label: "Landing Page Title [ga4]"
      group_label: "Pages"
      description: "Landing page title for session."
      sql:  CASE
          WHEN ${is_Entrance} is TRUE AND ${type_of_hit} = "PAGE"
                 THEN ${pageTitle}
              END ;;
    }

    dimension: type_of_hit {
      type: string
      label: "Type of hit [ga4]"
      group_label: "Pages"
      description: "The type of hit. One of: PAGE, TRANSACTION, ITEM, EVENT, SOCIAL. In GA4 after June 1st, 2024 EVENT and PAGE are the only types."
      sql: ${TABLE}.type ;;
    }

    dimension: landing_page {
      group_label: "Pages"
      label: "Landing Page [ga4]"
      description: "Landing page for session."
      sql:       CASE
                WHEN ${is_Entrance} is TRUE AND ${type_of_hit} = "PAGE"
                  THEN ${TABLE}.pagePath
              END ;;
              #THEN SPLIT(${page} , '?')[OFFSET(0)]
    }

    dimension: host_plus_landing {
      type: string
      sql: CONCAT("https://",${hostname},${landing_page}) ;;
      hidden: no
      description: "full url including https"
    }

    dimension: host_plus_landing_date {
      type: string
      sql: CONCAT(${host_plus_landing},${community_help_center.thedate}) ;;
      hidden: yes
    }

    dimension: is_Entrance {
      type: yesno
      label: "Entrance [ga4]"
      sql: ${TABLE}.isEntrance ;;
      description: "If this hit was the first pageview or screenview hit of a session, this is set to true. Use to filter for first pageview of a session. Use with Page dimensions."
    }

    dimension: is_Exit {
      type: yesno
      sql: ${TABLE}.isExit ;;
      description: "If this hit was the last pageview or screenview hit of a session, this is set to true."
    }

    dimension: referer {
      type: string
      sql: ${TABLE}.referer ;;
      description: "The referring page, if the session has a goal completion or transaction. If this page is from the same domain, this is blank."
    }

    dimension: referer_website  {
      type: string
      sql: LEFT(NET.REG_DOMAIN(${referer}), STRPOS(NET.REG_DOMAIN(${referer}), ".")-1) ;;
      description: "Website name from where a user comes to our site"
    }

    dimension: seconds_after_visit {
      type: string
      sql: ${TABLE}.time ;;
      description: "The number of milliseconds after the visitStartTime when this hit was registered. The first hit has a hits.time of 0."
    }

    dimension: has_Social_Source_Referral {
      type: string
      sql: ${TABLE}.social.hasSocialSourceReferral ;;
      description: "A string, either Yes or No, that indicates whether sessions to the property are from a social source."
    }

    dimension: search_Keyword {
      label: "Search Keyword [ga4]"
      type: string
      sql:
      CASE
        WHEN ${full_page_url} LIKE '%query=%' THEN
          TRIM(REGEXP_REPLACE( -- Replaces '+' with ' ' for readability
          SUBSTR(${full_page_url}, INSTR(${full_page_url}, 'query=') + 6),
          '\\+', ' '))
        ELSE NULL
      END;;
      description: "The keyword entered in search bar of the page."
    }

    dimension: exit_Screen_Name {
      type: string
      sql: ${TABLE}.appInfo.exitScreenName ;;
      description: "The exit screen of the session."
      link: {
        url: "http://{{ value }}"
        label: "Link"
      }
    }

    dimension: exit_Screen_page {
      type: string
      sql: CASE
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'en-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'da-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'de-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') = "es" THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'fr-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'it-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'nl-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'ja-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'nb-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'pt-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'fi-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'sv-__%' THEN "Main Page"
          WHEN REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$') LIKE 'ar-__%' THEN "Main Page"
           ELSE REGEXP_EXTRACT(${exit_Screen_Name}, r'/([^/]+)/?$')
            END;;
      description: "The exit screen of the session, page only without the language code url."
    }

    dimension: exit_Screen_successpage {
      type: string
      sql: CASE
          WHEN ${exit_Screen_Name} LIKE '%/success%' THEN "Success page exit"
          ELSE "Not success page exit"
            END;;
      description: "Is the exit screen page of the session a success page?"
    }

    dimension: landing_Screen_Name {
      type: string
      sql: ${TABLE}.appInfo.landingScreenName ;;
      description: "The landing screen of the session."
      link: {
        url: "http://{{ value }}"
        label: "Link"
      }
    }

    dimension: event_Category {
      type: string
      sql: ${TABLE}.eventCategory ;;
      description: "The event category. Article or blurb"
      label: "Event Category [ga4]"
    }

    dimension: event_Action {
      label: "Event Action [ga4]"
      type: string
      sql: ${TABLE}.eventAction ;;
      description: "The event action."
    }

    dimension: event_Label {
      label: "Event Label [ga4]"
      type: string
      sql: ${TABLE}.eventLabel ;;
      description: "The event label., eg ARB10"
    }

    dimension: FCP_LCP {
      group_label: "FCP & LCP"
      label: "First/Largest Contentful Paint"
      description: "FCP measures how long it takes for the first piece of content to appear on the screen. LCP measures how long it takes for the largest content element to load. Measured in milliseconds. Filter out null values to only get FCP and LCP events"
      type: string
      sql: CASE
              WHEN ${TABLE}.eventAction = 'FCP' THEN 'FCP'
              WHEN ${TABLE}.eventAction = 'LCP' THEN 'LCP'
            ELSE null
          END;;
    }

    dimension: FCP_LCP_metric_id{
      group_label: "FCP & LCP"
      label: "Metric ID"
      description: "A unique ID, generated by the web-vitals library, representing this particular metric instance."
      type: string
      sql:${TABLE}.metricID;;
    }

    dimension: FCP_LCP_metric_value{
      group_label: "FCP & LCP"
      label: "Metric Value"
      description: "Measuring how long it takes for FCP/LCP content to load in milliseconds."
      type: number
      sql:${TABLE}.metricValue;;
      value_format: "0.0"
    }

    dimension: FCP_LCP_metric_delta{
      group_label: "FCP & LCP"
      label: "Metric Delta"
      description: "The delta between the current value and the last-reported value. On the first report, “delta” and “value” will always be the same. Measured in milliseconds."
      type: number
      sql:${TABLE}.metricDelta;;
    }

    dimension: FCP_LCP_metric_rating{
      group_label: "FCP & LCP"
      label: "Metric Rating"
      description: "The rating as to whether the metric value is within the 'good', 'needs improvement', or 'poor' thresholds of the metric."
      type: string
      sql:${TABLE}.metricRating;;
    }

    dimension: FCP_LCP_metric_nav_type{
      group_label: "FCP & LCP"
      label: "Metric Navigation Type"
      description: "The type of navigation: 'navigate', 'reload', 'back-forward', 'back-forward-cache', 'prerender', 'restore'. This will be the value returned by the Navigation Timing API (or  “undefined” if the browser doesn't support that API)."
      type: string
      sql:${TABLE}.metricNavigationType;;
    }

    measure: avg_metric_value {
      group_label: "FCP & LCP"
      label: "Average Metric Value"
      description: "Average time to load in milliseconds"
      type: average
      sql: CAST(${FCP_LCP_metric_value} AS FLOAT64) ;;
      value_format: "0.0"
    }

    measure: avg_metric_delta {
      group_label: "FCP & LCP"
      label: "Average Metric Delta"
      description: "Average delta in milliseconds"
      type: average
      sql: CAST(${FCP_LCP_metric_delta} AS FLOAT64) ;;
      value_format: "0.0"
    }

    dimension: quick_answer_yesno {
      label: "Quick Answer"
      group_label: "Quick Answer"
      type: yesno
      sql: CASE
            WHEN ${TABLE}.eventCategory = "Quick Answer CSAT"
              OR ${TABLE}.eventCategory = "Quick Answer Search"
              OR ${TABLE}.eventCategory = "Quick Answer Search Results" THEN TRUE
            ELSE FALSE
            END;;
    }

    # dimension: search_input_output {
    #   group_label: "Quick Answer"
    #   label: "Search Label"
    #   type: string
    #   description: ""
    #   sql: CASE
    #         WHEN ${TABLE}.eventAction = 'search_result' THEN "Output"
    #         WHEN ${TABLE}.eventAction = 'search_input' THEN "Input"
    #       ELSE null
    #       END;;
    # }

    dimension: search_input {
      group_label: "Quick Answer"
      label: "Search Input"
      type: string
      sql: ${TABLE}.searchInput
      -- CASE
      --   WHEN ${TABLE}.eventAction = 'search_input' THEN ${TABLE}.eventLabel
      --   ELSE null
      --   END
        ;;
    }

    dimension: search_result {
      group_label: "Quick Answer"
      label: "Search Output"
      type: string
      sql:  ${TABLE}.searchOutput

      --CASE
        --WHEN ${TABLE}.eventAction = 'search_result' THEN ${TABLE}.eventLabel
        --ELSE null END

        ;;
    }

    dimension: source_link {
      group_label: "Quick Answer"
      label: "Source Link"
      type: string
      sql: ${TABLE}.sourceLink;;
    }

    dimension: support_link {
      group_label: "Quick Answer"
      label: "Support Link Shown"
      type: yesno
      sql: CASE WHEN ${TABLE}.supportLink = "true" THEN TRUE
              WHEN ${TABLE}.supportLink = "false" THEN FALSE
              ELSE FALSE END;;
    }

    dimension: yesno_ai_output_quick_answer {
      group_label: "Quick Answer"
      label: "AI Result Output"
      type: yesno
      sql: CASE WHEN ${TABLE}.searchOutput LIKE "%An AI Answer is not available for this search%" THEN FALSE
            --WHEN ${TABLE}.searchOutput LIKE "%Try rephrasing your question with different keywords, or simplifying your question%" THEN FALSE
            WHEN ${TABLE}.searchOutput LIKE "%No relevant information found for query%" THEN FALSE
            ELSE TRUE
          END;;
    }

    measure: count_quick_answer_search {
      label: "Count Search Inputs"
      group_label: "Quick Answer"
      type: count
      # sql: ${TABLE}.searchInput ;;
      filters: [search_input: "-null"]
    }

    measure: count_search {
      label: "Count Search"
      type: number
      sql: COUNT(${search_Keyword}) ;;
    }

    measure: count_quick_answer_search_valid {
      label: "Count Search Inputs Valid"
      description: "Counts search inputs that have a length longer than or equal to 8 characters."
      group_label: "Quick Answer"
      type: sum
      sql: CASE WHEN length(${search_input}) >= 8 THEN 1 ELSE 0 END ;;
      filters: [search_input: "-null"]
    }

    measure: count_quick_answer_search_output {
      label: "Count Search Results"
      group_label: "Quick Answer"
      type: count
      # sql: ${TABLE}.search_result ;;
      filters: [search_result: "-null"]
    }

    measure: count_quick_answer_users {
      label: "Count Users"
      group_label: "Quick Answer"
      type: count_distinct
      sql: ${TABLE}.clientId ;;
      filters: [search_input: "-null"]
      }

    measure: count_quick_answer_csat_yes {
      label: "Count CSAT Yes"
      group_label: "Quick Answer"
      type: count
      filters: [event_Category: "Quick Answer CSAT", event_Label: "Vote: Yes"]
    }

    measure: count_quick_answer_csat_no {
      label: "Count CSAT No"
      group_label: "Quick Answer"
      type: count
      filters: [event_Category: "Quick Answer CSAT", event_Label: "Vote: No"]
    }

    measure: count_quick_answer_no_results {
      label: "Count No Results"
      group_label: "Quick Answer"
      type: count
      filters: [yesno_ai_output_quick_answer: "no"]
    }

    measure: quick_answer_length {
      label: "Search Input Length"
      group_label: "Quick Answer"
      type: number
      sql: length(${search_input}) ;;
      hidden: yes
    }

    measure: quick_answer_length_avg {
      label: "Search Input Length Average"
      group_label: "Quick Answer"
      type: average
      value_format: "0.00"
      sql: length(${search_input}) ;;
    }


    dimension: abbv_error_label {
      label: "Abbreviated Error Label [ga4]"
      type: string
      sql:
      CASE WHEN ${event_Category}="Help Center Error" THEN
      trim(left(${TABLE}.eventLabel, strpos(${TABLE}.eventLabel, "-")),"-")
      ELSE NULL END
      ;;
      description: "abbreviated event label for errors - the text string that comes before the first dash"
    }

    dimension: arkose_challenge_event {
      label: "Arkose Challenge Event [ga4]"
      type: string
      sql: CASE
            WHEN ${TABLE}.eventAction = 'challenge-suppressed' AND ${TABLE}.eventCategory = 'Arkose iframe' THEN 'Challenge Suppressed'
            WHEN ${TABLE}.eventAction = 'challenge-complete' AND ${TABLE}.eventCategory = 'Arkose iframe' THEN 'Challenge Complete'
            WHEN ${TABLE}.eventAction = 'challenge-show' AND ${TABLE}.eventCategory = 'Arkose iframe' THEN 'Challenge Show'
            WHEN ${TABLE}.eventAction = 'challenge-error' AND ${TABLE}.eventCategory = 'Arkose iframe' THEN 'Challenge Error'
            WHEN ${TABLE}.eventAction = 'challenge-warning' AND ${TABLE}.eventCategory = 'Arkose iframe' THEN 'Challenge Warning'
            WHEN ${TABLE}.eventAction = 'challenge-hide' AND ${TABLE}.eventCategory = 'Arkose iframe' THEN 'Challenge Hide'
          ELSE null END;;
      group_label: "Arkose"
      description: "Please see design doc for explanation of events: https://docs.google.com/document/d/1NIUwT7qGOAhv8ARsXTeTKCzRDngvxdaNZGpn3qhYAC4/edit?usp=sharing"
    }

    dimension: arkose_error_code {
      label: "Arkose Error Code [ga4]"
      description: "Critical errors that are preventing challenge from being displayed or solved, such as network issues, configuration errors, etc."
      type: string
      sql: ${TABLE}.errorCode;;
      group_label: "Arkose"
    }

    dimension: arkose_warning_code {
      label: "Arkose Warning Code [ga4]"
      description: "Non-critical issues, that do not prevent challenge from completion such as delayed load"
      type: string
      sql: ${TABLE}.warningCode;;
      group_label: "Arkose"
    }

    dimension: event_label_name {
      type: string
      sql: IF(${chc_blurb.description} IS NULL, ${event_Label}, ${chc_blurb.description}) ;;
      description: "The name of event label., eg Account hacked"
    }

    measure: average_event_Value {
      type: average
      sql: ${TABLE}.eventInfo.eventValue ;;
      description: "The event value score average given when event action is 'rate'."
      value_format_name: decimal_2
    }

    dimension: event_Value {
      type: string
      sql: CASE WHEN ${TABLE}.eventInfo.eventValue = -1 THEN "Yes"
              WHEN ${TABLE}.eventInfo.eventValue = 1 THEN "No"
              ELSE null END;;
    }

    dimension: CUF_event_label {
      type: string
      group_label: "Tap to Expand Selection"
      label: "CUF Selections"
      sql: CASE WHEN ${TABLE}.eventCategory = 'Tap to Expand' AND ${TABLE}.sectionLocation = 'CUF' THEN ${TABLE}.eventLabel
            ELSE null
          END;;
    }

    dimension: CUF_parent_label {
      type: string
      label: "CUF Parent Node"
      sql: CASE WHEN ${TABLE}.eventCategory = 'Tap to Expand' AND ${TABLE}.sectionLocation = 'CUF' THEN
            CASE
              WHEN ${TABLE}.parentNode = 'CANT_ACCESS_ACCOUNT' THEN "I can't access my account"
              WHEN ${TABLE}.parentNode = 'NEED_HELP_WITH_FEATURE' THEN 'I need help with a Snapchat feature'
              WHEN ${TABLE}.parentNode = 'FOUND_A_BUG' THEN 'Something is broken with my Snapchat app'
              WHEN ${TABLE}.parentNode = 'REPORT_ACCOUNT_OR_CONTENT' THEN 'I want to report an account or content'
              WHEN ${TABLE}.parentNode = 'PRIVACY_QUESTIONS' THEN 'I have a question about data privacy or digital platform laws'
              WHEN ${TABLE}.parentNode = 'LOST_MY_SNAPSTREAK' THEN 'I lost my Streak'
              WHEN ${TABLE}.parentNode = 'REPORT_IP_INFRINGEMENT' THEN 'I want to report intellectual property infringement'
              WHEN ${TABLE}.parentNode = 'DEACTIVATE_OR_DELETE_ACCOUNT' THEN 'I want to deactivate or delete my account'
              WHEN ${TABLE}.parentNode = 'MY_ACCOUNT_IS_COMPROMISED' THEN 'I think my account was compromised'
            ELSE ${TABLE}.parentNode
            END
          END;;
    }

    # dimension: article_event_label {
    #   type: string
    #   group_label: "Tap to Expand Selection"
    #   label: "Article Selections"
    #   sql: CASE WHEN ${TABLE}.eventCategory = 'Tap to Expand' AND ${TABLE}.sectionLocation = 'Article' THEN ${TABLE}.eventLabel
    #         ELSE null
    #       END;;
    # }

    measure: count_distinct_search_terms {
      type: count_distinct
      sql: ${search_Keyword} ;;
      description: "Count of unique search terms searched per session by a visitor"
    }

    measure: count_yes {
      type: count
      label: "Count Yes event value"
      #sql: ${event_count} ;;
      filters: [event_Value: "Yes", type_of_hit: "EVENT"]
    }

    measure: count_no {
      type: count
      label: "Count No event value"
      # sql: ${event_count} ;;
      filters: [event_Value: "No", type_of_hit: "EVENT"]
    }

    measure: percent_yes {
      sql: ${count_yes}/NULLIF(${event_count}, 0) ;;
      type: number
      value_format_name: percent_0
      label: "% Yes event value"
    }

    measure: percent_no {
      sql: ${count_no}/NULLIF(${event_count}, 0) ;;
      type: number
      value_format_name: percent_0
      label: "% No event value"
    }

    dimension: full_event {
      description: "Concatenation of Event Category, Event Label, Event Action, and Page URL. Each are only included if there is a value."
      type: string
      label: "Full Event URL"
      sql: CONCAT(
          IF(${event_Category} IS NOT NULL, CONCAT(${event_Category}, " -> "), "")
          , IF(${event_Action} IS NOT NULL, CONCAT(${event_Action}, " -> "), "")
          , IF(${event_Label} IS NOT NULL, CONCAT(${event_Label}, " -> "), "")
          , IF(${page} IS NOT NULL, CONCAT( ${full_page_url}), "")
        );;

        link: {
          label: "Go to Page"
          url: "https://{{ full_page_url }}"
        }

      }

      dimension: full_event_page {
        description: "Concatenation of Event Category, Event Label, Event Action, and Page. Each are only included if there is a value."
        type: string
        label: "Full Event Page"
        sql: CONCAT(
          IF(${event_Category} IS NOT NULL, CONCAT(${event_Category}, " -> "), "")
          , IF(${event_Action} IS NOT NULL, CONCAT(${event_Action}, " -> "), "")
          , IF(${event_label_name} IS NOT NULL, CONCAT(${event_label_name}, ""), "")
        );;

        }

        dimension: full_page_url {
          group_label: "Pages"
          label: "Full Page URL [ga4]"
          description: "The full URL including the hostname and path."
          type: string
          sql: ${TABLE}.full_page_url;;

          link: {
            label: "Go to Page"
            url: "https://{{ value }}"
          }
        }

    dimension: landing_page_type {
      group_label: "Pages"
      label: "Landing Page Type"
      description: "Buckets for all landing pages into general categories: Article, Contact Us page, Search Page, Success Page, Error 404 Page, Whats New Page, Category Page, Main Page."
      type: string
      sql: CASE
                    WHEN ${landing_page} LIKE '%/404' THEN "Error"
                    WHEN ${landing_page} LIKE '%/article/%' OR ${landing_page} LIKE '%/a/%' OR ${landing_page} LIKE '%/articles/%' THEN "Article"
                    WHEN ${landing_page} LIKE '%/i-need-help%' OR ${landing_page} LIKE '%/requests%'  THEN "Contact Us"
                    WHEN ${landing_page} LIKE '%/search%' THEN "Search"
                    WHEN ${landing_page} LIKE '%/success%' THEN "Success"
                    WHEN ${landing_page} LIKE '%/news%' THEN "Whats New"
                    WHEN ${landing_page} LIKE '%/category/%' OR ${landing_page} LIKE '%/categories/%'  THEN "Category"
                    WHEN ${landing_page} LIKE '%/sections/%'  THEN "Section"
                    WHEN ${landing_page} LIKE '%/preview%' THEN "Other"
                    ELSE "Home Page" END;;
    }

    dimension: exit_page_type {
      group_label: "Pages"
      label: "Exit Page Type"
      description: "Buckets for all exit pages into general categories: Article, Contact Us page, Search Page, Success Page, Error 404 Page, Whats New Page, Category Page, Main Page."
      type: string
      sql: CASE
                    WHEN ${exit_Screen_Name} LIKE '%/404' THEN "Error"
                    WHEN ${exit_Screen_Name} LIKE '%/article/%' OR ${exit_Screen_Name} LIKE '%/a/%' OR ${exit_Screen_Name} LIKE '%/articles/%' THEN "Article"
                    WHEN ${exit_Screen_Name} LIKE '%/i-need-help%' OR ${exit_Screen_Name} LIKE '%/requests%'  THEN "Contact Us"
                    WHEN ${exit_Screen_Name} LIKE '%/search%' THEN "Search"
                    WHEN ${exit_Screen_Name} LIKE '%/success%' THEN "Success"
                    WHEN ${exit_Screen_Name} LIKE '%/news%' THEN "Whats New"
                    WHEN ${exit_Screen_Name} LIKE '%/category/%' OR ${exit_Screen_Name} LIKE '%/categories/%'  THEN "Category"
                    WHEN ${exit_Screen_Name} LIKE '%/sections/%'  THEN "Section"
                    WHEN ${exit_Screen_Name} LIKE '%/preview%' THEN "Other"
                    ELSE "Home Page" END;;
    }


        dimension: page_type {
          group_label: "Pages"
          label: "Page Type [ga4]"
          description: "Buckets for all webvies into general categories: Article, Contact Us page, Search Page, Success Page, Error 404 Page, Whats New Page, Category Page, Main Page."
          type: string
          sql: ${TABLE}.pageType ;;
        }

        dimension: cuf_type {
          group_label: "Pages"
          label: "CUF Type"
          description: "Distinguishes between Contact Us page visits to 'start' links (ex /hc/en-us/requests/new?start=5779421190160384), 'form id' links (ex /hc/en-us/requests/new?ticket_form_id=76586), and main CUF (ex /hc/en-us/requests/new)."
          type: string
          sql: ${TABLE}.cufType;;
        }

        dimension: page_id {
          group_label: "Pages"
          label: "Page ID [ga4]"
          description: "A unique ID derived from the URL (independent of language variants); in support-dot, this is the unique slug of the page; in help-dot, it is the numerical ID for the property; for forms, it is either the start link or form ID"
          type: string
          sql: CASE
                WHEN ${cuf_type} = "ticket_form_id=" AND ${pagepath} LIKE '%co=true%' THEN SUBSTRING(${pagePathLevel4}, 29, 50)
                WHEN ${cuf_type} = "ticket_form_id=" THEN SUBSTRING(${pagePathLevel4}, 21, 50)
                WHEN ${cuf_type} = "start=" THEN right(${pagepath}, 16)
                WHEN ${pagepath} LIKE '%infringement-copyright?%' THEN "infringement-copyright"
                WHEN ${pagepath} LIKE '%infringement-trademark?%' THEN "infringement-trademark"
                WHEN ${page_type} = "Article" and ${site_version} != "help-dot" THEN substring(${pagePathLevel3}, 2, 50)
                WHEN ${page_type} in ('Article', 'Section', 'Category') AND SUBSTRING(SUBSTRING(${pagePathLevel4}, 2, 14), 14, 1) IN ("-","?","#") THEN SUBSTRING(${pagePathLevel4}, 2, 13)
                WHEN ${page_type} in ('Article', 'Section', 'Category') and ${site_version} = "help-dot" THEN SUBSTRING(${pagePathLevel4}, 2, 14)
                WHEN ${page_type} = "Category" and ${site_version} != "help-dot" THEN substring(${pagePathLevel3}, 2, 50)
                WHEN ${cuf_type} = "Main CUF" THEN "i-need-help"
              ELSE ${page_type} END;;
        }

    dimension: cuf_name {
      group_label: "Pages"
      label: "CUF Page Name"
      description: "English style name for start= and ticket_form_id= pages. (warning = using this dimension will lead to slow query speeds)"
      type: string
      sql: CASE
                WHEN ${pagepath} LIKE '%5749439348080640%' THEN "I have a privacy question"
                WHEN ${pagepath} LIKE '%5695496404336640%' THEN "I lost my Snapstreak"
                WHEN ${pagepath} LIKE '%5145405817880576%' THEN "I can't access my account > I think my account was compromised"
                WHEN ${pagepath} LIKE '%76586%' THEN "Account Recovery Request"
                WHEN ${pagepath} LIKE '%5153567363039232%' THEN "I want to report a safety concern"
                WHEN ${pagepath} LIKE '%5779421190160384%' THEN "I think my account was compromised"
                WHEN ${pagepath} LIKE '%6551059632488448%' THEN "I need help with a Snapchat feature > Snapchat on the web > I have a suggestion for Snapchat for Web"
                WHEN ${pagepath} LIKE '%5740125699702784%' THEN "I need help with a Snapchat feature > Snapchat on the web > Snap Camera for desktop"
                WHEN ${pagepath} LIKE '%5632701801431040%' THEN "I can't access my account > I forgot my password"
                WHEN ${pagepath} LIKE '%149423%' THEN "Snapstreaks Expiration"
                WHEN ${pagepath} LIKE '%4912986380566528%' THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased"
                WHEN ${pagepath} LIKE '%4884712610856960%' THEN "I can't access my account"
                WHEN ${pagepath} LIKE '%5792700948021248%' THEN "I found a bug -> Snapchat on the web > Calling and messaging on the web"
                WHEN ${pagepath} LIKE '%5763820408537088%' THEN "I want to report a safety concern > A Story"
                WHEN ${pagepath} LIKE '%109463%' THEN "bugs-2"
                WHEN ${pagepath} LIKE '%5726855856390144%' THEN "Snap Camera for Desktop"
                WHEN ${pagepath} LIKE '%5640758388326400%' THEN "I want to report a safety concern > Someone else's Snapchat account > The person passed away"
                WHEN ${pagepath} LIKE '%5726338866479104%' THEN "I want to report intellectual property infringement > Copyright"
                WHEN ${pagepath} LIKE '%5315796046446592%' THEN "I want to report a safety concern > Lenses"
                WHEN ${pagepath} LIKE '%5661994152886272%' THEN "I need help with a Snapchat feature > Snap Tokens and Gifts"
                WHEN ${pagepath} LIKE '%4812721711218688%' THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Reporting a Filter I think should be taken down"
                WHEN ${pagepath} LIKE '%76246%' THEN "feedback-1"
                WHEN ${pagepath} LIKE '%5059640638570496%' THEN "I need help with a Snapchat feature > Spotlight > My Spotlight payout"
                WHEN ${pagepath} LIKE '%6623032718917632%' THEN "ts-reported-content-3"
                WHEN ${pagepath} LIKE '%5685729013530624%' THEN "I need help with a Snapchat feature > Profiles and Communities > My Public Profile"
                WHEN ${pagepath} LIKE '%5731988359086080%' THEN "I want to report intellectual property infringement > Trademark > In their content, including in an Ad, Filter, or Story"
                WHEN ${pagepath} LIKE '%106993%' THEN "ts-all-abuse-1"
                WHEN ${pagepath} LIKE '%71659%' THEN "Report Copyright Infringement"
                WHEN ${pagepath} LIKE '%360000337551%' THEN "feedback-2"
                WHEN ${pagepath} LIKE '%7058755437844%' THEN "Appeal a Permanently Locked Account"
                WHEN ${pagepath} LIKE '%225183%' THEN "ts-impersonation-1b"
                WHEN ${pagepath} LIKE '%5668251581284352%' THEN "I want to report intellectual property infringement > Trademark > In their Snapchat username"
                WHEN ${pagepath} LIKE '%5693695504416768%' THEN "I want to report intellectual property infringement > Trademark > To sell or promote counterfeit goods"
                WHEN ${pagepath} LIKE '%360000025743%' THEN "bugs-2b"
                WHEN ${pagepath} LIKE '%189026%' THEN "ts-reported-content-2"
                WHEN ${pagepath} LIKE '%107523%' THEN "Mobile conflict + 2fa-SMS [ar-4]"
                WHEN ${pagepath} LIKE '%5123808608387072%' THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > I'm not seeing my Filter and it's live"
                WHEN ${pagepath} LIKE '%360000016663%' THEN "information-privacy"
                WHEN ${pagepath} LIKE '%360000005946%' THEN "Report Trademark Infringement"
                WHEN ${pagepath} LIKE '%360000493672%' THEN "ts-all-abuse-1b"
                WHEN ${pagepath} LIKE '%8180087057300%' THEN "[Legal] Privacy Rights Request Submission Form"
                WHEN ${pagepath} LIKE '%360001202252%' THEN "public-profile-contact"
                WHEN ${pagepath} LIKE '%109363%' THEN "On-Demand Geofilter Support"
                WHEN ${pagepath} LIKE '%4415368384788%' THEN "Content Takedown Appeal Form"
                WHEN ${pagepath} LIKE '%109383%' THEN "Geofilter Support"
                WHEN ${pagepath} LIKE '%360001266791%' THEN "Spotlight Payment Support"
                WHEN ${pagepath} LIKE '%360000723031%' THEN "ts-reported-content-3"
                WHEN ${pagepath} LIKE '%4415382039828%' THEN "Spotlight Takedown Appeals"
                WHEN ${pagepath} LIKE '%10492925245204%' THEN "Identity Ops VIP [Hidden]"
                WHEN ${pagepath} LIKE '%start=' OR ${pagepath} LIKE '%ticket_form_id=%' THEN "Other"
                    ELSE null END;;
        }

        dimension: category_page_type {
          group_label: "Pages"
          label: "Category Page Type"
          description: "The name of the page category on the left side section of support site -My Account & Security, Using Snapchat, Troubleshooting, Privacy, Safety"
          type: string
          sql: CASE
                    WHEN ${page_type} = "Category Page" and ${full_page_url} LIKE '%/category/my-account-and-settings%' THEN "My Account & Security"
                    WHEN ${page_type} = "Category Page" and ${full_page_url} LIKE '%category/using-snapchat%' THEN "Using Snapchat"
                    WHEN ${page_type} = "Category Page" and ${full_page_url} LIKE '%/category/troubleshooting-snapchat%' THEN "Troubleshooting"
                    WHEN ${page_type} = "Category Page" and ${full_page_url} LIKE '%/category/privacy-and-security%' THEN "Privacy"
                    WHEN ${page_type} = "Category Page" and ${full_page_url} LIKE '%/category/policies-and-safety%' THEN "Safety"
                    ELSE "Other page" END;;
        }

        dimension: mini_homepage_type {
          group_label: "Pages"
          label: "Mini Homepage Type"
          ##description: ""
          type: string
          sql: CASE
                        WHEN ${page_type} = "Home Page" AND ${full_page_url} LIKE '%p/parents_and_educators%' THEN "Parents & Educators"
                        WHEN ${page_type} = "Home Page" AND ${full_page_url} LIKE '%p/content_creators%' THEN "Content Creators"
                        WHEN ${page_type} = "Home Page" AND ${full_page_url} LIKE '%p/snapchat_plus_subscribers%' THEN "Snapchat+ Subscribers"
                  ELSE null END;;
        }

        dimension: website_language_code {
          label: "Website Language Code [ga4]"
          description: "Raw language code extracted from URL (ex en-gb for British English, or /ja for Japanese)"
          type: string
          sql:  CASE
                    WHEN ${full_page_url} LIKE '%/en-US%' OR ${full_page_url} LIKE '%/en-us%' THEN "/en-us/"
                    WHEN ${full_page_url} LIKE '%/da-DK%' OR ${full_page_url} LIKE '%hc/da%' THEN "/da/"
                    WHEN ${full_page_url} LIKE '%/de-DE%' OR ${full_page_url} LIKE '%hc/de%' THEN "/de/"
                    WHEN ${full_page_url} LIKE '%/en-GB%' OR ${full_page_url} LIKE '%/en-gb%' THEN "/en-gb/"
                    WHEN ${full_page_url} LIKE '%/fr-FR%' OR ${full_page_url} LIKE '%/fr-fr%' THEN "/fr-fr/"
                    WHEN ${full_page_url} LIKE '%/it-IT%' OR ${full_page_url} LIKE '%hc/it%' THEN "/it/"
                    WHEN ${full_page_url} LIKE '%/nl-NL%' OR ${full_page_url} LIKE '%hc/nl%' THEN "/nl/"
                    WHEN ${full_page_url} LIKE '%/ja-JP%' OR ${full_page_url} LIKE '%hc/ja%' THEN "/ja/"
                    WHEN ${full_page_url} LIKE '%/nb-NO%' OR ${full_page_url} LIKE '%/hc/no%' THEN "/no/"
                    WHEN ${full_page_url} LIKE '%/pt-BR%' OR ${full_page_url} LIKE '%/pt-br%' THEN "/pt-br/"
                    WHEN ${full_page_url} LIKE '%/fi-FI%' OR ${full_page_url} LIKE '%hc/fi%' THEN "/fi/"
                    WHEN ${full_page_url} LIKE '%/sv-SE%' OR ${full_page_url} LIKE '%hc/sv%' THEN "/sv/"
                    WHEN ${full_page_url} LIKE '%/ar-AA%' OR ${full_page_url} LIKE '%hc/ar%' THEN "/ar/"
                    WHEN ${full_page_url} LIKE '%/pt-pt%' OR ${full_page_url} LIKE '%/pt-PT%' THEN "/pt-pt/"
                    WHEN ${full_page_url} LIKE '%/es-es%' OR ${full_page_url} LIKE '%/es-ES%' THEN "/es-es/"
                    WHEN ${full_page_url} LIKE '%/hr%' THEN "/hr/"
                    WHEN ${full_page_url} LIKE '%/cs%' THEN "/cs/"
                    WHEN ${full_page_url} LIKE '%/et%' THEN "/et/"
                    WHEN ${full_page_url} LIKE '%/bg%' THEN "/bg/"
                    WHEN ${full_page_url} LIKE '%/el%' THEN "/el/"
                    WHEN ${full_page_url} LIKE '%/hu%' THEN "/hu/"
                    WHEN ${full_page_url} LIKE '%/ga%' THEN "/ga/"
                    WHEN ${full_page_url} LIKE '%/lv%' THEN "/lv/"
                    WHEN ${full_page_url} LIKE '%/lt%' THEN "/lt/"
                    WHEN ${full_page_url} LIKE '%/mt%' THEN "/mt/"
                    WHEN ${full_page_url} LIKE '%/sk%' THEN "/sk/"
                    WHEN ${full_page_url} LIKE '%/sl%' THEN "/sl/"
                    WHEN ${full_page_url} LIKE '%hc/tr%' THEN "/tr/"
                    WHEN ${full_page_url} LIKE '%hc/pl%' THEN "/pl/"
                    WHEN ${full_page_url} LIKE '%hc/hi-in%' THEN "/hi-in/"
                    WHEN ${full_page_url} LIKE '%hc/ro%' THEN "/ro/"
                    WHEN ${full_page_url} LIKE '%hc/ru%' THEN "/ru/"
                    WHEN ${full_page_url} LIKE '%/es%' THEN "/es/"
                    ELSE null END;;
   # hidden: yes
          }

          dimension: website_language {
            label: "Website Language [ga4]"
            type: string
            sql: CASE
                    WHEN ${full_page_url} LIKE '%/en-US%' OR ${full_page_url} LIKE '%/en-us%' THEN "English"
                    WHEN ${full_page_url} LIKE '%/da-DK%' OR ${full_page_url} LIKE '%hc/da%' THEN "Danish"
                    WHEN ${full_page_url} LIKE '%/de-DE%' OR ${full_page_url} LIKE '%hc/de%' THEN "German"
                    WHEN ${full_page_url} LIKE '%/en-GB%' OR ${full_page_url} LIKE '%/en-gb%' THEN "English"
                    WHEN ${full_page_url} LIKE '%/fr-FR%' OR ${full_page_url} LIKE '%/fr-fr%' THEN "French"
                    WHEN ${full_page_url} LIKE '%/it-IT%' OR ${full_page_url} LIKE '%hc/it%' THEN "Italian"
                    WHEN ${full_page_url} LIKE '%/nl-NL%' OR ${full_page_url} LIKE '%hc/nl%' THEN "Dutch"
                    WHEN ${full_page_url} LIKE '%/ja-JP%' OR ${full_page_url} LIKE '%hc/ja%' THEN "Japanese"
                    WHEN ${full_page_url} LIKE '%/nb-NO%' OR ${full_page_url} LIKE '%hc/no%' THEN "Norwegian"
                    WHEN ${full_page_url} LIKE '%/pt-BR%' OR ${full_page_url} LIKE '%/pt-br%' THEN "Portuguese"
                    WHEN ${full_page_url} LIKE '%/fi-FI%' OR ${full_page_url} LIKE '%hc/fi%' THEN "Finnish"
                    WHEN ${full_page_url} LIKE '%/sv-SE%' OR ${full_page_url} LIKE '%hc/sv%' THEN "Swedish"
                    WHEN ${full_page_url} LIKE '%/ar-AA%' OR ${full_page_url} LIKE '%hc/ar%' THEN "Arabic"
                    WHEN ${full_page_url} LIKE '%hc/tr%' THEN "Turkish"
                    WHEN ${full_page_url} LIKE '%hc/pl%' THEN "Polish"
                    WHEN ${full_page_url} LIKE '%hc/hi-in%' THEN "Hindi"
                    WHEN ${full_page_url} LIKE '%hc/ro%' THEN "Romanian"
                    WHEN ${full_page_url} LIKE '%hc/ru%' THEN "Russian"
                    WHEN ${full_page_url} LIKE '%/es%' THEN "Spanish"
                    WHEN ${full_page_url} LIKE '%/pt-pt%' OR ${full_page_url} LIKE '%/pt-PT%' THEN "Portuguese (Portugal)"
                    WHEN ${full_page_url} LIKE '%/es-es%' OR ${full_page_url} LIKE '%/es-ES%' THEN "Spanish (Spain)"
                    WHEN ${full_page_url} LIKE '%/hr%' THEN "Croatian"
                    WHEN ${full_page_url} LIKE '%/cs%' THEN "Czech"
                    WHEN ${full_page_url} LIKE '%/et%' THEN "Estonian"
                    WHEN ${full_page_url} LIKE '%/bg%' THEN "Bulgarian"
                    WHEN ${full_page_url} LIKE '%/el%' THEN "Greek"
                    WHEN ${full_page_url} LIKE '%/hu%' THEN "Hungarian"
                    WHEN ${full_page_url} LIKE '%/ga%' THEN "Irish"
                    WHEN ${full_page_url} LIKE '%/lv%' THEN "Latvian"
                    WHEN ${full_page_url} LIKE '%/lt%' THEN "Lithuanian"
                    WHEN ${full_page_url} LIKE '%/mt%' THEN "Maltese"
                    WHEN ${full_page_url} LIKE '%/sk%' THEN "Slovak"
                    WHEN ${full_page_url} LIKE '%/sl%' THEN "Slovenian"
                    ELSE null END;;
            description: "Language of the page, extracted from URL"
          }

          dimension: supported_language {
            type: yesno
            sql: CASE WHEN ${website_language_code} IN ("en", "da", "de", "es", "fr", "it", "nl", "ja", "nb", "pt", "fi", "sv", "ar" ) THEN TRUE
              ELSE FALSE END;;
                 hidden: yes #deprecated @amir
            description: "Is the Language supported by our support site?, extracted from url"
          }

          dimension: csat_reason  {
            group_label: "CSAT"
            label: "CSAT Reason"
            sql: CASE
                  WHEN ${event_Label} LIKE '%answer my question or solve my problem%'
                    OR ${event_Label} LIKE '%Denne artikel besvarede ikke mit spørgsmål eller løste mit problem%'
                    OR ${event_Label} LIKE '%Dieser Artikel hat meine Frage nicht beantwortet und mein Problem nicht gelöst.%'
                    OR ${event_Label} LIKE '%answer my question or solve my problem%'
                    OR ${event_Label} LIKE '%Este artículo no respondió mi pregunta o solucionó mi problema%'
                    OR ${event_Label} LIKE '%pas résolu mon problème%'
                    OR ${event_Label} LIKE '%non ha risposto alla mia domanda o non ha risolto il mio problema%'
                    OR ${event_Label} LIKE '%Dit artikel heeft mijn vraag niet beantwoord of mijn probleem niet opgelost%'
                    OR ${event_Label} LIKE '%この記事は私の質問に答えず、私の問題を解決しませんでした%'
                    OR ${event_Label} LIKE '%Denne artikkelen besvarte ikke spørsmålet eller løste problemet mitt%'
                    OR ${event_Label} LIKE '%Este artigo não respondeu à minha pergunta ou não resolveu meu problema%'
                    OR ${event_Label} LIKE '%Artikkeli ei vastannut kysymykseeni eikä ratkaissut ongelmaani%'
                    OR ${event_Label} LIKE '%Den här artikeln svarade inte på min fråga eller löste inte mitt problem%'
                    OR ${event_Label} LIKE 'Este artículo no respondió a mi pregunta ni resolvió mi problema'
                    OR ${event_Label} LIKE 'इस लेख से मेरे सवाल का जवाब नहीं मिला या मेरी समस्या का समाधान नहीं हुआ'
                    OR ${event_Label} LIKE '%لم يجيب هذا المقال على سؤالي أو يحل مشكلتي%' THEN "This article didn't answer my question or solve my problem"
                  WHEN ${event_Label} LIKE '%This article was hard to understand%'
                    OR ${event_Label} LIKE '%Denne artikel var svær at forstå%'
                    OR ${event_Label} LIKE '%Dieser Artikel war schwer zu verstehen.%'
                    OR ${event_Label} LIKE '%This article was hard to understand%'
                    OR ${event_Label} LIKE '%Este artículo fue difícil de entender%'
                    OR ${event_Label} LIKE '%Cet article était difficile à comprendre%'
                    OR ${event_Label} LIKE '%Questo articolo è stato difficile da comprendere%'
                    OR ${event_Label} LIKE '%Dit artikel was moeilijk te begrijpen.%'
                    OR ${event_Label} LIKE '%この記事は分かりにくかった%'
                    OR ${event_Label} LIKE '%Denne artikkelen var vanskelig å forstå%'
                    OR ${event_Label} LIKE '%Este artigo foi difícil de entender%'
                    OR ${event_Label} LIKE '%Tämä artikkeli oli vaikeaselkoinen%'
                    OR ${event_Label} LIKE '%Den här artikeln är svårt att förstå%'
                    OR ${event_Label} LIKE 'Ovaj članak je teško razumjeti'
                    OR ${event_Label} LIKE 'इस लेख को समझना मुश्किल था'
                    OR ${event_Label} LIKE '%كان من الصعب فهم هذه المقالة%' THEN "This article was hard to understand"
                  WHEN ${event_Label} LIKE '%match what I see in Snapchat%'
                    OR ${event_Label} LIKE '%Denne artikel er ikke korrekt eller svarer ikke til det, jeg ser på Snapchat%'
                    OR ${event_Label} LIKE '%Dieser Artikel ist nicht präzise oder stimmt nicht mit dem überein, was ich in Snapchat sehe.%'
                    OR ${event_Label} LIKE '%match what I see in Snapchat%'
                    OR ${event_Label} LIKE '%Este artículo no es preciso o no coincide con lo que veo en Snapchat%'
                    OR ${event_Label} LIKE '%pas exact ou ne correspond pas à ce que je vois sur Snapchat.%'
                    OR ${event_Label} LIKE '%Questo articolo non è preciso o non corrisponde a cosa vedo su Snapchat%'
                    OR ${event_Label} LIKE '%Dit artikel is niet nauwkeurig of past niet bij wat ik in Snapchat zie.%'
                    OR ${event_Label} LIKE '%この記事は不正確であるか、Snapchatに表示されるものと一致しない%'
                    OR ${event_Label} LIKE '%Denne artikkelen er upresis eller stemmer ikke med det jeg ser på Snapchat%'
                    OR ${event_Label} LIKE '%Este artigo não é muito preciso ou não corresponde ao que vejo no Snapchat%'
                    OR ${event_Label} LIKE '%Tämän artikkelin sisältö ei pidä paikaansa tai vastaa Snapchatissa näkemääni sisältöä%'
                    OR ${event_Label} LIKE '%Den här artikeln är inte korrekt eller matchar inte det jag ser i Snapchat%'
                    OR ${event_Label} LIKE 'Тази статия не е точна или не съответства на това, което виждам в Snapchat'
                    OR ${event_Label} LIKE 'Níl an t-alt seo cruinn nó ní thagann sé leis an méid a fheiceann mé ar Snapchat'
                    OR ${event_Label} LIKE 'यह लेख सटीक नहीं है या Snapchat में मैंने जो देखा है उससे मेल नहीं खाता'
                    OR ${event_Label} LIKE '%هذه المقالة غير دقيقة أو لا تتوافق مع ما أراه على سناب شات%' THEN "This article isnt accurate or doesnt match what I see in Snapchat"
                  WHEN ${event_Label} LIKE '%like how the feature described in this article works%'
                    OR ${event_Label} LIKE '%Jeg bryder mig ikke om, hvordan den funktion, der er beskrevet i denne artikel, fungerer%'
                    OR ${event_Label} LIKE '%Mir gefällt nicht, wie das in diesem Artikel beschriebene Feature funktioniert.%'
                    OR ${event_Label} LIKE '%like how the feature described in this article works%'
                    OR ${event_Label} LIKE '%No me gusta cómo funciona la función descrita en este artículo%'
                    OR ${event_Label} LIKE '%pas comment la fonctionnalité décrite dans cet article fonctionne%'
                    OR ${event_Label} LIKE '%Non mi piace come funziona la funzionalità descritta in questo articolo%'
                    OR ${event_Label} LIKE '%Ik hou niet van hoe de functie in dit artikel beschreven, werkt.%'
                    OR ${event_Label} LIKE '%この記事で説明されている機能の仕組みが好きではない%'
                    OR ${event_Label} LIKE '%Jeg liker ikke måten funksjonen som er beskrevet i denne artikkelen fungerer på%'
                    OR ${event_Label} LIKE '%Não gosto de como o recurso descrito neste artigo funciona%'
                    OR ${event_Label} LIKE '%En pidä siitä, miten tässä artikkelissa kuvailtu ominaisuus toimii%'
                    OR ${event_Label} LIKE '%Jag gillar inte hur funktionen som beskrivs i den här artikeln fungerar%'
                    OR ${event_Label} LIKE 'इस लेख में बताया गया फ़ीचर जिस तरीके से काम करता है, वह मुझे पसंद नहीं है'
                    OR ${event_Label} LIKE '%لا أحب طريقة عمل الميزة الموضّحة في هذه المقالة%' THEN "I dont like how the feature described in this article works"
                      ELSE NULL END
            ;;
            type: string
            description: "CSAT Survey reason selections after negative rating."
          }

    measure: count_csat_yes {
      type: count_distinct
      label: "Count CSAT Yes [ga4]"
      sql: ${community_help_center.visitor_page} ;;
      filters: [event_Label: "Vote: Yes", type_of_hit: "EVENT"]
      group_label: "CSAT"
      description: "Count of distinct Yes votes based on the visitor ID and page that the vote was submitted on"
    }

    measure: count_csat_no {
      type: count_distinct
      label: "Count CSAT No [ga4]"
      sql: ${community_help_center.visitor_page} ;;
      filters: [event_Label: "Vote: No", type_of_hit: "EVENT"]
      group_label: "CSAT"
      description: "Count of distinct No votes based on the visitor ID and page that the vote was submitted on"
    }

    measure: count_csat_votes {
      type: number
      label: "Count CSAT Votes [ga4]"
       sql: ${count_csat_yes}+${count_csat_no} ;;
      group_label: "CSAT"
      description: "Count of distinct Yes and No votes based on the visitor ID and page that the vote was submitted on"
    }

    measure: percent_csat_yes {
      sql: ${count_csat_yes}/NULLIF((${count_csat_yes}+${count_csat_no}), 0) ;;
      type: number
      value_format_name: percent_0
      label: "% CSAT Yes (Surveys) [ga4]"
      description: "% of Yes survery responses to Article CSAT survey as a proportion of all survery responses (yes + no); distinct only"
      group_label: "CSAT"
    }

    measure: count_csat_yes_all {
      type: count
      label: "Count CSAT Yes - ALL [ga4]"
      #sql: ${community_help_center.visitor_page} ;;
      filters: [event_Label: "Vote: Yes", type_of_hit: "EVENT"]
      group_label: "CSAT"
      description: "Count of non-distinct Yes votes based on the visitor ID and page that the vote was submitted on"
      hidden: yes
    }

    measure: count_csat_no_all {
      type: count
      label: "Count CSAT No - ALL [ga4]"
      #sql: ${community_help_center.visitor_page} ;;
      filters: [event_Label: "Vote: No", type_of_hit: "EVENT"]
      group_label: "CSAT"
      description: "Count of non-distinct No votes based on the visitor ID and page that the vote was submitted on"
      hidden: yes
    }

    measure: count_csat_votes_all {
      type: number
      label: "Count CSAT Votes - ALL [ga4]"
      sql: ${count_csat_yes_all}+${count_csat_no_all} ;;
      group_label: "CSAT"
      description: "Count of non-distinct Yes and No votes based on the visitor ID and page that the vote was submitted on"
      hidden: yes
    }

    measure: percent_csat_yes_all {
      sql: ${count_csat_yes_all}/NULLIF((${count_csat_yes_all}+${count_csat_no_all}), 0) ;;
      type: number
      value_format_name: percent_2
      label: "% CSAT Yes (Surveys) - ALL [ga4]"
      description: "% of Yes survery responses to Article CSAT survey as a proportion of all survery responses (yes + no); non distinct"
      group_label: "CSAT"
      hidden: yes
    }

    measure: percent_csat_no_all {
      sql: ${count_csat_no_all}/NULLIF((${count_csat_yes_all}+${count_csat_no_all}), 0) ;;
      type: number
      value_format_name: percent_2
      label: "% CSAT No (Surveys) - ALL [ga4]"
      description: "% of No survery responses to Article CSAT survey as a proportion of all survery responses (yes + no); non distinct"
      group_label: "CSAT"
      hidden: yes
    }

    measure: percent_csat_no_sessions {
      sql: ${count_csat_no}/NULLIF(${article_sessions}, 0) ;;
      type: number
      value_format_name: percent_2
      label: "% CSAT No (Sessions) [ga4]"
      description: "% of No survery responses to Article CSAT survey as a proportion of all sessions with Article views"
      group_label: "CSAT"
    }

    measure: article_sessions {
      label: "Article Sessions [ga4]"
      description: "Sessions with Article type page views"
      type: count_distinct
      allow_approximate_optimization: yes
      sql: ${community_help_center.session_id} ;;

      filters: {
        field: page_type
        value: "Article"
      }
    }

    measure: count_cuf_node_selection {
      type: count
      label: "Count Cuf Node Selection"
      # sql: ${event_count} ;;
      filters: [event_Category: "CUF Node Selections", type_of_hit: "EVENT"]
      group_label: "CUF Node"
    }

    # measure: count_article_tap_to_expand{
    #   type: count
    #   label: "Count Article Tap to Expand"
    #   # sql: ${event_count} ;;
    #   filters: [event_Category: "Tap to Expand", type_of_hit: "EVENT"]
    #   group_label: "Tap to Expand"
    # }

    measure: count_tap_to_expand{
      type: count
      label: "Count CUF Tap to Expand"
      # sql: ${event_count} ;;
      filters: [event_Category: "Tap to Expand", type_of_hit: "EVENT"]
      group_label: "Tap to Expand"
    }

    measure: count_error_events {
      type: count
      label: "Count Error Events"
      # sql: ${event_count} ;;
      filters: [event_Category: "Help Center Error", type_of_hit: "EVENT"]
      group_label: "Errors"
    }

    measure: count_cuf_error_events {
      type: count
      label: "Count CUF Page Error Events"
      # sql: ${event_count} ;;
      filters: [page_type: "Contact Us", event_Category: "Help Center Error", type_of_hit: "EVENT"]
      group_label: "Errors"
    }


    measure: count_error_sessions {
      label: "Count Sessions with Error Events"
      description: "Sessions with Error type events"
      type: count_distinct
      allow_approximate_optimization: yes
      group_label: "Errors"
      sql: ${community_help_center.pk} ;;

      filters: {
        field: event_Category
        value: "Help Center Error"
      }
    }

    measure: count_cuf_error_sessions {
      label: "Count Sessions with CUF Error Events"
      description: "Sessions with Error type events on CUF pages"
      type: count_distinct
      filters: [page_type: "Contact Us", event_Category: "Help Center Error"]
      group_label: "Errors"
      sql: ${community_help_center.pk} ;;
    }

    measure: count_404_error_sessions {
      label: "Count 404 Page Error Sessions"
      description: "Sessions with at least 1 404 page pageview"
      type: count_distinct
      filters: [page_type: "Error"]
      group_label: "Errors"
      sql: ${community_help_center.pk} ;;
    }

    measure: sessions_count {
      label: "Unique Sessions Count"
      description: "count of unique Sessions"
      type: count_distinct
      group_label: "Errors"
      hidden: yes
      sql: ${community_help_center.pk} ;;
    }

    measure: percent_error_events {
      sql: ${count_error_events}/NULLIF(${sessions_count}, 0) ;;
      type: number
      value_format_name: percent_1
      label: "Error Events %"
      description: "Error Events as a % of all Sessions"
      group_label: "Errors"
    }

    measure: percent_cuf_error_events {
      sql: ${count_cuf_error_events}/NULLIF(${sessions_count}, 0) ;;
      type: number
      value_format_name: percent_1
      label: "CUF Page Error Events %"
      description: "CUF Page Error Events as a % of all Sessions"
      group_label: "Errors"
    }

    measure: percent_error_sessions {
      sql: ${count_error_sessions}/NULLIF(${sessions_count}, 0) ;;
      type: number
      value_format_name: percent_1
      label: "Sessions with Error Events %"
      description: "Sessions with Error Events as a % of all Sessions"
      group_label: "Errors"
    }

    measure: percent_cuf_error_sessions {
      sql: ${count_cuf_error_sessions}/NULLIF(${sessions_count}, 0) ;;
      type: number
      value_format_name: percent_1
      label: "Sessions with CUF Page Error Events %"
      description: "CUF Page Sessions with Error Events as a % of all Sessions"
      group_label: "Errors"
    }

    measure: percent_404_error_sessions {
      sql: ${count_404_error_sessions}/NULLIF(${sessions_count}, 0) ;;
      type: number
      value_format_name: percent_1
      label: "404 Page Error Sessions %"
      description: "Sessions with 404 page pageviews as a % of all Sessions"
      group_label: "Errors"
    }





          measure: entrance_pageviews_total {
            label: "Entrances"
            description: "The number of entrances to the property measured as the first pageview in a session, typically used with landingPagePath."
            type: count_distinct
            sql: ${id} ;;

            filters: {
              field: is_Entrance
              value: "Yes"
            }

          }

          measure: entrance_rate {
            description: "The percentage of pageviews in which this page was the entrance."
            type: number
            sql: ${entrance_pageviews_total}/NULLIF(${page_count}, 0) ;;
            value_format_name: percent_2
          }

          measure: event_count {
            label: "Total Events"
            description: "The total number of web events for the event."
            type: count
            # sql: ${id} ;;

            filters: {
              field: type_of_hit
              value: "EVENT"
            }

          }

          measure: exit_pageviews_total {
            label: "Exits"
            description: "The number of exits from the property."
            type: count_distinct
            sql: ${id} ;;

            filters: {
              field: is_Exit
              value: "Yes"
            }
          }

          measure: exit_rate {
            label: "Exit Rate"
            description: "Exit is (number of exits) / (number of pageviews) for the page or set of pages. It indicates how often users exit from that page or set of pages when they view the page(s)."
            type: number
            sql: ${exit_pageviews_total}/NULLIF(${page_count}, 0) ;;
            value_format_name: percent_2
          }

          measure: page_count {
            label: "Pageviews [ga4]"
            description: "The total number of pageviews within the session. Use with Page-level dimensions only"
            type: count
            # sql: ${id} ;;

            filters: {
              field: type_of_hit
              value: "PAGE"
            }
          }

          measure: events_per_session {
            label: "Events / Sessions"
            description: "The average number of web events per session (with web event)."
            type: number
            sql: ${event_count}/NULLIF(${sessions_with_events},0);;

            value_format_name: decimal_2
          }

          measure: sessions_with_events {
            description: "The total number of sessions with web events."
            type: count_distinct
            allow_approximate_optimization: yes
            sql: ${community_help_center.pk} ;;

            filters: {
              field: type_of_hit
              value: "EVENT"
            }
          }

          measure: total_unique_searches {
            type: count_distinct
            sql: CONCAT( ${community_help_center.session_id}, ${search_Keyword}) ;;
            description: "Total unique searches"

          }

        }
