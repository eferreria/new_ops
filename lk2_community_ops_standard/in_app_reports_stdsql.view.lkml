# most active contributor jbabra@snapchat.com
include: "//hub_looker_production/common/common_blizzard.view"
view: in_app_reports_stdsql {
  extends: [country_groups]

  derived_table: {
    sql:
      SELECT
        source,
        feature,
        subFeature AS subFeatureNew,
        report_id AS reportid,
        user_id AS userid,
        UPPER(type) AS reportType,
        reportClientTime AS creationTime,
        cof_etag AS cofEtag,
        safe_mode AS safeMode,
        IFNULL(REGEXP_EXTRACT(userAgent, r'Snapchat\/([\d+.]+[\d])\s?[a-zA-Z]*\s[\(][^;]+;.+'), 'Unknown') AS appVersion,
        IFNULL(REGEXP_EXTRACT(userAgent, r'Snapchat\/[\d+.]+[\d]\s?[a-zA-Z]*\s[\(][^;]+;\s([^#;]+).+'), 'Unknown') AS deviceOs,
        IFNULL(REGEXP_EXTRACT(userAgent, r'PalmTree\/([\d+.]+[\d])\s?[a-zA-Z]*\s[\(][^;]+;.+'), 'Unknown') AS pt_appVersion,
        IFNULL(REGEXP_EXTRACT(userAgent, r'PalmTree\/[\d+.]+[\d]\s?[a-zA-Z]*\s[\(][^;]+;\s([^#;]+).+'), 'Unknown') AS pt_deviceOs,
        LOWER(JSON_EXTRACT_SCALAR(deviceinfo, "$.model")) AS deviceModel,
        JSON_EXTRACT_SCALAR(deviceinfo, "$.name") AS devicename,
        JSON_EXTRACT_SCALAR(deviceinfo, "$.maker") AS devicebrand,
        JSON_EXTRACT_SCALAR(localeinfo, "$.country") AS country,
        JSON_EXTRACT_SCALAR(localeinfo, "$.region") AS region,
        JSON_EXTRACT_SCALAR(localeinfo, "$.city") AS city,
        JSON_EXTRACT_SCALAR(localeinfo, "$.locale") AS locale,
        otherJsonInfo AS otherJsonInfo,
        REGEXP_EXTRACT(otherJsonInfo, r'"MERLIN:(.*?)(?:",|"])') AS MerlinZero, --MyAI First Chat
        REGEXP_EXTRACT(otherJsonInfo, r'"MERLIN:(?:.*?)"MERLIN:(.*?)(?:",|"])') AS MerlinFirst, --MyAI Second Chat
        REGEXP_EXTRACT(otherJsonInfo, r'"MERLIN:(?:.*?)"MERLIN:(?:.*?)"MERLIN:(.*?)(?:"])') AS MerlinSecond, --MyAI Third Chat
        REGEXP_EXTRACT(otherJsonInfo, r'"USER:(.*?)(?:",)') AS MerlinUserZero, -- User First Chat
        REGEXP_EXTRACT(otherJsonInfo, r'"USER:(?:.*?)"USER:(.*?)(?:",)') AS MerlinUserFirst, -- User Second Chat
        REGEXP_EXTRACT(otherJsonInfo, r'"USER:(?:.*?)"USER:(?:.*?)"USER:(.*?)(?:",)') AS MerlinUserSecond, -- User Third Chat
        REGEXP_EXTRACT(otherJsonInfo, r'.*MERLIN:([^}]*)\"') AS MerlinSelectedChat,
        REGEXP_EXTRACT(otherJsonInfo, r'"MyAiContent":\[(.*?)(?:]})') AS MerlinFullConvo, -- Full Convo
        REGEXP_EXTRACT(otherJsonInfo, r'\"source_screen\":\"(\w+)\"') AS subfeature,
        REGEXP_EXTRACT(otherJsonInfo, r'"game_name":"([^"]*)"') AS Gamename,
        REGEXP_EXTRACT(otherJsonInfo, r'"game_id":"([^"]*)"') AS Gameid,
        REGEXP_EXTRACT(otherJsonInfo, r'"is_first_party":(\w+)') AS isfirstparty,
        REGEXP_EXTRACT(otherJsonInfo, r'"arroyo_mode":"([^"]*)"') AS ArroyoMode,
        REGEXP_EXTRACT(otherJsonInfo, r'"build_version":"([^"]*)"') AS Gameversion,
        REGEXP_EXTRACT(otherJsonInfo, r'"has_camera_roll_attachment":(\w+)') AS has_camera_roll_attachment,  --insetting
        REGEXP_EXTRACT(otherJsonInfo, r'"has_screen_captured":(\w+)') AS has_screen_captured,  --s2r
        REGEXP_EXTRACT(otherJsonInfo, r'"has_screen_capture":(\w+)') AS has_screen_capture,  --inCanvas discrepancy
        COALESCE(translatedData, description) AS description_translated,
        description AS original_description,
        JSON_EXTRACT_SCALAR(networkinfo, "$.connectionType") AS connectionType,
        JSON_EXTRACT_SCALAR(networkinfo, "$.ispProvider") AS ispProvider,
        bandwidth,
        internal AS isInternal,
        CASE
          WHEN userAgent LIKE '%iOS%' THEN 'iOS'
          WHEN userAgent LIKE '%Android%' THEN 'Android'
          ELSE 'Unknown'
        END
        AS platform,
        JSON_EXTRACT_SCALAR(appinfo, "$.buildFlavor") AS buildFlavor,
        JSON_EXTRACT_SCALAR(appinfo, "$.name") AS treatmentType,
        JSON_VALUE(proto_metadata, '$.cameraInfo.cameraServiceState') AS cameraServiceState,
        JSON_VALUE(proto_metadata, '$.cameraInfo.openAttemptCameraApi') AS openAttemptCameraApi,
        JSON_VALUE(proto_metadata, '$.cameraInfo.openAttemptCameraDirection') AS openAttemptCameraDirection,
        JSON_VALUE(proto_metadata, '$.cameraInfo.openAttemptCameraUsageType') AS openAttemptCameraUsageType,
        JSON_VALUE(proto_metadata, '$.cameraInfo.openAttemptCameraId') AS openAttemptCameraId,
        JSON_VALUE(proto_metadata, '$.cameraInfo.cameraSessionId') AS cameraSessionId,
        JSON_VALUE(proto_metadata, '$.cameraInfo.lastCaptureSessionId') AS lastCaptureSessionId,
        JSON_VALUE(proto_metadata, '$.cameraInfo.lastCameraOrientation') AS lastCameraOrientation,
        JSON_VALUE(proto_metadata, '$.cameraInfo.lastCameraDirection') AS lastCameraDirection,
        JSON_VALUE(proto_metadata, '$.lensesInfo.activeLensId') AS activeLensId,
        JSON_VALUE(proto_metadata, '$.messagingInfo.lastConversationId') AS lastConversationId,
        JSON_VALUE(proto_metadata, '$.notificationInfo.notificationId') AS lastNotificationId,
        feature AS userSelectedFeature,
        REGEXP_EXTRACT(otherJsonInfo, r'"is_app_loaded":(\w+)') AS is_app_loaded,
        REGEXP_EXTRACT(otherJsonInfo, r'"app_type":"([^"]*)"') AS app_type,
        preferenceInfo,
        session_id AS sessionId,
        shake_frequency AS shakeFrequency,
        shake_sensitivity AS shakeSensitivity,
        jira_ticket_key AS jiraTicketKey
      FROM
        `lookinsoclear.app_insights.air_reports`
      WHERE
        ((TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) >= {% date_start datefilter %} 
          AND TIMESTAMP_TRUNC(_PARTITIONTIME, DAY) <= {% date_end datefilter %})
        -- If future data is requested, also pull from yet to be partitioned data
        OR (_PARTITIONTIME IS NULL AND TIMESTAMP({% date_end datefilter %}) >= CURRENT_TIMESTAMP()))
        AND otherJsonInfo NOT LIKE '%from_test_automation%'
    ;;
  }

  ## dimensions

  dimension: random {
    sql: (floor(RAND()*10000)+1) ;;
    description: "Add to results to get random results"
    type: number
  }

  dimension: event_creationtime {
    hidden: yes
    type: date
    sql: DATE(${TABLE}.creationTime) ;;
  }

  dimension: event_string {
    hidden: no
    type: string
    sql: STRING(DATE(${TABLE}.creationTime)) ;;
  }

  dimension_group: event {
    label: "Event UTC"
    type: time
    sql: ${TABLE}.creationTime ;;
    convert_tz: no
  }

  dimension_group: event_pst {
    label: "Event PST"
    description: "Offset -7 hours from UTC"
    type: time
    sql: TIMESTAMP_SUB(${TABLE}.creationTime, INTERVAL 7 HOUR)  ;;
    convert_tz: no
  }

  dimension: week_number_sunday_start {
    type: number
    description: "Weeks begin on Sunday, so if January 1 is on a day other than Sunday, week 1 has fewer than 7 days and the first Sunday of the year is the first day of week 2."
    sql:  CAST(EXTRACT(WEEK FROM ${event_pst_date}) AS INT64) +1 ;;
  }

  dimension_group: 15min_increment {
    label: "PST in 15 min increment"
    description: "15 Mins Increment in PST"
    type: time
    sql: TIMESTAMP_SUB(${TABLE}.creationTime, INTERVAL 7 HOUR)  ;;
    #sql: TIMESTAMP_SUB(TIMESTAMP_SECONDS(15*60 * DIV(UNIX_SECONDS(${TABLE}.creationTime), 15*60)), INTERVAL 7 HOUR)  ;;
    convert_tz: no
    timeframes: [minute15]
  }

  dimension_group: 30min_increment {
    label: "PST in 30 min increment"
    description: "30 Mins Increment in PST"
    type: time
    sql: TIMESTAMP_SUB(${TABLE}.creationTime, INTERVAL 7 HOUR)  ;;
   # sql: TIMESTAMP_SUB(TIMESTAMP_SECONDS(30*60 * DIV(UNIX_SECONDS(${TABLE}.creationTime), 30*60)), INTERVAL 7 HOUR)  ;;
    convert_tz: no
    timeframes: [minute30]
  }

  dimension: datefilter {
    type: date
    sql: TIMESTAMP_SUB(${TABLE}.creationTime, INTERVAL 7 HOUR)  ;;
    hidden: yes
    label: "PST required filter "
    convert_tz: no
    description: "This filter is required for date bound & is in Pacific time"
  }

  dimension: cof_etag {
    type: string
    sql: ${TABLE}.cofEtag ;;
  }

  dimension: safe_mode {
    type: yesno
    sql: ${TABLE}.safeMode ;;    
  }

  dimension: reportId {
    label: "Report ID"
    description: "reportId unique for a report"
    group_label: "IDs"
    type: string
    sql: ${TABLE}.reportId ;;
    primary_key: yes
  }

  dimension: combinedId {
    label: "Combine ID"
    description: "userId + reportId"
    group_label: "IDs"
    type: string
    sql: CONCAT(${TABLE}.userid, ",", ${TABLE}.reportid)   ;;
  }

  dimension: description {
    description: "ALL text description translated or copied if in English"
    type: string
    case_sensitive: no
    sql: ${TABLE}.description_translated ;;
    group_label: "Descriptions"
  }

  dimension: original_description {
    description: "Original descripiton in native text"
    type: string
    case_sensitive: no
    sql: ${TABLE}.original_description ;;
    group_label: "Descriptions"
  }

  dimension: description_greater_14 {
    label: "Description >14"
    type: string
    sql: CASE WHEN LENGTH(${description}) > 14 THEN ${description}
      ELSE null
      END ;;
    case_sensitive: no
    group_label: "Descriptions"
  }

  dimension: description_less_14 {
    label: "Description <14"
    type: string
    sql: CASE WHEN LENGTH(${description}) < 14 THEN ${description}
      ELSE null
      END ;;
    case_sensitive: no
    group_label: "Descriptions"
  }

  dimension: description_length {
    type: number
    sql: LENGTH(${description}) ;;
    group_label: "Descriptions"
  }

  dimension: appVersion {
    description: "Snapchat appVersion"
    type: string
    group_label: "App Info"
    sql: CASE WHEN ${source} = "InStoryStudio" THEN ${pt_appVersion}
          ELSE ${og_appVersion}
          END;;
  }

  dimension: pt_appVersion {
    type: string
  }

  dimension: og_appVersion {
    type: string
    sql: ${TABLE}.appVersion ;;
  }

  dimension: appVersion_Primary {
    description: "Primary App Version, ie. 10.8"
    group_label: "App Info"
    type: string
    sql: REGEXP_EXTRACT(${appVersion},r'(\d+\.\d+)') ;;
  }

  measure: latest_app_version {
    description: "Latest app version"
    group_label: "App Info"
    type: max
    sql: ${appVersion_Primary} ;;
  }

  dimension: deviceOS {
    description: "Android 8.1.0 OR iOS 12.0.1"
    type: string
    case_sensitive: no
    group_label: "Device Info"
    label: "Device OS"
    sql: CASE WHEN ${source} = "InStoryStudio" THEN ${pt_deviceOs}
              ELSE ${og_deviceOs}
              END;;
  }

  dimension: pt_deviceOs {
    type: string
    case_sensitive: no
  }

  dimension: og_deviceOs {
    type: string
    case_sensitive: no
    sql: ${TABLE}.deviceOS ;;
  }

  dimension: deviceOS_group {
    description: "Android or iOS 12.1, 12.2"
    label: "Device OS Group"
    type: string
    sql: substr(${TABLE}.deviceOS, 0,8) ;;
    group_label: "Device Info"
  }

  dimension: deviceModel {
    description: "Device Model like SM-G970x "
    type: string
    case_sensitive: no
    group_label: "Device Info"
    label: "Device Model"
  }

  dimension: devicename {
    description: "Name like Iphone X"
    type: string
    case_sensitive: no
    group_label: "Device Info"
    label: "Device Name"
  }

  dimension: devicebrand {
    description: "Device Brand - Apple, samsung"
    type: string
    case_sensitive: no
    group_label: "Device Info"
    label: "Device Brand"
  }

  dimension: country {
    description: "country"
    type: string
    case_sensitive: no
    map_layer_name:  countries
    sql: CASE
        WHEN  (${TABLE}.country = "uk" OR ${TABLE}.country = "UK") THEN "GB"
        ELSE UPPER(${TABLE}.country)
        END ;;
    group_label: "Location Info"
  }

  dimension: inclusive_region {
    group_label: "Location Info"
    type: string
    case_sensitive: no
    sql: ${inclusive_region.inclusive_region} ;;
  }

  dimension: country_name {
    group_label: "Location Info"
    type: string
    case_sensitive: no
    sql: ${inclusive_region.country} ;;
  }

  dimension: region {
    description: "region"
    type: string
    case_sensitive: no
    group_label: "Location Info"
  }

  dimension: city {
    description: "city"
    type: string
    case_sensitive: no
    group_label: "Location Info"
  }

  dimension: locale {
    description: "en_US, ar_SA etc"
    type: string
    case_sensitive: no
    group_label: "Location Info"
    sql: ${TABLE}.locale ;;
  }

  dimension: language {
    description: "Language"
    type: string
    group_label: "Location Info"
    case_sensitive: no
    sql: CASE
        WHEN ${locale} LIKE 'fil%' THEN "Filipino"
        WHEN ${locale} LIKE 'nb%' THEN "Norwegian"
        WHEN ${locale} LIKE 'ab%' THEN "Abkhazian"
        WHEN ${locale} LIKE 'aa%' THEN "Afar"
        WHEN ${locale} LIKE 'af%' THEN "Afrikaans"
        WHEN ${locale} LIKE 'sq%' THEN "Albanian"
        WHEN ${locale} LIKE 'am%' THEN "Amharic"
        WHEN ${locale} LIKE 'ar%' THEN "Arabic"
        WHEN ${locale} LIKE 'hy%' THEN "Armenian"
        WHEN ${locale} LIKE 'as%' THEN "Assamese"
        WHEN ${locale} LIKE 'ay%' THEN "Aymara"
        WHEN ${locale} LIKE 'az%' THEN "Azerbaijani"
        WHEN ${locale} LIKE 'ba%' THEN "Bashkir"
        WHEN ${locale} LIKE 'eu%' THEN "Basque"
        WHEN ${locale} LIKE 'bn%' THEN "Bengali"
        WHEN ${locale} LIKE 'dz%' THEN "Bhutani"
        WHEN ${locale} LIKE 'bh%' THEN "Bihari"
        WHEN ${locale} LIKE 'bi%' THEN "Bislama"
        WHEN ${locale} LIKE 'br%' THEN "Breton"
        WHEN ${locale} LIKE 'bg%' THEN "Bulgarian"
        WHEN ${locale} LIKE 'my%' THEN "Burmese"
        WHEN ${locale} LIKE 'be%' THEN "Byelorussian"
        WHEN ${locale} LIKE 'km%' THEN "Cambodian"
        WHEN ${locale} LIKE 'ca%' THEN "Catalan"
        WHEN ${locale} LIKE 'zh%' THEN "Chinese"
        WHEN ${locale} LIKE 'co%' THEN "Corsican"
        WHEN ${locale} LIKE 'hr%' THEN "Croatian"
        WHEN ${locale} LIKE 'cs%' THEN "Czech"
        WHEN ${locale} LIKE 'da%' THEN "Danish"
        WHEN ${locale} LIKE 'nl%' THEN "Dutch"
        WHEN ${locale} LIKE 'en%' THEN "English"
        WHEN ${locale} LIKE 'eo%' THEN "Esperanto"
        WHEN ${locale} LIKE 'et%' THEN "Estonian"
        WHEN ${locale} LIKE 'fo%' THEN "Faeroese"
        WHEN ${locale} LIKE 'fa%' THEN "Farsi"
        WHEN ${locale} LIKE 'fj%' THEN "Fiji"
        WHEN ${locale} LIKE 'fi%' THEN "Finnish"
        WHEN ${locale} LIKE 'fr%' THEN "French"
        WHEN ${locale} LIKE 'fy%' THEN "Frisian"
        WHEN ${locale} LIKE 'gl%' THEN "Galician"
        WHEN ${locale} LIKE 'gd%' THEN "Gaelic (Scottish)"
        WHEN ${locale} LIKE 'gv%' THEN "Gaelic (Manx)"
        WHEN ${locale} LIKE 'ka%' THEN "Georgian"
        WHEN ${locale} LIKE 'de%' THEN "German"
        WHEN ${locale} LIKE 'el%' THEN "Greek"
        WHEN ${locale} LIKE 'kl%' THEN "Greenlandic"
        WHEN ${locale} LIKE 'gn%' THEN "Guarani"
        WHEN ${locale} LIKE 'gu%' THEN "Gujarati"
        WHEN ${locale} LIKE 'ha%' THEN "Hausa"
        WHEN ${locale} LIKE 'he%' THEN "Hebrew"
        WHEN ${locale} LIKE 'hi%' THEN "Hindi"
        WHEN ${locale} LIKE 'hu%' THEN "Hungarian"
        WHEN ${locale} LIKE 'is%' THEN "Icelandic"
        WHEN ${locale} LIKE 'id%' THEN "Indonesian"
        WHEN ${locale} LIKE 'ia%' THEN "Interlingua"
        WHEN ${locale} LIKE 'ie%' THEN "Interlingue"
        WHEN ${locale} LIKE 'iu%' THEN "Inuktitut"
        WHEN ${locale} LIKE 'ik%' THEN "Inupiak"
        WHEN ${locale} LIKE 'ga%' THEN "Irish"
        WHEN ${locale} LIKE 'it%' THEN "Italian"
        WHEN ${locale} LIKE 'ja%' THEN "Japanese"
        WHEN ${locale} LIKE 'ja%' THEN "Javanese"
        WHEN ${locale} LIKE 'kn%' THEN "Kannada"
        WHEN ${locale} LIKE 'ks%' THEN "Kashmiri"
        WHEN ${locale} LIKE 'kk%' THEN "Kazakh"
        WHEN ${locale} LIKE 'rw%' THEN "Kinyarwanda"
        WHEN ${locale} LIKE 'ky%' THEN "Kirghiz"
        WHEN ${locale} LIKE 'rn%' THEN "Kirundi"
        WHEN ${locale} LIKE 'ko%' THEN "Korean"
        WHEN ${locale} LIKE 'ku%' THEN "Kurdish"
        WHEN ${locale} LIKE 'lo%' THEN "Laothian"
        WHEN ${locale} LIKE 'la%' THEN "Latin"
        WHEN ${locale} LIKE 'lv%' THEN "Latvian"
        WHEN ${locale} LIKE 'li%' THEN "Limburgish"
        WHEN ${locale} LIKE 'ln%' THEN "Lingala"
        WHEN ${locale} LIKE 'lt%' THEN "Lithuanian"
        WHEN ${locale} LIKE 'mk%' THEN "Macedonian"
        WHEN ${locale} LIKE 'mg%' THEN "Malagasy"
        WHEN ${locale} LIKE 'ms%' THEN "Malay"
        WHEN ${locale} LIKE 'ml%' THEN "Malayalam"
        WHEN ${locale} LIKE 'mt%' THEN "Maltese"
        WHEN ${locale} LIKE 'mi%' THEN "Maori"
        WHEN ${locale} LIKE 'mr%' THEN "Marathi"
        WHEN ${locale} LIKE 'mo%' THEN "Moldavian"
        WHEN ${locale} LIKE 'mn%' THEN "Mongolian"
        WHEN ${locale} LIKE 'na%' THEN "Nauru"
        WHEN ${locale} LIKE 'ne%' THEN "Nepali"
        WHEN ${locale} LIKE 'no%' THEN "Norwegian"
        WHEN ${locale} LIKE 'oc%' THEN "Occitan"
        WHEN ${locale} LIKE 'or%' THEN "Oriya"
        WHEN ${locale} LIKE 'om%' THEN "Oromo"
        WHEN ${locale} LIKE 'ps%' THEN "Pashto"
        WHEN ${locale} LIKE 'pl%' THEN "Polish"
        WHEN ${locale} LIKE 'pt%' THEN "Portuguese"
        WHEN ${locale} LIKE 'pa%' THEN "Punjabi"
        WHEN ${locale} LIKE 'qu%' THEN "Quechua"
        WHEN ${locale} LIKE 'rm%' THEN "Rhaeto-Romance"
        WHEN ${locale} LIKE 'ro%' THEN "Romanian"
        WHEN ${locale} LIKE 'ru%' THEN "Russian"
        WHEN ${locale} LIKE 'sm%' THEN "Samoan"
        WHEN ${locale} LIKE 'sg%' THEN "Sangro"
        WHEN ${locale} LIKE 'sa%' THEN "Sanskrit"
        WHEN ${locale} LIKE 'sr%' THEN "Serbian"
        WHEN ${locale} LIKE 'sh%' THEN "Serbo-Croatian"
        WHEN ${locale} LIKE 'st%' THEN "Sesotho"
        WHEN ${locale} LIKE 'tn%' THEN "Setswana"
        WHEN ${locale} LIKE 'sn%' THEN "Shona"
        WHEN ${locale} LIKE 'sd%' THEN "Sindhi"
        WHEN ${locale} LIKE 'si%' THEN "Sinhalese"
        WHEN ${locale} LIKE 'ss%' THEN "Siswati"
        WHEN ${locale} LIKE 'sk%' THEN "Slovak"
        WHEN ${locale} LIKE 'sl%' THEN "Slovenian"
        WHEN ${locale} LIKE 'so%' THEN "Somali"
        WHEN ${locale} LIKE 'es%' THEN "Spanish"
        WHEN ${locale} LIKE 'su%' THEN "Sundanese"
        WHEN ${locale} LIKE 'sw%' THEN "Swahili"
        WHEN ${locale} LIKE 'sv%' THEN "Swedish"
        WHEN ${locale} LIKE 'tl%' THEN "Tagalog"
        WHEN ${locale} LIKE 'tg%' THEN "Tajik"
        WHEN ${locale} LIKE 'ta%' THEN "Tamil"
        WHEN ${locale} LIKE 'tt%' THEN "Tatar"
        WHEN ${locale} LIKE 'te%' THEN "Telugu"
        WHEN ${locale} LIKE 'th%' THEN "Thai"
        WHEN ${locale} LIKE 'bo%' THEN "Tibetan"
        WHEN ${locale} LIKE 'ti%' THEN "Tigrinya"
        WHEN ${locale} LIKE 'to%' THEN "Tonga"
        WHEN ${locale} LIKE 'ts%' THEN "Tsonga"
        WHEN ${locale} LIKE 'tr%' THEN "Turkish"
        WHEN ${locale} LIKE 'tk%' THEN "Turkmen"
        WHEN ${locale} LIKE 'tw%' THEN "Twi"
        WHEN ${locale} LIKE 'ug%' THEN "Uighur"
        WHEN ${locale} LIKE 'uk%' THEN "Ukrainian"
        WHEN ${locale} LIKE 'ur%' THEN "Urdu"
        WHEN ${locale} LIKE 'uz%' THEN "Uzbek"
        WHEN ${locale} LIKE 'vi%' THEN "Vietnamese"
        WHEN ${locale} LIKE 'vo%' THEN "Volapük"
        WHEN ${locale} LIKE 'cy%' THEN "Welsh"
        WHEN ${locale} LIKE 'wo%' THEN "Wolof"
        WHEN ${locale} LIKE 'xh%' THEN "Xhosa"
        WHEN ${locale} LIKE 'yi%' THEN "Yiddish"
        WHEN ${locale} LIKE 'yo%' THEN "Yoruba"
        WHEN ${locale} LIKE 'zu%' THEN "Zulu"
    ELSE ${locale}
    END;;
  }

  dimension: Gamename {
    description: "Bitmoji Party, Snake Squad etc. Not case sen."
    label: "Game Name"
    type: string
    case_sensitive: no
    group_label: "Games Info"

  }

  dimension: Gameid {
    description: "Unique id for each game"
    label: "Game ID"
    type: string
    case_sensitive: no
    group_label: "Games Info"

  }

  dimension: Game_name_by_id {
    description: "Game name in english from ID"
    label: "Game Name by ID"
    type: string
    case_sensitive: no
    group_label: "Games Info"
    sql: CASE
          WHEN  ${Gameid} = "041f55b7-f26b-42db-854e-ed3aaab80502" THEN "Master Archer"
          WHEN  ${Gameid} = "29d1b781-877e-4087-bfc5-6ce0ed10f89a" THEN "Alphabear Hustle"
          WHEN  ${Gameid} = "6258bb46-35c2-4091-8a42-2d69a53fd2d6" THEN "Bitmoji Party"
          WHEN  ${Gameid} = "77ecc61a-3d73-47a1-a4b2-f02ebdd72c16" THEN "Bitmoji Tennis"
          WHEN  ${Gameid} = "9f1b74c7-2f4a-46f0-967d-ec27a2df50a2" THEN "Zombie Rescue Squad"
          WHEN  ${Gameid} = "cd572b41-0b41-441e-a031-a50470c9c206" THEN "Subway Surfers Airtime"
          WHEN  ${Gameid} = "d6a0d464-a4c4-4697-8d7c-b60690318e39" THEN "C.A.T.S. Drift Race"
          WHEN  ${Gameid} = "e700e7e1-b2d7-47ec-87a5-7d6ef945b110" THEN "Tiny Royale"
          WHEN  ${Gameid} = "ef2cb0a1-0b51-41e2-8046-3a3ee49f7194" THEN "Snake Squad"
          WHEN  ${Gameid} = "ef224247-447d-4233-8e92-83a7b7b6557e" THEN "Ready Chef Go"
          WHEN  ${Gameid} = "c718a395-5906-4cc3-aa2d-cc05c94cc70c" THEN "Slide the Shakes"
          WHEN  ${Gameid} = "7fb13069-4071-4200-bf8a-cb5f6730044e" THEN "Find my Bitmoji"
          WHEN  ${Gameid} = "ca46709e-45d0-47c8-9dce-6c15bf7dc604" THEN "Sliders"
          WHEN  ${Gameid} = "2dc73007-5642-424c-9c29-af550377510b" THEN "Color Galaxy"
          WHEN  ${Gameid} = "09db0dcc-7baa-44fd-b114-f16be0126e49" THEN "Sugar Slam"
          WHEN  ${Gameid} = "a0e69b4a-18db-44c1-b49f-fb78bd877754" THEN "Sling Racers"
          WHEN  ${Gameid} = "4606e9ed-a232-4015-80be-be7a90a77a34" THEN "Flip the Egg"
          --WHEN  ${Gameid} = "9370d3d0-51e0-4186-9ef2-d77889f4a703" THEN "Storm Runners"   --name changed, runners to skaters
          WHEN  ${Gameid} = "1280c8ae-fafa-4b62-a04d-6bc46a4c86b6" THEN "Pizza Cat"
          WHEN  ${Gameid} = "9370d3d0-51e0-4186-9ef2-d77889f4a703" THEN "Storm Skaters" --name changed, so same id exists
          WHEN  ${Gameid} = "77a75158-a2aa-4bbf-839b-739807df6e95" THEN "Island Jump"
          WHEN  ${Gameid} = "fccf855e-a11d-4a79-b1ad-2a00199b27b9" THEN "Mergelings"
          WHEN  ${Gameid} = "ded5eb36-1978-4686-adef-41a198087ada" THEN "Ready Set Golf"
          WHEN  ${Gameid} = "971e25cc-3839-4702-83b8-1fab6b4ce421" THEN "Snow Time"
          WHEN  ${Gameid} = "79aee42b-7cca-4882-b94d-9e2277be3d7f" THEN "Super Snappy Bowling"
          WHEN  ${Gameid} = "df255c59-e0d2-4efe-b8b4-74889499043d" THEN "Bumped Out"
          WHEN  ${Gameid} = "81ec3ce9-8d8a-4809-b302-5667af452ce8" THEN "Lets Do It"
          WHEN  ${Gameid} = "9d6c4bc3-5d01-44cf-bc54-26aea6f57bb2" THEN "Prediction Master"
          WHEN  ${Gameid} = "ae068769-d12d-4bfa-8881-df03fa45970c" THEN "Tembo"
          WHEN  ${Gameid} = "014133eb-17ef-4089-a364-9a8a042ab038" THEN "Headspace"
          WHEN  ${Gameid} = "cc3d0401-bc76-4c58-bdd6-d52d3b48dad4" THEN "Atom"
          ELSE ${Gamename}
          END ;;

    }
    #WHEN  ${Gameid} = "" THEN ""

    dimension: Gameversion {
      description: "Version of the game ex. 1.01"
      label: "Game Version"
      type: string
      case_sensitive: no
      group_label: "Games Info"

    }

    dimension: is_app_loaded {
      description: "Is the game loaded client side?"
      label: "Is Game loaded"
      type: string
      case_sensitive: no
      group_label: "Games Info"

    }

    dimension: app_type {
      description: "Game type - MINI, LEADERBOARD_GAME,MULTIPLAYER_GAME"
      label: "Game App type"
      type: string
      case_sensitive: no
      group_label: "Games Info"

    }

  dimension: preferenceInfo {
    label: "Preference Info"
    type: string
    case_sensitive: no
    hidden: yes
  }


    dimension: isfirstparty {
      description: "Is game first party? true/false"
      label: "Is Game First Party"
      type: string
      case_sensitive: no
      group_label: "Games Info"
    }

    dimension: ArroyoMode {
      description: "Type of Arroyo Mode -OFF, FEED_ONLY, FULL, SHADOW "
      label: "Arroyo Mode"
      type: string
      case_sensitive: no
      group_label: "Feature/Subfeature Info"
    }

    dimension: feature {
      description: "feature"
      group_label: "Feature/Subfeature Info"
      type: string
      sql:
          CASE

          WHEN ${TABLE}.source = 'InSetting'
            THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'Shake' AND LOWER(${TABLE}.UserSelectedFeature) IN ("it wasn't true", "it was harmful or unsafe", "it wasn't helpful", "it was inappropriate", "unhelpful", "untrue", "harmful")
            THEN "my ai"

          WHEN ${TABLE}.source = 'Shake'
            THEN LOWER(${TABLE}.UserSelectedFeature)

          WHEN ${TABLE}.source = 'InGame'
              THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'InCanvas'
              THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'InMap'
              THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'InSnapPro'
              THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'InStoryStudio'
              THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'MyAiReport'
              THEN LOWER(${TABLE}.feature)

          WHEN ${TABLE}.source = 'CallFeedback'
              THEN LOWER(${TABLE}.feature)

          ELSE LOWER(${TABLE}.feature)
              END
              ;;
      case_sensitive: no
    }

    dimension: subfeature {
      description: "subfeature"
      group_label: "Feature/Subfeature Info"
      type: string
      sql:
          CASE
          WHEN ${TABLE}.source = 'InSetting'
            THEN LOWER(${TABLE}.subFeatureNew)

          WHEN ${TABLE}.source = 'Shake'
            THEN LOWER(${TABLE}.subfeature)

          WHEN ${TABLE}.source = 'InGame'
            THEN LOWER(${TABLE}.subFeatureNew)
          WHEN ${TABLE}.source = 'InCanvas'
            THEN LOWER(${TABLE}.subFeatureNew)

          WHEN ${TABLE}.source = 'InMap'
            THEN LOWER(${TABLE}.subFeatureNew)

          WHEN ${TABLE}.source = 'InSnapPro'
            THEN LOWER(${TABLE}.subFeatureNew)

         WHEN ${TABLE}.source = 'InStoryStudio'
            THEN LOWER(${TABLE}.subFeatureNew)

        WHEN ${TABLE}.source = 'MyAiReport'
            THEN LOWER(${TABLE}.subFeatureNew)

          WHEN ${TABLE}.source = 'CallFeedback'
            THEN LOWER(${TABLE}.subFeatureNew)

          ELSE LOWER(${TABLE}.subFeatureNew)
              END;;
      case_sensitive: no
    }

    dimension: connectionType {
      description: "connection type - Wifi or cellular"
      label: "Connection Type"
      type: string
      case_sensitive: no
      group_label: "Connection Info"
    }

  dimension: ispProvider {
    description: "ISP name"
    label: "ISP"
    type: string
    case_sensitive: no
    group_label: "Connection Info"
  }

  dimension: bandwidth {
    type: number
    label: "Bandwidth"
  }

    dimension: reportType {
      description: "Improvement or Problem"
      type: string
      case_sensitive: no
      label: "Report Type"
    }

    dimension: source {
      description: "Shake/InSetting/InCanvas/InMap"
      type: string
      case_sensitive: no

      case: {
        when: {
          sql: ${TABLE}.source = 'Shake' ;;
          label: "Shake"
        }
        when: {
          sql: ${TABLE}.source = 'InSetting' ;;
          label: "InSetting"
        }
        when: {
          sql: ${TABLE}.source = 'RatingInApp' ;;
          label: "RatingInApp"
        }
        when: {
          sql: ${TABLE}.source = 'InGame' OR ${TABLE}.source = 'InCanvas' ;;
          label: "InCanvas"
        }
#       when: {
#         sql:${TABLE}.source = 'InCanvas' ;;
#         label: "InCanvas"
#       }
        when: {
          sql: ${TABLE}.source = 'InMap' ;;
          label: "InMap"
        }
        when: {
          sql: ${TABLE}.source = 'InSnapPro' ;;
          label: "InSnapPro"
        }
        when: {
          sql: ${TABLE}.source = 'SpectaclesInAppReport' ;;
          label: "SpectaclesInAppReport"
        }

        when: {
          sql: ${TABLE}.source = 'InStoryStudio' ;;
          label: "InStoryStudio"
        }

        when: {
          sql: ${TABLE}.source = 'MyAiReport' ;;
          label: "MyAIReport"
        }

        when: {
          sql: ${TABLE}.source = 'CallFeedback' ;;
          label: "CallFeedback"
        }

        else: "Unknown"
      }

    }

    dimension:  has_attachment{
      type: yesno
      sql: CASE
              WHEN ${TABLE}.source = 'InSetting' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'Shake' AND (${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'Shake' AND (${TABLE}.has_screen_captured ='false' AND ${TABLE}.has_camera_roll_attachment ='false') THEN FALSE
              WHEN ${TABLE}.source = 'InMap' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'InGame' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'InCanvas' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'InSnapPro' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'InStoryStudio' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'MyAiReport' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
              WHEN ${TABLE}.source = 'CallFeedback' AND (${TABLE}.has_camera_roll_attachment ='true' OR ${TABLE}.has_screen_captured ='true' OR ${TABLE}.has_screen_capture ='true') THEN TRUE
            ELSE FALSE
            END   ;;


      }
      #re-enabled for now SPT-6064 8-15-19

      dimension: platform {
        sql: ${TABLE}.platform ;;
        type: string
        group_label: "Device Info"
        case_sensitive: no
        description: "iOS or Android"
      }

      dimension: buildFlavor {
        sql: ${TABLE}.buildFlavor ;;
        type: string
        group_label: "App Info"
      }

      dimension: buildFlavor_with_null_as_prod {
        sql: CASE  
               WHEN ${TABLE}.buildFlavor = "" OR ${TABLE}.buildFlavor = "PROD" THEN "Production"  
               WHEN ${TABLE}.buildFlavor = "BETA" THEN "Beta"  
               ELSE ${TABLE}.buildFlavor  
             END ;;
        type: string
        group_label: "App Info"
      }

      dimension: treatmentType {
        sql: ${TABLE}.treatmentType ;;
        description: "Treatment Type = Mushroom or Snapchat"
        type: string
        case_sensitive: no
        group_label: "App Info"
        label: "Treatment Type"
      }

      dimension: userSelectedFeature {
        sql:
               CASE
                 WHEN ${TABLE}.source = 'InSetting'
                  THEN LOWER(${TABLE}.subFeatureNew)

                 WHEN ${TABLE}.source = 'Shake' AND LOWER(${TABLE}.UserSelectedFeature) IN ("it wasn't true", "untrue") THEN "it wasn't true"
                 WHEN ${TABLE}.source = 'Shake' AND LOWER(${TABLE}.UserSelectedFeature) IN ("it was harmful or unsafe", "harmful") THEN "it was harmful or unsafe"
                 WHEN ${TABLE}.source = 'Shake' AND LOWER(${TABLE}.UserSelectedFeature) IN ("it wasn't helpful", "unhelpful") THEN "it wasn't helpful"

                 WHEN ${TABLE}.source = 'Shake'
                    THEN LOWER(${TABLE}.userselectedfeature)

                 WHEN ${TABLE}.source = 'InGame'
                  THEN LOWER(${TABLE}.subFeatureNew)

                  WHEN ${TABLE}.source = 'InCanvas'
                  THEN LOWER(${TABLE}.subFeatureNew)

                 WHEN ${TABLE}.source = 'InMap'
                  THEN LOWER(${TABLE}.subFeatureNew)

                 WHEN ${TABLE}.source = 'InSnapPro'
                  THEN LOWER(${TABLE}.subFeatureNew)

                WHEN ${TABLE}.source = 'InStoryStudio'
                  THEN LOWER(${TABLE}.subFeatureNew)

                WHEN ${TABLE}.source = 'MyAiReport'
                  THEN LOWER(${TABLE}.subFeatureNew)

                WHEN ${TABLE}.source = 'CallFeedback'
                  THEN LOWER(${TABLE}.subFeatureNew)

                ELSE LOWER(${TABLE}.userselectedfeature)

                    END

                ;;
        type: string
        case_sensitive: no
        group_label: "Feature/Subfeature Info"
      }

      dimension: userId {
        sql: ${TABLE}.userId ;;
        type: string
        group_label: "IDs"
        label: "Ghost ID"
      }

      dimension: shakeType {
        label: "Shake Type"
        description: "Internal vs External"
        type: string

        case: {
          when: {
            sql: ${TABLE}.isInternal = false ;;
            label: "External"
          }
          when: {
            sql: ${TABLE}.isInternal = true ;;
            label: "Internal"
          }

          else: "Unknown"
        }
        case_sensitive: no

#     sql: CASE
#           WHEN ${TABLE}.isInternal = '0' THEN 'External'
#           WHEN ${TABLE}.isInternal = '1' THEN 'Internal'
#           ELSE 'Unknown'
#          END ;;
      }

      dimension: canvas_entrypoint {
        sql: ${games_first_source.first_source} ;;
        description: "Canvas entry point- tray, search etc"
        label: "Canvas Entrypoint"
        type: string
        case_sensitive: no
        group_label: "Games Info"
      }

  dimension: new_category {
    type: string
    group_label: "New Categories"
    case_sensitive: no
    hidden: no
    sql:  CASE
      WHEN ${userSelectedFeature} IN ('accessing the camera', 'taking a snap', 'flash', 'camera', 'camera modes', 'long snap', 'camera features') THEN 'Taking Snaps'
      WHEN ${userSelectedFeature} IN ('photo or video quality', 'audio', 'audio issues') THEN 'Troubleshooting Image and Audio Quality'
      WHEN ${userSelectedFeature} IN ('editing a snap', 'stickers', 'giphy', 'using sounds', 'creative tools') THEN 'Editing Snaps'
      WHEN ${userSelectedFeature} IN ('filters') THEN 'Using Filters'
      WHEN ${userSelectedFeature} IN ('face lenses', 'filters and lenses', 'face lenses and world lenses') THEN 'Using Lenses'
      WHEN ${userSelectedFeature} IN ('snaps', '"send to" screen', 'sharing', 'sharing content with friends') THEN 'Sending and Receiving Snaps'
      WHEN ${userSelectedFeature} IN ('adding or removing friends', 'adding friends', 'searching for friends', 'quick add') THEN 'Adding and Removing Friends'
      WHEN ${userSelectedFeature} IN ('search', 'searching for content') THEN 'Search'
      WHEN ${userSelectedFeature} IN ('best friends', 'friendship emojis', 'order of friends') THEN 'Customizing Best Friends and Emojis'
      WHEN ${userSelectedFeature} IN ('chats') THEN 'Sending and Receiving Chats'
      WHEN ${userSelectedFeature} IN ('bitmoji') THEN 'Creating Bitmoji Avatar'
      WHEN ${userSelectedFeature} IN ('group and friendship profiles', 'charms', 'friendship profile') THEN 'Viewing Friendship Profiles'
      WHEN ${userSelectedFeature} IN ('groups', 'group profile') THEN 'Creating and Managing Group Chats'
      WHEN ${userSelectedFeature} IN ('voice or video call', 'voice chat', 'ringing friends', 'ring friends', 'voice') THEN 'Video Chatting and Voice Calling'
      WHEN ${userSelectedFeature} IN ('notifications') THEN 'Toggling Notifications'
      WHEN ${userSelectedFeature} IN ('snapstreaks', 'snap streaks') THEN 'Keeping Snapstreaks'
      WHEN ${userSelectedFeature} IN ('navigation', 'leaderboards', 'game rewards', 'gameplay', 'game is crashing') THEN 'Playing Games'
      WHEN ${userSelectedFeature} IN ('passcode', 'my eyes only snaps', '"my eyes only" snaps') THEN 'Using My Eyes Only'
      WHEN ${userSelectedFeature} IN ('missing memories') THEN 'Troubleshooting Missing Memories'
      WHEN ${userSelectedFeature} IN ('memories not loading', 'flashback', 'camera roll', 'memories') THEN 'Viewing Memories'
      WHEN ${userSelectedFeature} IN ('saving snaps') THEN 'Saving and Deleting Snaps and Chats'
      WHEN ${userSelectedFeature} IN ('exporting content') THEN 'Sending and Sharing Memories'
      WHEN ${userSelectedFeature} IN ('creating a custom story', 'posting stories', 'private or custom stories', 'sharing stories with friends', 'stories') THEN 'Creating Stories'
      WHEN ${userSelectedFeature} IN ('managing your stories', 'story views', 'deleting posts') THEN 'Managing Stories'
      WHEN ${userSelectedFeature} IN ('snapscore', 'my profile', 'profile') THEN 'Editing My Profile'
      WHEN ${userSelectedFeature} IN ('my public profile', 'public profile') THEN 'Creating Public Profile'
      WHEN ${userSelectedFeature} IN ('editing profile', 'editing profile') THEN 'Adding Public Profile Information'
      WHEN ${userSelectedFeature} IN ('highlights', 'lenses') THEN 'Adding Stories and Lenses to Public Profile'
      WHEN ${userSelectedFeature} IN ('privacy settings', 'story privacy settings') THEN 'Changing Privacy Settings'
      WHEN ${userSelectedFeature} IN ('roles', 'posting to your public story', 'story replies and quoting') THEN 'Using Creator Features'
      WHEN ${userSelectedFeature} IN ('insights') THEN 'Viewing Insights and Analytics'
      WHEN ${userSelectedFeature} IN ('username', 'display name') THEN 'Changing Name and Username'
      WHEN ${userSelectedFeature} IN ('birthday') THEN 'Changing Birthday'
      WHEN ${userSelectedFeature} IN ('travel mode', 'data usage', 'battery usage', 'settings') THEN 'Changing Settings'
      WHEN ${userSelectedFeature} IN ('mobile number') THEN 'Verifying Email and Mobile Number'
      WHEN ${userSelectedFeature} IN ('watching stories', 'snap map') THEN 'Viewing Snaps and Stories on the Map'
      WHEN ${userSelectedFeature} IN ('ghost mode', 'your location') THEN 'Sharing My Location and Ghost Mode'
      WHEN ${userSelectedFeature} IN ("friends' location", 'places and venues') THEN 'Finding Friends and Places on the Map'
      WHEN ${userSelectedFeature} IN ('loading', 'favorites', 'subscribing', 'watching content', 'spotlight') THEN 'Exploring Spotlight'
      WHEN ${userSelectedFeature} IN ('views', 'posting to spotlight', 'post to spotlight') THEN 'Submitting Snaps to Spotlight'
      WHEN ${userSelectedFeature} IN ("friends' stories", 'order of stories', 'publisher stories', 'shows', 'stories and discover', 'searching for content', 'content', 'discover') THEN 'Viewing Stories'
      WHEN ${userSelectedFeature} IN ('hiding content', 'subscriptions') THEN 'Subscribing to and Hiding Stories'
      WHEN ${userSelectedFeature} IN ('audio and sounds', 'captions', 'effects', 'managing projects', 'speed', 'timeline media', 'video export and sharing') THEN 'Creating with Story Studio'
      WHEN ${userSelectedFeature} IN ('other', 'other (please describe)') THEN 'Other'
      WHEN ${userSelectedFeature} IN ('ads') THEN 'Reporting Advertisements'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'camera' THEN 'Taking Snaps'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'snap map' THEN 'Viewing Snaps and Stories on the Map'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'friends' THEN 'Sending and Receiving Chats'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'profile' THEN 'Editing My Profile'
      WHEN ${userSelectedFeature} IN ('app is crashing', 'crashing') AND (${feature} = 'games' OR ${feature} = 'games_and_minis' OR ${feature} = 'minis') THEN 'Playing Games'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'search' THEN 'Adding and Removing Friends'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'memories' THEN 'Viewing Memories'
      WHEN ${userSelectedFeature} = 'app is crashing' AND (${feature} = 'stories and discover' OR ${feature} = 'stories_and_discover') THEN 'Creating Stories'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'snap_pro' THEN 'Creating Public Profile'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'spotlight' THEN 'Exploring Spotlight'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} IN ('settings', 'app is crashing') THEN 'Troubleshooting an App Crash'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'camera' THEN 'Taking Snaps'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'snap map' THEN 'Viewing Snaps and Stories on the Map'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'friends' THEN 'Adding and Removing Friends'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'profile' THEN 'Troubleshooting an App Crash'
      WHEN ${userSelectedFeature} = 'accessibility' AND (${feature} = 'games' OR ${feature} = 'games_and_minis' OR ${feature} = 'minis') THEN 'Playing Games'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'search' THEN 'Search'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'memories' THEN 'Viewing Memories'
      WHEN ${userSelectedFeature} = 'accessibility' AND (${feature} = 'stories and discover' OR ${feature} = 'stories_and_discover') THEN 'Creating Stories'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'snap_pro' THEN 'Creating a Public Profile'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'spotlight' THEN 'Exploring Spotlight'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} IN ('settings', 'accessibility') THEN 'Accessibility Features'
      ELSE ${userSelectedFeature}
      END;;
  }

  dimension: new_category_group {
    type: string
    group_label: "New Categories"
    hidden: no
    sql:  CASE
      WHEN ${userSelectedFeature} IN ('accessing the camera', 'taking a snap', 'flash', 'camera', 'camera modes', 'long snap', 'editing a snap', 'stickers', 'camera features', 'giphy', 'using sounds', 'creative tools', 'photo or video quality', 'audio', 'audio issues') THEN 'Create Snaps'
      WHEN ${userSelectedFeature} IN ('filters', 'face lenses', 'filters and lenses', 'face lenses and world lenses') THEN 'Filters and Lenses'
      WHEN ${userSelectedFeature} IN ('snaps', '"send to" screen', 'sharing', 'sharing content with friends', 'chats', 'groups', 'group profile', 'voice or video call', 'voice chat', 'ringing friends', 'ring friends', 'voice', 'saving snaps', 'snapstreaks', 'snap streaks') THEN 'Chat'
      WHEN ${userSelectedFeature} IN ('best friends', 'friendship emojis', 'order of friends', 'adding or removing friends', 'adding friends', 'searching for friends', 'quick add', 'search', 'group and friendship profiles', 'charms', 'friendship profile') THEN 'My Friends'
      WHEN ${userSelectedFeature} IN ('bitmoji', 'snapscore', 'my profile', 'profile') THEN 'My Profile'
      WHEN ${userSelectedFeature} IN ('navigation', 'leaderboards', 'game rewards', 'gameplay', 'game is crashing') THEN 'Games and Minis'
      WHEN ${userSelectedFeature} IN ('passcode', 'my eyes only snaps', '"my eyes only" snaps', 'missing memories', 'memories not loading', 'flashback', 'camera roll', 'memories', 'exporting content') THEN 'Memories'
      WHEN ${userSelectedFeature} IN ('creating a custom story', 'posting stories', 'private or custom stories', 'sharing stories with friends', 'stories', 'managing your stories', 'story views', 'deleting posts', "friends' stories", 'order of stories', 'publisher stories', 'shows', 'stories and discover', 'searching for content', 'content', 'discover', 'hiding content', 'subscriptions') THEN 'Stories and Discover'
      WHEN ${userSelectedFeature} IN ('my public profile', 'editing profile', 'highlights', 'lenses', 'editing profile', 'other', 'public profile', 'roles', 'posting to your public story', 'story replies and quoting', 'insights', 'audio and sounds', 'captions', 'effects', 'managing projects', 'speed', 'timeline media', 'video export and sharing') THEN 'Public Profile and Creator Features'
      WHEN ${userSelectedFeature} IN ('privacy settings', 'story privacy settings') THEN 'Privacy'
      WHEN ${userSelectedFeature} IN ('username', 'display name', 'birthday', 'mobile number') THEN 'Managing Account'
      WHEN ${userSelectedFeature} IN ('travel mode', 'data usage', 'battery usage', 'settings', 'notifications') THEN 'Settings'
      WHEN ${userSelectedFeature} IN ('places and venues', 'watching stories', 'snap map', "friends' location", 'ghost mode', 'your location') THEN 'Snap Map'
      WHEN ${userSelectedFeature} IN ('loading', 'favorites', 'subscribing', 'watching content', 'spotlight', 'views', 'posting to spotlight', 'post to spotlight') THEN 'Spotlight'
      WHEN ${userSelectedFeature} IN ('other', 'other (please describe)') THEN 'Other'
      WHEN ${userSelectedFeature} IN ('ads') THEN 'Report Content'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'camera' THEN 'Create Snaps'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'snap map' THEN 'Snap Map'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'friends' THEN 'Chat'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'profile' THEN 'Settings'
      WHEN ${userSelectedFeature} IN ('app is crashing', 'crashing') AND (${feature} = 'games' OR ${feature} = 'games_and_minis' OR ${feature} = 'minis') THEN 'Games and Minis'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'search' THEN 'My Friends'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'memories' THEN 'Memories'
      WHEN ${userSelectedFeature} = 'app is crashing' AND (${feature} = 'stories and discover' OR ${feature} = 'stories_and_discover') THEN 'Stories and Discover'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'snap_pro' THEN 'Public Profile and Creator Features'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} = 'spotlight' THEN 'Spotlight'
      WHEN ${userSelectedFeature} = 'app is crashing' AND ${feature} IN ('settings', 'app is crashing') THEN 'Settings'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'camera' THEN 'Create Snaps'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'snap map' THEN 'Snap Map'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'friends' THEN 'My Friends'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'profile' THEN 'My Profile'
      WHEN ${userSelectedFeature} = 'accessibility' AND (${feature} = 'games' OR ${feature} = 'games_and_minis' OR ${feature} = 'minis') THEN 'Games and Minis'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'search' THEN 'Search'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'memories' THEN 'Memories'
      WHEN ${userSelectedFeature} = 'accessibility' AND (${feature} = 'stories and discover' OR ${feature} = 'stories_and_discover') THEN 'Stories and Discover'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'snap_pro' THEN 'Public Profile and Creator Features'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} = 'spotlight' THEN 'Spotlight'
      WHEN ${userSelectedFeature} = 'accessibility' AND ${feature} IN ('settings', 'accessibility') THEN 'Settings'
      ELSE ${userSelectedFeature}
      END;;
  }

  dimension: otherJsonMerlinFullConvo {
    sql: REPLACE(REPLACE(REPLACE(${TABLE}.MerlinFullConvo, "\\u0027", "'"), "\\n", ""), "MERLIN", "My AI");;
    description: "The full conversation between the User and My AI"
    label: "MyAI Conversation"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }


  dimension: otherJsonMerlinZero {
    sql: if(${TABLE}.MerlinSecond IS NOT NULL, REPLACE(REPLACE(${TABLE}.MerlinZero, "\\u0027", "'"), "\\n", ""), NULL) ;;
    description: "My AI response before User Prompt 1 in a 5 chat conversation, or following User Prompt 0"
    label: "My AI Response 0"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonMerlinUserZero {
    sql: if(${TABLE}.MerlinUserSecond IS NOT NULL, REPLACE(REPLACE(${TABLE}.MerlinUserZero, "\\u0027", "'"), "\\n", ""), NULL) ;;
    description: "First User Prompt in a 6 chat conversation"
    label: "User Prompt 0"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonMerlinFirst {
    sql: if(${TABLE}.MerlinSecond IS NOT NULL, REPLACE(REPLACE(${TABLE}.MerlinFirst, "\\u0027", "'"), "\\n", ""), REPLACE(REPLACE(${TABLE}.MerlinZero, "\\u0027", "'"), "\\n", "")) ;;
    description: "My AI response to User Prompt 1"
    label: "My AI Response 1"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonMerlinSecond {
    sql: if(${TABLE}.MerlinSecond IS NULL, REPLACE(REPLACE(${TABLE}.MerlinFirst, "\\u0027", "'"), "\\n", ""), REPLACE(REPLACE(${TABLE}.MerlinSecond, "\\u0027", "'"), "\\n", "")) ;;
    description: "My AI response to User Prompt 2"
    label: "My AI Response 2"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonMerlinUserFirst {
    sql: if(${TABLE}.MerlinUserSecond IS NULL, REPLACE(REPLACE(${TABLE}.MerlinUserZero, "\\u0027", "'"), "\\n", ""), REPLACE(REPLACE(${TABLE}.MerlinUserFirst, "\\u0027", "'"), "\\n", "")) ;;
    description: "First User prompt with a My AI response "
    label: "User Prompt 1"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonMerlinUserSecond {
    sql: if(${TABLE}.MerlinUserSecond IS NULL, REPLACE(REPLACE(${TABLE}.MerlinUserFirst, "\\u0027", "'"), "\\n", ""), REPLACE(REPLACE(${TABLE}.MerlinUserSecond, "\\u0027", "'"), "\\n", "")) ;;
    description: "Second User prompt with a My AI response"
    label: "User Prompt 2"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonMerlinSelectedChat {
    sql: REPLACE(REPLACE(${TABLE}.MerlinSelectedChat, "\\u0027", "'"), "\\n", "");;
    description: "The My AI Chat reported in the conversation"
    label: "My AI Selected Chat"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  dimension: otherJsonInfoRaw {
    sql: ${TABLE}.otherJsonInfo ;;
    description: "Raw otherJsonInfo field"
    label: "otherJsonInfoRaw"
    type: string
    case_sensitive: no
    group_label: "My AI"
    required_access_grants: [can_view_merlin_data]
  }

  ## Camera State


  dimension: cameraServiceState {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Camera Service State"
  }

  dimension: openAttemptCameraApi {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Open Attempt Camera API"
  }

  dimension: openAttemptCameraDirection {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Open Attempt Camera Direction"
  }

  dimension: openAttemptCameraUsageType {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Open Attempt Camera Usage Type"
  }

  dimension: openAttemptCameraId {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Open Attempt Camera ID"
  }

  dimension: cameraSessionId {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Camera Session ID"
  }

  dimension: lastCaptureSessionId {
    description: "TODO"
    type: string
    group_label: "Camera Info"
    label: "Last Capture Session ID"
  }

  dimension: lastCameraOrientation {
      description: "TODO"
      type: string
      group_label: "Camera Info"
      label: "Last Camera Orientation"
  }

  dimension: lastCameraDirection {
        description: "TODO"
        type: string
        group_label: "Camera Info"
        label: "Last Camera Direction"
  }

  ## Lenses Info

  dimension: activeLensId {
    description: "Active Lens ID"
    type: string
    group_label: "Lenses Info"
    label: "Active Lens ID"
  }
  
  dimension: sessionId {
    sql: ${TABLE}.sessionId ;;
    description: "Blizzard Session ID"
    type: string
    group_label: "Identity"
    label: "Blizzard Session ID"
  }

  ## Messaging Info

  dimension: lastConversationId {
    description: "Last Conversation ID"
    type: string
    group_label: "Messaging Info"
    label: "Last Conversation ID"
  }

  ## Notification Info

  dimension: lastNotificationId {
    description: "Last Notification ID"
    type: string
    group_label: "Notification Info"
    label: "Last Notification ID"
  }

  ## internal shakes
  dimension : shakeFrequency {
    description: "Frequency of shakes"
    type: string
    group_label: "Internal Shakes"
    label: "Shake Frequency"
    sql: LOWER(REPLACE(shakeFrequency, "SHAKE_FREQUENCY_", "")) ;;
  }

  dimension : shakeSensitivity {
    description: "Sensitivity of shakes"
    type: string
    group_label: "Internal Shakes"
    label: "Shake Sensitivity"
    sql: LOWER(REPLACE(shakeSensitivity, "SHAKE_", "")) ;;
  }

  dimension: jiraTicketKey {
    description: "Jira Ticket Key"
    type: string
    group_label: "Internal Shakes"
    html: <a target="_blank" href="https://jira.sc-corp.net/browse/{{ value }}">{{ value }}</a> ;;
  }

  ## measures
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_users {
    type: number
    sql: count(${userId}) ;;
  }

  measure: number_of_unique_user {
    type: count_distinct
    sql: COALESCE(${userId},NULL) ;;
    drill_fields: [detail*]
  }

  measure: number_of_distinct_days {
    type: count_distinct
    sql: COALESCE(${event_date},NULL) ;;
  }

      set: detail {
        fields: [
          event_pst_time,
          feature,
          subfeature,
          source,
          country,
          devicename,
          deviceOS,
          deviceModel,
          appVersion,
          buildFlavor_with_null_as_prod,
          userId,
          reportId,
          description,
          jiraTicketKey,
        ]
      }
  }

view: in_app_reports_stdsql__ab_tests {
  dimension: segment {
    type: string
    sql: in_app_reports_stdsql__ab_tests.Segment ;;
  }

  dimension: experiment_id {
    type: string
    sql: in_app_reports_stdsql__ab_tests.ExperimentID ;;
  }
}
