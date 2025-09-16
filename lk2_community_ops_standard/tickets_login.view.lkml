view: tickets_login {

  derived_table: {
    sql:
    SELECT
        ev.ticket_id AS ticket_id,
       -- JSON_EXTRACT_SCALAR(ev.child_json, '$.custom_ticket_fields.24281229') AS extract_un,
        tx.created_at AS tic_create_ts,
        tx.group_id AS group_id,
        un_map.ghost_id AS ghost_id,
        login.app_login AS app_login_count,
        login.reachability AS reachability,
        TIMESTAMP_MILLIS(login.event_date_hour_last_millis) as login_ts,
        DATE_DIFF(DATE(TIMESTAMP_MILLIS(login.event_date_hour_last_millis)), DATE(tx.created_at), day) as login_to_tic_created,
        tx.assignee_id AS assignee_id,
        tx.status AS status,
        tx.total_time_spent AS total_time_spent,
        tx.tag AS tag,
        intx.issue_category AS initial_category,
        intx.issue_subcategory AS initial_subcategory,
        intx.form_name AS initial_form,
        intx.tags AS initial_tags

        FROM `sc-analytics.report_zendesk.ticket_events`  ev
        LEFT JOIN `sc-analytics.report_zendesk.ticket_distinct` tx
        ON ev.ticket_id = tx.id
        LEFT JOIN  `sc-targeting-measurement.user_ids.ghost_id_with_username_20220228`   un_map
        ON JSON_EXTRACT_SCALAR(ev.child_json, '$.custom_ticket_fields.24281229') = un_map.user_name
        LEFT JOIN `sc-portal.quest.app_app_login_user_202202*` login
        ON login.ghost_user_id = un_map.ghost_id
        LEFT JOIN  `sc-analytics.report_zendesk.ticket_initials_20220228`  intx
        ON intx.ticket_id = ev.ticket_id

        WHERE DATE(_PARTITIONTIME) >= "2022-02-01" and
        --ev.ticket_id = 223367238 and
        ev.child_via = "Web service" and
        ev.child_event_type = "Create" and
        ev.child_json like '%24281229%' and
        tx.tag like '%l-username-match%' and
        tx.group_id IN (360004392031 ,23801005 ,360003992931) and
        DATE(tx.created_at) >= "2022-02-01"

        ;;
  }

  dimension: ticket_id {
    type: number
  }

  dimension: url {
    type: string
    label: "Ticket URL"
    sql: CONCAT('https://snapchat.zendesk.com/agent/tickets/',${ticket_id}) ;;
    html: <a href="{{ value }}" target="_blank">{{ value }}</a>;;
    }


  dimension_group: tic_create_ts {
    type: time
    timeframes: [date, week, month, year, week_of_year, month_num, time, time_of_day, raw]
    sql: TIMESTAMP_SUB(${TABLE}.tic_create_ts, INTERVAL 8 HOUR)  ;;
    convert_tz: no
    label: "Ticket Created PST"
  }

  dimension: group_id {
    type: number
  }

  dimension: group_name {
    type: string
    sql: CASE WHEN ${group_id} = 360004392031 THEN "Identity Operations L1"
              WHEN ${group_id} = 23801005 THEN "Identity Operations L2"
              WHEN ${group_id} = 360003992931 THEN "Identity Operations L3"
              ELSE "other" END
    ;;
  }

  dimension: ghost_id {
    type: string
  }

  dimension: app_login_count {
    type: number
  }

  dimension: reachability {
    type: string
  }

  dimension: assignee_id {
    type: number
  }

  dimension: status {
    type: string
    case_sensitive: no
  }

    dimension: tag {
      type: string
      case_sensitive: no
    }

  dimension: total_time_spent_s {
    label: "Total Time Spent Seconds"
    type: number
    sql: (${TABLE}.total_time_spent) ;;
    value_format: "0"
    description: "Total time spent on a ticket by agents"
  }

  dimension: is_tickets_automated {
    type: yesno
    sql: CASE
        WHEN (${assignee_id} = 919733069 OR ${assignee_id} is NULL) AND ${total_time_spent_s} is NULL AND ${status} IN ("solved", "closed") THEN TRUE
        ELSE FALSE
        END
        ;;
    description: "Automated tickets are assigned to zendesk email or null, have total time spent 0"
    label: "Is Fully Automated"
  }

  dimension_group: login_ts {
    type: time
    timeframes: [date, week, month, year, week_of_year, month_num, time, time_of_day, raw]
    sql: TIMESTAMP_SUB(${TABLE}.login_ts, INTERVAL 8 HOUR)  ;;
    convert_tz: no
    label: "Login PST"
  }

  dimension: login_to_tic_created {
    type: number
  }

  dimension: login_7 {
    type: yesno
    sql: CASE WHEN ${login_to_tic_created} >= 0 AND ${login_to_tic_created} <=7 THEN TRUE ELSE FALSE END ;;
  }

  dimension: initial_category {
    type: string
  }

  dimension: initial_subcategory {
    type: string
  }

  dimension: initial_form {
    type: string
  }

  dimension: initial_tags {
    type: string
  }

  dimension: Help_center_entry_point {
    type: string
    sql: CASE

        WHEN ${initial_form} = "ar-2" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-hacked-account' AND ${initial_tags} CONTAINS 'copm-2040'  )  THEN "I think my account was compromised"
        WHEN ${initial_form} = "ar-2" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-hacked-account' )  THEN "I can't access my account > I think my account was hacked"
        WHEN ${initial_form} = "ar-2" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-password-reset' )  THEN "I can't access my account > I forgot my password"
        WHEN ${initial_form} = "ar-2" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-signup-issue' )  THEN "I can't access my account > I can't create an account"
        WHEN ${initial_form} = "ar-2" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-account-verification' )  THEN "I can't access my account > I can't verify my email or mobile number"
        WHEN ${initial_form} = "ar-2" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-login-verification' )  THEN "I can't access my account > I don't have my login Verification Code"
        WHEN ${initial_form} IN ("bugs-2", "ar-2") AND ( ${initial_tags} CONTAINS 'ca-bugs-login-error' AND ${initial_tags} CONTAINS 'cant-login'  AND ${initial_tags} CONTAINS 'open-app'  )  THEN "I can't access my account > I see an error message when I log in"
        WHEN ${initial_form} IN ("ar-2", "ts-all-abuse-1") AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-information-conflict' AND ${initial_tags} CONTAINS 'account-conflict'  )  THEN "Report a safety concern > My Snapchat account > Someone is using my phone number or email address"
        WHEN ${initial_form} = "bugs-2" AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-account-settings' AND ${initial_tags} CONTAINS 'sca-settings'  )  THEN "Report a safety concern > My Snapchat account > My privacy settings don't seem like they're working properly"
        WHEN ${initial_form} = "bugs-2" AND ( ${initial_tags} CONTAINS 'ca-web-uploader'  )  THEN "I found a bug in the app > Web Uploader"
        WHEN ${initial_form} = "feedback-1" AND ( ${initial_tags} CONTAINS 'ca-web-uploader'  )  THEN "I need help with a Snapchat feature > Web Uploader"

        WHEN ${initial_form} = "ts-impersonation-1b" AND (${initial_tags} CONTAINS 'ts'  AND ${initial_tags} CONTAINS 'ca-impersonation' )  THEN "Report a safety concern > My Snapchat account > Another Snapchat account is pretending to be me"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-nudity'  AND ${initial_tags} CONTAINS 'sca-first-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Sexual Content > Me"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-nudity'  AND ${initial_tags} CONTAINS 'sca-third-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Sexual Content > Someone else"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-harassment'  AND ${initial_tags} CONTAINS 'sca-first-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Harassment > I am being harassed"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-harassment'  AND ${initial_tags} CONTAINS 'sca-third-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Harassment > They are harassing other people"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'cf-ts-content-story'  AND ${initial_tags} CONTAINS 'viewed-story' AND ${initial_tags} CONTAINS 'ca-threat'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Threatening or violent content"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-dangerous'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Dangerous or harmful content"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-spam'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they posted to their Story > Spam"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-nudity'  AND ${initial_tags} CONTAINS 'sca-first-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Sexual Content > Me"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-nudity'  AND ${initial_tags} CONTAINS 'sca-third-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Sexual Content > Someone else"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-harassment'  AND ${initial_tags} CONTAINS 'sca-first-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Harassment > I am being harassed"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-harassment'  AND ${initial_tags} CONTAINS 'sca-third-person'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Harassment > They are harassing other people"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-threat'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Threatening or violent content"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-dangerous'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Dangerous or harmful content"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'snap-or-chat'  AND ${initial_tags} CONTAINS 'cf-ts-content-snap-chat' AND ${initial_tags} CONTAINS 'ca-spam'  )  THEN "Report a safety concern > Someone else's Snapchat account > Something they sent me directly > Spam"
        WHEN ${initial_form} = "ar-4" AND (${initial_tags} CONTAINS 'ar'  AND ${initial_tags} CONTAINS 'ca-information-conflict' AND ${initial_tags} CONTAINS 'account-conflict'  )  THEN "Report a safety concern > Someone is using my phone number or email address"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'ts'  AND ${initial_tags} CONTAINS 'account' AND ${initial_tags} CONTAINS 'ca-safety-concern'  AND ${initial_tags} CONTAINS 'sca-user-passed'  )  THEN "Report a safety concern > The person passed away"
        WHEN ${initial_form} = "ts-all-abuse-1" AND (${initial_tags} CONTAINS 'ts'  AND ${initial_tags} CONTAINS 'account' AND ${initial_tags} CONTAINS 'ca-safety-concern'  )  THEN "Report a safety concern > Someone's safety"
        WHEN ${initial_form} = "ts-all-abuse-1b" AND (${initial_tags} CONTAINS 'ts'  AND ${initial_tags} CONTAINS 'account' AND ${initial_tags} CONTAINS 'ca-safety-concern'  AND ${initial_tags} CONTAINS 'sca-under-13'  )  THEN "Report a safety concern > The person is under the age of 13"
        WHEN ${initial_form} = "ts-reported-content-2" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-group-stories'  AND ${initial_tags} CONTAINS 'sca-safety-concern'  )  THEN "Report a safety concern > A Story > I still have a concern about this content"
        WHEN ${initial_form} = "ts-reported-content-3" AND (${initial_tags} CONTAINS 'cf-ts-content-story'  AND ${initial_tags} CONTAINS 'sca-safety-concern' AND ${initial_tags} CONTAINS 'sca-false-information'  )  THEN "Report a safety concern > A Story > Report fradulent information"
        WHEN ${initial_form} = "ts-reported-content-2" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-live-story'  AND ${initial_tags} CONTAINS 'sca-safety-concern'  )  THEN "Report a safety concern > Another Snapchatter's Story"
        WHEN ${initial_form} = "ts-reported-content-2" AND (${initial_tags} CONTAINS 'viewed-story'  AND ${initial_tags} CONTAINS 'cf-ts-content-story' AND ${initial_tags} CONTAINS 'ca-snap-maps'  AND ${initial_tags} CONTAINS 'sca-safety-concern'  )  THEN "Report a safety concern > Snap Map > I still have a concern about this content"

        WHEN ${initial_form} LIKE 'feedback-%' AND (${initial_tags} CONTAINS 'ts-source'  AND ${initial_tags} CONTAINS 'sca-quality' AND ${initial_tags} CONTAINS 'feedback'  AND ${initial_tags} CONTAINS 'ca-discover'  )  THEN "Report a safety concern > Discover > Video/Image quality"
        WHEN ${initial_form} LIKE 'feedback-%' AND (${initial_tags} CONTAINS 'ts-source'  AND ${initial_tags} CONTAINS 'sca-ordering' AND ${initial_tags} CONTAINS 'feedback'  AND ${initial_tags} CONTAINS 'ca-discover'  )  THEN "Report a safety concern > Discover > Ordering"
        WHEN ${initial_form} LIKE 'feedback-%' AND (${initial_tags} CONTAINS 'ts-source'  AND ${initial_tags} CONTAINS 'sca-publisher-content' AND ${initial_tags} CONTAINS 'feedback'  AND ${initial_tags} CONTAINS 'ca-discover'  )  THEN "Report a safety concern > Discover > Publisher Story content"
        WHEN ${initial_form} LIKE 'feedback-%' AND (${initial_tags} CONTAINS 'ts-source'  AND ${initial_tags} CONTAINS 'sca-otherstory-content' AND ${initial_tags} CONTAINS 'feedback'  AND ${initial_tags} CONTAINS 'ca-discover'  )  THEN "Report a safety concern > Discover > Other Story content"
        WHEN ${initial_form} LIKE 'feedback-%' AND (${initial_tags} CONTAINS 'ts-source'  AND ${initial_tags} CONTAINS 'sca-other' AND ${initial_tags} CONTAINS 'feedback'  AND ${initial_tags} CONTAINS 'ca-discover'  )  THEN "Report a safety concern > Discover > Other"

        WHEN ${initial_tags} CONTAINS 'ca-snapstreaks'  THEN "I lost my Snapstreak"

        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'open-app'  )  THEN "I found a bug in the app > Snapchat is crashing > When I open the app"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'snaps'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Snaps"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'chats'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Chats"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'stories'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'discover'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Publisher Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'camera'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Camera"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'memories'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Memories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'crashed' AND ${initial_tags} CONTAINS 'use-feature'  AND ${initial_tags} CONTAINS 'bitmoji'  )  THEN "I found a bug in the app > Snapchat is crashing > When I try to use a particular feature > Bitmoji"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-shuttersound'  )  THEN "I found a bug in the app > The Camera > Audio > Shutter sound"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-audioplay'  )  THEN "I found a bug in the app > The Camera > Audio > Recording/playback"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-bluetooth'  )  THEN "I found a bug in the app > The Camera > Audio > Bluetooth/headphones"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-static'  )  THEN "I found a bug in the app > The Camera > Audio > Audio is muffled or has sttic"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-blackcam'  )  THEN "I found a bug in the app > The Camera > Snapping photos or video > Black Camera"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-zoomedcamera'  )  THEN "I found a bug in the app > The Camera > Snapping photos or video > The camera looks zoomed-in"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-shakycam'  )  THEN "I found a bug in the app > The Camera > Snapping photos or video > Shaky camera"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-capturefail'  )  THEN "I found a bug in the app > The Camera > Snapping photos or video > Capture button not working"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-blurry'  )  THEN "I found a bug in the app > The Camera > Quality of photos or videos > Blurriness"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-avsync'  )  THEN "I found a bug in the app > The Camera > Quality of photos or videos > Audio/Video out of sync"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-coloroverlay'  )  THEN "I found a bug in the app > The Camera > Quality of photos or videos > Color overlay"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'sca-filters' AND ${initial_tags} CONTAINS 'ca-bugs-camera'  )  THEN "I found a bug in the app > The Camera > Filters or Lenses > Filters"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'sca-lenses' AND ${initial_tags} CONTAINS 'ca-bugs-camera'  )  THEN "I found a bug in the app > The Camera > Filters or Lenses > Lenses"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-flash'  )  THEN "I found a bug in the app > The Camera > Camera features > Flash"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-nightmode'  )  THEN "I found a bug in the app > The Camera > Camera features > Night Mode"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-flipcam'  )  THEN "I found a bug in the app > The Camera > Camera features > Switching between front and back camera"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-zoom'  )  THEN "I found a bug in the app > The Camera > Camera features > Zoom"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-focusmode'  )  THEN "I found a bug in the app > The Camera > Camera features > Focus Mode"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-timer'  )  THEN "I found a bug in the app > The Camera > Camera features > Timer"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-grid'  )  THEN "I found a bug in the app > The Camera > Camera features > Grid"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-multi-snap-mode'  )  THEN "I found a bug in the app > The Camera > Camera features > Multi Snap"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-snaps-with-3d'  )  THEN "I found a bug in the app > The Camera > Camera features > 3D"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-sounds'  )  THEN "I found a bug in the app > The Camera > Camera features > Sounds"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-camerapermissions'  )  THEN "I found a bug in the app > The Camera > Camera permissions"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-crash'  )  THEN "I found a bug in the app > The Camera > Crashing or freezing > Crashing"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-ccam-freezing'  )  THEN "I found a bug in the app > The Camera > Crashing or freezing > Freezing or lagging"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-create-quality'  )  THEN "I found a bug in the app > The Camera > Preview/Edit screen > Difference in quality"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-bugs-camera' AND ${initial_tags} CONTAINS 'sca-create-tools'  )  THEN "I found a bug in the app > The Camera > Preview/Edit screen > Trouble using Creative Tools"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'sca-stickers' AND ${initial_tags} CONTAINS 'ca-bugs-camera'  )  THEN "I found a bug in the app > The Camera > Preview/Edit screen > Trouble using Stickers"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-best-friends'  )  THEN "I found a bug in the app > Friends > Best Friends"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-friend-emojis'  )  THEN "I found a bug in the app > Friends > Friend Emojis"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-charms'  )  THEN "I found a bug in the app > Friends > Charms"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-friends-list'  )  THEN "I found a bug in the app > Friends > Friends List"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-manage-friends'  )  THEN "I found a bug in the app > Friends > Adding, deleting, or blocking friends"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-crashing'  )  THEN "I found a bug in the app > Games and Minis > Crashing"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-chats'  )  THEN "I found a bug in the app > Games and Minis > Chats"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-ringing'  )  THEN "I found a bug in the app > Games and Minis > Ringing friends"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-launching'  )  THEN "I found a bug in the app > Games and Minis > Launching Games or Minis"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-notifications'  )  THEN "I found a bug in the app > Games and Minis > Notifications"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-liveaudio'  )  THEN "I found a bug in the app > Games and Minis > Live Audio or Chat"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-editing'  AND ${initial_tags} CONTAINS 'all-tab'  )  THEN "I found a bug in the app > Memories > Editing > Snaps"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-editing'  AND ${initial_tags} CONTAINS 'stories-tab'  )  THEN "I found a bug in the app > Memories > Editing > Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-editing'  AND ${initial_tags} CONTAINS 'camera-roll-tab'  )  THEN "I found a bug in the app > Memories > Editing > Camera Roll"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-editing'  AND ${initial_tags} CONTAINS 'my-eyes-only-tab'  )  THEN "I found a bug in the app > Memories > Editing > My Eyes Only"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-exporting'  AND ${initial_tags} CONTAINS 'all-tab'  )  THEN "I found a bug in the app > Memories > Exporting content > Snaps"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-exporting'  AND ${initial_tags} CONTAINS 'stories-tab'  )  THEN "I found a bug in the app > Memories > Exporting content > Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-exporting'  AND ${initial_tags} CONTAINS 'camera-roll-tab'  )  THEN "I found a bug in the app > Memories > Exporting content > Camera Roll"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-exporting'  AND ${initial_tags} CONTAINS 'my-eyes-only-tab'  )  THEN "I found a bug in the app > Memories > Exporting content > My Eyes Only"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-loading'  AND ${initial_tags} CONTAINS 'all-tab'  )  THEN "I found a bug in the app > Memories > Loading > Snaps"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-loading'  AND ${initial_tags} CONTAINS 'stories-tab'  )  THEN "I found a bug in the app > Memories > Loading > Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-loading'  AND ${initial_tags} CONTAINS 'camera-roll-tab'  )  THEN "I found a bug in the app > Memories > Loading > Camera Roll"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-loading'  AND ${initial_tags} CONTAINS 'my-eyes-only-tab'  )  THEN "I found a bug in the app > Memories > Loading > My Eyes Only"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-lost'  AND ${initial_tags} CONTAINS 'all-tab'  )  THEN "I found a bug in the app > Memories > Lost Memories > Snaps"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-lost'  AND ${initial_tags} CONTAINS 'stories-tab'  )  THEN "I found a bug in the app > Memories > Lost Memories > Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-lost'  AND ${initial_tags} CONTAINS 'camera-roll-tab'  )  THEN "I found a bug in the app > Memories > Lost Memories > Camera Roll"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-lost'  AND ${initial_tags} CONTAINS 'my-eyes-only-tab'  )  THEN "I found a bug in the app > Memories > Lost Memories > My Eyes Only"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-passcode'  )  THEN "I found a bug in the app > Memories > Passcode"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-my-profile'  )  THEN "I found a bug in the app > Profiles > My Profile"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-friendship-profile'  )  THEN "I found a bug in the app > Profiles > A Friendship Profile"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-group-profile'  )  THEN "I found a bug in the app > Profiles > A Group Profile"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-public-profile'  )  THEN "I found a bug in the app > Profiles > My Public Profile"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-search,' )  THEN "I found a bug in the app > Search"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'sca-snap-maps-settings' )  THEN "I found a bug in the app > Snap Map > Settings"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-bitmoji-other'  )  THEN "I found a bug in the app > Snap Map > Bitmoji"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-viewing-content'  )  THEN "I found a bug in the app > Snap Map > Viewing content"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-data-usage'  )  THEN "I found a bug in the app > Snap Map > Data usage"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-search-bar'  )  THEN "I found a bug in the app > Snap Map > Search bar"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-maps-status'  )  THEN "I found a bug in the app > Snap Map > Status"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-maps-other'  )  THEN "I found a bug in the app > Snap Map > Something else"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-content'  )  THEN "I found a bug in the app > Spotlight > Content"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-favorites'  )  THEN "I found a bug in the app > Spotlight > Favorites"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-loading-content-new'  )  THEN "I found a bug in the app > Spotlight > Loading"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-navigation'  )  THEN "I found a bug in the app > Spotlight > Navigation"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-photo-video-quality'  )  THEN "I found a bug in the app > Spotlight > Photo or video quality"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-spotlight-payment'  )  THEN "I found a bug in the app > Spotlight > My Spotlight payout"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-public-profile'  )  THEN "I found a bug in the app > Spotlight > My Public Profile"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-friendsstories'  )  THEN "I found a bug in the app > Stories and Discover > Friends' Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-hidingcontent'  )  THEN "I found a bug in the app > Stories and Discover > Hiding content"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-storiesorder'  )  THEN "I found a bug in the app > Stories and Discover > Order of Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-photo-video-quality'  )  THEN "I found a bug in the app > Stories and Discover > Photo or video quality"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-publisherstories'  )  THEN "I found a bug in the app > Stories and Discover > Publisher Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-sharingstories'  )  THEN "I found a bug in the app > Stories and Discover > Sharing Stories"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-shows'  )  THEN "I found a bug in the app > Stories and Discover > Shows"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-subscriptions-new'  )  THEN "I found a bug in the app > Stories and Discover > Subscriptions"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-discover-new'  )  THEN "I found a bug in the app > Stories and Discover > Discover"
        WHEN ${initial_form} LIKE 'bugs-%' AND (${initial_tags} CONTAINS 'bugs'  AND ${initial_tags} CONTAINS 'ca-story-studio' )  THEN "I found a bug in the app > Story Studio"

        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-ads' AND ${initial_tags} CONTAINS 'sca-intrusive'  )  THEN "I need help with a Snapchat feature > Advertisements > I don't like this content"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-ads' AND ${initial_tags} CONTAINS 'sca-inappropriate-content'  )  THEN "I need help with a Snapchat feature > Advertisements > This content shouldn't be on Snapchat"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-ads' AND ${initial_tags} CONTAINS 'sca-ads-fraudulent'  )  THEN "I need help with a Snapchat feature > Advertisements > This content is promoting fraudulent information"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-ads' AND ${initial_tags} CONTAINS 'sca-ads-other'  )  THEN "I need help with a Snapchat feature > Advertisements > I have another issue with this content"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-multi-snap'  ) AND ( ${initial_tags} NOT LIKE '%sca-multi-snap-mode%')  THEN "I need help with a Snapchat feature > Camera > Long Snap"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-flash'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Flash"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-nightmode'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Night Mode"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-flipcam'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Switching between front and back camera"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-zoom'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Zoom"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-focusmode'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Focus Mode"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-timer'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Timer"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-grid'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Grid"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-multi-snap-mode'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Multi Snap"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-snaps-with-3d'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > 3D"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-ccam-sounds'  )  THEN "I need help with a Snapchat feature > Camera > Camera features > Sounds"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-creative-tools'  )  THEN "I need help with a Snapchat feature > Camera > Editing a Snap"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-snapping-content'  AND ${initial_tags} CONTAINS 'photo'  )  THEN "I need help with a Snapchat feature > Camera > Snapping photos or video > Photo"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-snapping-content'  AND ${initial_tags} CONTAINS 'video'  )  THEN "I need help with a Snapchat feature > Camera > Snapping photos or video > Video"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-camera-quality'  AND ${initial_tags} CONTAINS 'photo'  )  THEN "I need help with a Snapchat feature > Camera > Photo or video quality > Photo"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-camera-quality'  AND ${initial_tags} CONTAINS 'video'  )  THEN "I need help with a Snapchat feature > Camera > Photo or video quality > Video"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-camera-feedback' AND ${initial_tags} CONTAINS 'sca-shazam'  )  THEN "I need help with a Snapchat feature > Camera > Shazam"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-best-friends'  )  THEN "I need help with a Snapchat feature > Friends > Best Friends"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-friend-emojis'  )  THEN "I need help with a Snapchat feature > Friends > Friend Emojis"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-charms'  )  THEN "I need help with a Snapchat feature > Friends > Charms"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-friends-list'  )  THEN "I need help with a Snapchat feature > Friends > Friends List"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-friends' AND ${initial_tags} CONTAINS 'sca-manage-friends'  )  THEN "I need help with a Snapchat feature > Friends > Adding, deleting, or blocking friends"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-experience'  )  THEN "I need help with a Snapchat feature > Games and Minis > Gameplay or Mini experience"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-chats'  )  THEN "I need help with a Snapchat feature > Games and Minis > Chats"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-ringing'  )  THEN "I need help with a Snapchat feature > Games and Minis > Ringing friends"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-launching'  )  THEN "I need help with a Snapchat feature > Games and Minis > Launching Games or Minis"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-notifications'  )  THEN "I need help with a Snapchat feature > Games and Minis > Notifications"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-gamesminis' AND ${initial_tags} CONTAINS 'sca-gamesminis-liveaudio'  )  THEN "I need help with a Snapchat feature > Games and Minis > Live Audio Chat"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-backup'  )  THEN "I need help with a Snapchat feature > Memories > Backing up Memories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-saving'  )  THEN "I need help with a Snapchat feature > Memories > Saving Memories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-eyes-only'  )  THEN "I need help with a Snapchat feature > Memories > My Eyes Only"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-deleting'  )  THEN "I need help with a Snapchat feature > Memories > Deleting from Memories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-posting-story'  )  THEN "I need help with a Snapchat feature > Memories > Posting a Snap to My Story"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-editing'  )  THEN "I need help with a Snapchat feature > Memories > Editing in Memories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-photo-quality'  )  THEN "I need help with a Snapchat feature > Memories > Photo quality"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-video-quality'  )  THEN "I need help with a Snapchat feature > Memories > Video quality"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-memories' AND ${initial_tags} CONTAINS 'sca-memories-other'  )  THEN "I need help with a Snapchat feature > Memories > Something else"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-my-profile'  )  THEN "I need help with a Snapchat feature > Profiles > My Profile"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-friendship-profile'  )  THEN "I need help with a Snapchat feature > Profiles > A Friendship Profile"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-group-profile'  )  THEN "I need help with a Snapchat feature > Profiles > A Group Profile"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-profile' AND ${initial_tags} CONTAINS 'sca-public-profile'  )  THEN "I need help with a Snapchat feature > Profiles > My Public Profile"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-search,' )  THEN "I need help with a Snapchat feature > Search"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-account-settings' )  THEN "I need help with a Snapchat feature > Settings"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-snap-maps-settings'  )  THEN "I need help with a Snapchat feature > Snap Map > Settings"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-bitmoji-other'  )  THEN "I need help with a Snapchat feature > Snap Map > Bitmoji"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-viewing-content'  )  THEN "I need help with a Snapchat feature > Snap Map > Viewing content"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-data-usage'  )  THEN "I need help with a Snapchat feature > Snap Map > Data usage"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-search-bar'  )  THEN "I need help with a Snapchat feature > Snap Map > Search bar"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-maps-status'  )  THEN "I need help with a Snapchat feature > Snap Map > Status"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-maps' AND ${initial_tags} CONTAINS 'sca-maps-other'  )  THEN "I need help with a Snapchat feature > Snap Map > Something else"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-content'  )  THEN "I need help with a Snapchat feature > Spotlight > Content"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-favorites'  )  THEN "I need help with a Snapchat feature > Spotlight > Favorites"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-loading-content-new'  )  THEN "I need help with a Snapchat feature > Spotlight > Loading"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-navigation'  )  THEN "I need help with a Snapchat feature > Spotlight > Navigation"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-photo-video-quality'  )  THEN "I need help with a Snapchat feature > Spotlight > Photo or video quality"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-spotlight-payment'  )  THEN "I need help with a Snapchat feature > Spotlight > My Spotlight payout"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-spotlight' AND ${initial_tags} CONTAINS 'sca-public-profile'  )  THEN "I need help with a Snapchat feature > Spotlight > My Public Profile"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-friendsstories'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Friends' Stories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-hidingcontent'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Hiding content"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-storiesorder'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Order of Stories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-photo-video-quality'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Photo or video quality"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-publisherstories'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Publisher Stories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-sharingstories'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Sharing Stories"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-shows'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Shows"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-subscriptions-new'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Subscriptions"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-stories' AND ${initial_tags} CONTAINS 'sca-discover-new'  )  THEN "I need help with a Snapchat feature > Stories and Discover > Discover"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-snap-camera' )  THEN "I need help with a Snapchat feature > Snap Camera for desktop"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-tokens-gifts' AND ${initial_tags} CONTAINS 'sca-snap-tokens-buy'  )  THEN "I need help with a Snapchat feature > Snap Tokens and Gifts > Buying Snap Tokens"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-tokens-gifts' AND ${initial_tags} CONTAINS 'sca-snap-tokens-use'  )  THEN "I need help with a Snapchat feature > Snap Tokens and Gifts > Using Snap Tokens"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-tokens-gifts' AND ${initial_tags} CONTAINS 'sca-snap-tokens-balance'  )  THEN "I need help with a Snapchat feature > Snap Tokens and Gifts > My balance"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-tokens-gifts' AND ${initial_tags} CONTAINS 'sca-gifting'  )  THEN "I need help with a Snapchat feature > Snap Tokens and Gifts > Gifting"
        WHEN ${initial_form} LIKE 'feedback-%' AND ( ${initial_tags} CONTAINS 'ca-tokens-gifts' AND ${initial_tags} CONTAINS 'sca-snap-tokens-other'  )  THEN "I need help with a Snapchat feature > Snap Tokens and Gifts > Something else"

        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'howto-create'  AND ${initial_tags} CONTAINS 'ca-odg-creative-tool'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Creating a Filter"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'availability'  AND ${initial_tags} CONTAINS 'ca-odg-general'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Available locations and times"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'change'  AND ${initial_tags} CONTAINS 'ca-odg-adjustment'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Change the dates, times, Geofence, or image"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'cancel'  AND ${initial_tags} CONTAINS 'ca-odg-general'  AND ${initial_tags} CONTAINS 'sca-odg-cancel')  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Cancelling my Filter"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'viewing-metrics'  AND ${initial_tags} CONTAINS 'ca-odg-metrics'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Viewing my metrics"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'payment-issue'  AND ${initial_tags} CONTAINS 'ca-odg-billing-payment'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > A payment issue"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'tool-issues'  AND ${initial_tags} CONTAINS 'ca-odg-creative-tool'  AND ${initial_tags} CONTAINS 'sca-odg-troubleshoot')  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Issues with the Create Your Own tool"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'not-seen'  AND ${initial_tags} CONTAINS 'ca-odg-in-flight'  AND ${initial_tags} CONTAINS 'sca-odg-troubleshoot')  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > I'm not seeing my Filter and it's live"
        WHEN ${initial_form} = "ts-report-a-geofilter" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'odg'  AND ${initial_tags} CONTAINS 'report'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Reporting a Filter I think should be taken down"
        WHEN ${initial_form} = "odg-1" AND ( ${initial_tags} CONTAINS 'geofilters' AND ${initial_tags} CONTAINS 'review'  AND ${initial_tags} CONTAINS 'ca-odg-general'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Filter I purchased > Review time"
        WHEN ${initial_form} = "ts-report-a-geofilter" AND ( ${initial_tags} CONTAINS 'community-geo' AND ${initial_tags} CONTAINS 'geofilters'  AND ${initial_tags} CONTAINS 'ca-abuse'  )  THEN "I need help with a Snapchat feature > A Filter I created > A Community Geofilter > Reporting a Filter I think should be taken down"

        WHEN ${initial_form} = "Public-Profile" AND (${initial_tags} CONTAINS 'general-support'  AND ${initial_tags} CONTAINS 'ca-story-studio' )  THEN "I need help with a Snapchat feature > Story Studio"
        WHEN ${initial_form} = "Copyright" AND (${initial_tags} CONTAINS 'sca-copyright' )  THEN "I want to report intellectual property infringement > Copyright"
        WHEN ${initial_form} = "Trademark Infringement" AND (${initial_tags} CONTAINS 'ca-legal-report-ip'  AND ${initial_tags} CONTAINS 'sca-trademark' AND ${initial_tags} CONTAINS 'issue-general-content'  )  THEN "I want to report intellectual property infringement > Trademark > In their content, including in an Ad, Filter, or Story"
        WHEN ${initial_form} = "Trademark Infringement" AND (${initial_tags} CONTAINS 'ca-legal-report-ip'  AND ${initial_tags} CONTAINS 'sca-trademark' AND ${initial_tags} CONTAINS 'issue-username-tm'  )  THEN "I want to report intellectual property infringement > Trademark > In their Snapchat username"
        WHEN ${initial_form} = "Trademark Infringement" AND (${initial_tags} CONTAINS 'ca-legal-report-ip'  AND ${initial_tags} CONTAINS 'sca-trademark' AND ${initial_tags} CONTAINS 'issue-counterfeit-goods'  )  THEN "I want to report intellectual property infringement > Trademark > To sell or promote counterfeit goods"
        WHEN ${initial_form} = "Right of Publicity Infringement" AND (${initial_tags} CONTAINS 'ca-legal-report-ip'  AND ${initial_tags} CONTAINS 'sca-publicity' )  THEN "I want to report intellectual property infringement > Right of Publicity"
        WHEN ${initial_form} = "information-privacy-questions" AND (${initial_tags} CONTAINS 'ca-privacy-gdpr'  AND ${initial_tags} CONTAINS 'sca-privacy-info-objection' )  THEN "I have a privacy question > How can I object to the processing of my information"

        WHEN ${initial_form} = "spotlight-payment-support"  THEN "Spotlight Payment Support deep-link form"
        WHEN ${initial_form} = "Public-Profile" AND ${initial_tags} CONTAINS 'public-profile-contact'  THEN "Public Profile deep-link form"

        ELSE "Other" END
              ;;

      description: "Entry node from help center - based on tags & forms"
      group_label: "Help Center Entrypoints"
    }

  dimension: help_center_entry_first_node {
    type: string
    sql: REGEXP_EXTRACT(${Help_center_entry_point}, r'([^>]*)') ;;
    description: "First node of the help center entry point"
    group_label: "Help Center Entrypoints"
  }

  dimension: help_center_entry_last_node {
    type: string
    sql: REGEXP_EXTRACT(${Help_center_entry_point}, r'([^>]*)+.?[0-9]*$') ;;
    description: "Last node of the help center entry point"
    group_label: "Help Center Entrypoints"
  }

  dimension: help_center_entry_second_node {
    type: string
    sql: REGEXP_EXTRACT(${Help_center_entry_point}, r'^(?:[^>]+>){1}([^>]+)') ;;
    description: "Second node of the help center entry point"
    group_label: "Help Center Entrypoints"
  }

  dimension: help_center_entry_third_node {
    type: string
    sql: REGEXP_EXTRACT(${Help_center_entry_point}, r'^(?:[^>]+>){2}([^>]+)') ;;
    description: "Third node of the help center entry point"
    group_label: "Help Center Entrypoints"
  }

  dimension: help_center_entry_fourth_node {
    type: string
    sql: REGEXP_EXTRACT(${Help_center_entry_point}, r'^(?:[^>]+>){3}([^>]+)') ;;
    description: "Fourth node of the help center entry point"
    group_label: "Help Center Entrypoints"
  }

  dimension: help_center_entry_fifth_node {
    type: string
    sql: REGEXP_EXTRACT(${Help_center_entry_point}, r'^(?:[^>]+>){4}([^>]+)') ;;
    description: "Fifth node of the help center entry point"
    group_label: "Help Center Entrypoints"
  }


  # MEASURES

  measure: count_tickets {
    type: count_distinct
    sql: ${ticket_id} ;;
    drill_fields: [detail*]
  }

  measure: tickets_fully_automated {
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: [is_tickets_automated: "yes"]
    drill_fields: [detail*]
  }

  measure: tickets_not_fully_automated {
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: [is_tickets_automated: "no"]
    drill_fields: [detail*]
  }

  measure: closed_tickets {
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: [status: "solved, closed"]
    drill_fields: [detail*]
  }

  measure: tickets__fully_automated_percent {
    type: number
    sql: ${tickets_fully_automated}/${closed_tickets} ;;
    value_format_name: percent_1
    drill_fields: [detail*]
  }

  measure: tickets_not_fully_automated_percent {
    type: number
    sql: ${tickets_not_fully_automated}/${closed_tickets} ;;
    value_format_name: percent_1
    drill_fields: [detail*]
  }

  measure: count_logins {
    type: sum
    sql: ${app_login_count} ;;
  }

  measure: count_users {
    type: count_distinct
    sql: ${ghost_id} ;;
  }

  measure: count_login_7_tickets {
    type: count_distinct
    sql: ${ticket_id} ;;
    filters: [login_7: "yes"]
    description: "Count of tickets for which a user logged in within 7 days from created date"
  }

  measure: count_login_7_users {
    type: count_distinct
    sql: ${ghost_id} ;;
    filters: [login_7: "yes"]
    description: "Count of unique users who logged in within 7 days from ticket created date"
  }

  # measure: percent_login_7_tickets {
  #   type: number
  #   sql: ${count_login_7_tickets}/${closed_tickets} ;;
  #   filters: [login_7: "yes"]
  #   description: "Percent of tickets for which a user logged in within 7 days from created date"
  #   value_format_name: percent_1
  # }

  # measure: percent_login_7_users {
  #   type: number
  #   sql: ${count_login_7_users}/${count_users} ;;
  #   filters: [login_7: "yes"]
  #   description: "Percent of unique users who logged in within 7 days from ticket created date"
  #   value_format_name: percent_1
  # }

  set: detail {
    fields: [tic_create_ts_time, ticket_id, url, ghost_id]
  }

}
