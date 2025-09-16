# most active contributor jbabra@snapchat.com
include: "//hub_looker_production/common/common_blizzard.view"
view: s2r_android_user {
  extends: [country_groups]


  derived_table: {

    sql:
            SELECT
              source
              ,feature
              ,subFeature AS subFeatureNew
              ,report_id AS reportid
              ,user_id AS userid
              ,UPPER(type) AS reportType
              ,reportClientTime AS creationTime
              ,IFNULL(REGEXP_EXTRACT(userAgent, r'Snapchat\/([\d+.]+[\d])\s?[a-zA-Z]*\s[\(][^;]+;.+'), 'Unknown') AS appVersion
              ,IFNULL(REGEXP_EXTRACT(userAgent, r'Snapchat\/[\d+.]+[\d]\s?[a-zA-Z]*\s[\(][^;]+;\s([^#;]+).+'), 'Unknown') AS deviceOs
              ,LOWER(JSON_EXTRACT_SCALAR(deviceinfo, "$.model")) AS deviceModel
              ,JSON_EXTRACT_SCALAR(deviceinfo, "$.name") AS devicename
              ,JSON_EXTRACT_SCALAR(deviceinfo, "$.maker") AS devicebrand
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.country") AS country
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.region") AS region
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.city") AS city
              ,JSON_EXTRACT_SCALAR(localeinfo, "$.locale") AS locale
              --,REGEXP_EXTRACT(otherJsonInfo, r'\"source_screen_feature_team\":\"(\w+)\"') AS featureTeam
              ,REGEXP_EXTRACT(otherJsonInfo, r'\"source_screen\":\"(\w+)\"') AS subfeature
              ,REGEXP_EXTRACT(otherJsonInfo, r'"game_name":"([^"]*)"') AS Gamename
              ,REGEXP_EXTRACT(otherJsonInfo, r'"game_id":"([^"]*)"') AS Gameid
              ,REGEXP_EXTRACT(otherJsonInfo, r'"is_first_party":(\w+)') AS isfirstparty
              ,REGEXP_EXTRACT(otherJsonInfo, r'"arroyo_mode":"([^"]*)"') AS ArroyoMode
              ,REGEXP_EXTRACT(otherJsonInfo, r'"build_version":"([^"]*)"') AS Gameversion
              ,REGEXP_EXTRACT(otherJsonInfo, r'"has_camera_roll_attachment":(\w+)') AS has_camera_roll_attachment  --insetting
              ,REGEXP_EXTRACT(otherJsonInfo, r'"has_screen_captured":(\w+)') AS has_screen_captured  --s2r
              ,REGEXP_EXTRACT(otherJsonInfo, r'"has_screen_capture":(\w+)') AS has_screen_capture  --inCanvas discrepancy
              ,COALESCE(translatedData, description)  AS description_translated
            ,description AS original_description
            ,JSON_EXTRACT_SCALAR(networkinfo, "$.connectionType") AS connectionType
            ,JSON_EXTRACT_SCALAR(networkinfo, "$.ispProvider") AS ispProvider
            ,NULL AS bandwidth
            ,STRING(internal) AS isInternal
            ,CASE
              WHEN userAgent CONTAINS 'iOS'
                THEN 'iOS'
              WHEN userAgent CONTAINS 'Android'
                THEN 'Android'
              ELSE 'Unknown'
             END AS platform
            ,JSON_EXTRACT_SCALAR(appinfo, "$.buildFlavor") AS buildFlavor
            ,JSON_EXTRACT_SCALAR(appinfo, "$.name") AS treatmentType
            ,feature AS userSelectedFeature
            , 'V2' AS tableType
            ,REGEXP_EXTRACT(otherJsonInfo, r'"is_app_loaded":(\w+)') AS is_app_loaded
            ,REGEXP_EXTRACT(otherJsonInfo, r'"app_type":"([^"]*)"') AS app_type
          ,REGEXP_REPLACE( REGEXP_REPLACE(REGEXP_REPLACE(preferenceInfo,r'({"name"\s?:")|(\{"experiment":\s?\[)|(\]\})',""), r'(\"\,\"value\":\")',"("), r'\"\}', ")") AS real_time_ab
             --,'' AS username
              --,'' AS shakeSensitivity
              --,'' AS deviceScore
              --,'' AS deviceMake
              --,'' AS friendUsername
              --,'' AS isp
              --,'' AS cheetahTreatment
          FROM [lookinsoclear:app_insights.air_reports]
           WHERE _PARTITIONTIME >= TIMESTAMP('2020-04-09')
          AND NOT (otherJsonInfo CONTAINS "{\"from_test_automation\":true}")
     ;;
  }



dimension: random {
  sql: (floor(RAND()*10000)+1) ;;
  description: "Add to results to get random results"
  type: number
}

  ## dimensions

  dimension: event_creationtime {
    hidden: yes
    type: date
    sql: DATE(${TABLE}.creationTime) ;;
  }

  dimension_group: event {
    label: "Event UTC"
    type: time
    sql: ${TABLE}.creationTime ;;
  }

  dimension_group: event_pst {
    label: "Event PST"
    description: "Offset -7 hours from UTC"
    type: time
    sql: DATE_ADD(${TABLE}.creationTime,-7,'HOUR') ;;
  }

  dimension: datefilter {
    type: date
    sql: DATE_ADD(${TABLE}.creationTime,-7,'HOUR');;
    hidden: yes
    label: "PST required filter "
    description: "This filter is required for date bound & is in Pacific time"
  }

  dimension_group: 15min_increment {
    label: "PST in 15 min increment"
    description: "15 Mins Increment in PST"
    type: time
    sql: DATE_ADD(${TABLE}.creationTime,-7,'HOUR') ;;
    #sql: TIMESTAMP_SUB(TIMESTAMP_SECONDS(15*60 * DIV(UNIX_SECONDS(${TABLE}.creationTime), 15*60)), INTERVAL 7 HOUR)  ;;
    convert_tz: no
    timeframes: [minute15]
  }

  dimension_group: 30min_increment {
    label: "PST in 30 min increment"
    description: "30 Mins Increment in PST"
    type: time
    sql: DATE_ADD(${TABLE}.creationTime,-7,'HOUR') ;;
    # sql: TIMESTAMP_SUB(TIMESTAMP_SECONDS(30*60 * DIV(UNIX_SECONDS(${TABLE}.creationTime), 30*60)), INTERVAL 7 HOUR)  ;;
    convert_tz: no
    timeframes: [minute30]
  }

  dimension: tableType {
    description: "flag for V1 or V2"
    sql: ${TABLE}.tableType ;;
    type: string
    case_sensitive: no
    label: "Tabel Type"
  }

  dimension: reportId {
    label: "Report ID"
    description: "reportId unique for a report"
    group_label: "IDs"
    type: string
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
  }

  dimension: appVersion_Primary {
    description: "Primary App Version, ie. 10.7"
    group_label: "App Info"
    type: string
    sql: REGEXP_EXTRACT(${appVersion},r'(\d+\.\d+)') ;;
  }

  dimension: deviceOS {
    description: "Android 8.1.0 OR iOS 12.0.1"
    type: string
    case_sensitive: no
    group_label: "Device Info"
    label: "Device OS"
  }

  dimension: deviceOS_group {
    description: "Android or iOS 12.1, 12.2"
    label: "Device OS Group"
    type: string
    sql: left(${TABLE}.deviceOS,8) ;;
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
        END     ;;
    group_label: "Location Info"
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


  dimension: real_time_ab {
    description: "Real time AB test from preferenceinfo"
    label: "Real Time AB tests"
    type: string
    case_sensitive: no
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

  dimension: reportType {
    description: "Improvement or Problem"
    type: string
    case_sensitive: no
    label: "Report Type"
  }

  dimension: source {
    description: "Shake/InSetting/InCanvas/InMap/InSnapPro"
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
            ELSE FALSE
            END  ;;


    }
    #re-enabled for now SPT-6064 8-15-19

    dimension: platform {
      sql: ${TABLE}.platform ;;
      type: string
      group_label: "Device Info"
      case_sensitive: no
    }

    dimension: buildFlavor {
      sql: ${TABLE}.buildFlavor ;;
      type: string
      group_label: "App Info"
    }

    dimension: buildFlavor_with_null_as_prod {
      sql: IF(${TABLE}.buildFlavor is null, "Production",  ${TABLE}.buildFlavor);;
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
          sql: ${TABLE}.isInternal = '0' ;;
          label: "External"
        }
        when: {
          sql: ${TABLE}.isInternal = '1' ;;
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

    ## measures

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    measure: number_of_unique_user {
      type: count_distinct
      sql: COALESCE(${userId},NULL) ;;
      drill_fields: [detail*]
      approximate_threshold: 100000
    }

    set: detail {
      fields: [
        event_pst_time,
        feature,
        subfeature,
        source,
        country,
        # has_attachment,
        devicename,
        deviceOS,
        deviceModel,
        appVersion,
        buildFlavor_with_null_as_prod,
        userId,
        reportId,
        description,
        # Gamename,
        zendesk_ticket.ml_issue_category_l1,
        zendesk_ticket.ml_issue_category_l2,
        zendesk_ticket.ml_issue_category_l3,
        zendesk_ticket.url
      ]
    }

    #Old deactivated fields

#   measure: avg_bandwidth {
#     type: average
#     sql: ${TABLE}.bandwidth ;;
#     drill_fields: [detail*]
#   }

#   dimension: bandwidth {
#     description: "bandwidth"
#     type: number
#   }

#   dimension: bandwidth_group {
#     description: "bandwidth_group"
#     type: number
#     sql: CASE
#           WHEN ${TABLE}.bandwidth >=500000 THEN 500000
#         ELSE floor(${TABLE}.bandwidth/1000)*1000
#         END
#          ;;
#   }

#   dimension: ISP {
#     description: "ISP"
#     type: string
#     sql: ${TABLE}.isp ;;
#     case_sensitive: no
#   }

#   dimension: featureTeam {
#     description: "feature team"
#     group_label: "Feature/Subfeature Info"
#     type: string
#     case_sensitive: no
#   }

#   dimension: deviceMake {
#     description: "deviceMake"
#     sql: ${TABLE}.deviceMake ;;
#     type: string
#     case_sensitive: no
#   }

#   dimension: appVersion_primary_type {
#     description: "Version type is 'current', 'previous', or 'other'. Field must be manually updated upon version update."
#     sql: CASE WHEN ${appVersion_Primary} = "10.26" THEN 'current' WHEN ${appVersion_Primary} = "10.25" THEN 'previous' ELSE 'other' END ;;
#   }

#   dimension: devicescore {
#     description: "device score"
#     sql: ${TABLE}.devicescore ;;
#     type: string
#   }

#    filter: date_filter {
#      label: "Date UTC Filter"
#      type: date
#     sql: ${TABLE}.creationTime ;;
#   }

#   dimension: username {
#     description: "username"
#     sql: ${TABLE}.username ;;
#     type: string
#   }

#   dimension: friendUsername {
#     description: "friendUsername"
#     type: string
#     sql: ${TABLE}.friendUsername ;;
#   }
  }
