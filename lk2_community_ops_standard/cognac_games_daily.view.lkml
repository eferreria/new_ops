view: cognac_games_daily {

derived_table: {

  sql:

      SELECT
      event_date,
      COALESCE(game_meta.publisher_name,'Unknown') AS  publisher_name,
      COALESCE(if(game_meta.title = 'sfasfasf','Givingli', game_meta.title), 'Unknown')  AS  game_title,
      case when game_meta.title in ('Color Galaxy STAGING','Island Jump','Alphabear Hustle','Sling Racers',
      'Master Archer','Get Shaped (STAGING)','Sugar Slam','Mergelings','Sliders',
      'Pizza Cat','Snow Time') then 'Rest of Portfolio' else game_meta.title end as game_title_group,
      game_summary.cognac_id  AS cognac_id,
      game_summary.app_build  AS app_build,
      game_summary.os_type  AS os_type,
      game_summary.country  AS country,
      game_summary.game_type AS  game_type,
      game_summary.asset_type  AS asset_type,
      COALESCE(game_meta.product_type, 'Unknown') as product_type,
      ghost_user_id,
      game_summary.cognac_dau  AS cognac_dau,
      game_summary.cognac_dau_ready_to_start AS  cognac_dau_ready_to_start,
      game_summary.cognac_open AS  cognac_open,
      game_summary.game_ready_to_start  AS game_ready_to_start,
      game_summary.game_load_time_sec  AS game_load_time_sec,
      game_summary.game_close  AS game_close,
      game_summary.game_time_sec  AS game_time_sec,
      game_summary.chat_sent  AS chat_sent,
      game_summary.invite_sent  AS invite_sent,
        any_share_attempt,
        any_share_success,
        canvas_share_attempt,
        canvas_share_sent,
        snippet_attempt,
        snippet_sent,
        any_share_attempt_uu,
        any_share_success_uu,
        snippet_attempt_uu,
        snippet_sent_uu,
        canvas_share_attempt_uu,
        canvas_share_sent_uu,


    FROM (
      SELECT
        cognac_id,
        event_date,
        app_build,
        os_type,
        country,
        game_type,
        asset_type,
        ghost_user_id,
        SUM(IF(cognac_open+cognac_game_ready_to_start+cognac_game_close>0,1,0))  AS cognac_dau,
        SUM(IF(cognac_game_ready_to_start>0,1,0))  AS cognac_dau_ready_to_start,
        SUM(cognac_open) AS  cognac_open,
        SUM(cognac_game_ready_to_start)  AS game_ready_to_start,
        SUM(cognac_game_load_time_sec)  AS game_load_time_sec,
        SUM(cognac_game_close)  AS game_close,
        SUM(cognac_time_sec)  AS game_time_sec,
        SUM(cognac_chat_sent)  AS chat_sent,
        SUM(cognac_invite_sent)  AS invite_sent,
        SUM(cast(snippet_attempt as float64)+cast(canvas_share_attempt as float64))  AS any_share_attempt,
        SUM(cast(snippet_sent as float64)+cast(canvas_share_sent as float64)) AS  any_share_success,
        SUM(canvas_share_attempt)  AS canvas_share_attempt,
        SUM(canvas_share_sent) AS  canvas_share_sent,
        SUM(snippet_attempt)  AS snippet_attempt,
        SUM(snippet_sent)  AS snippet_sent,
        SUM(IF(cast(snippet_attempt as float64)+cast(canvas_share_attempt as float64)>0,1,0))  AS any_share_attempt_uu,
        SUM(IF(cast(snippet_sent as float64)+cast(canvas_share_sent as float64)>0,1,0)) AS  any_share_success_uu,
        SUM(IF(snippet_attempt>0,1,0))  AS snippet_attempt_uu,
        SUM(IF(snippet_sent>0,1,0))  AS snippet_sent_uu,
        SUM(IF(canvas_share_attempt>0,1,0))  AS canvas_share_attempt_uu,
        SUM(IF(canvas_share_sent>0,1,0))  AS canvas_share_sent_uu,


      FROM (
          SELECT
            DATE(event_date) AS event_date,
            ghost_user_id,
            country,
            os_type,
            game_id  AS cognac_id,
            game_type,
            app_build,
            asset_type,
            SUM(cognac_open) AS  cognac_open,
            SUM(game_ready_to_start)  AS cognac_game_ready_to_start,
            SUM(load_time_sec) AS  cognac_game_load_time_sec,
            SUM(cognac_close_success) AS  cognac_game_close,
            SUM(case when game_total_time_sec between 0 and 86400 then game_total_time_sec else 0 end)  AS  cognac_time_sec,
            SUM(number_of_chat_sent)  AS cognac_chat_sent,
            SUM(number_of_invites_sent)  AS cognac_invite_sent,
            SUM(canvas_share_attempt) AS  canvas_share_attempt,
            SUM(canvas_share_send_to) AS  canvas_share_send_to,
            SUM(canvas_share_sent)  AS canvas_share_sent,
            SUM(canvas_share_return_to_app) AS  canvas_share_return_to_app,
            SUM(snippet_attempt)  AS snippet_attempt,
            SUM(snippet_camera)  AS snippet_camera,
            SUM(snippet_preview) AS  snippet_preview,
            SUM(snippet_send_to) AS  snippet_send_to,
            SUM(snippet_sent)  AS snippet_sent,
            SUM(snippet_return_to_app)  AS snippet_return_to_app
          FROM    `sc-analytics.report_growth.cognac_daily_user_sessions_*`
          WHERE {% condition date_filter %} TIMESTAMP(PARSE_DATE('%E4Y%m%d', _TABLE_SUFFIX)) {% endcondition %}
          AND app_build != 'PERF'
          AND app_build != 'DEBUG'
          group by 1,2,3,4,5,6,7,8

          ) user_summary
    where cognac_open > 0
    GROUP BY 1,2,3,4,5,6,7,8
    ) game_summary
    LEFT JOIN (
      SELECT
        CAST(PARSE_DATE("%Y%m%d", ds) AS DATE) AS ds,
        cognac_id ,
        MAX(publisher_name) AS publisher_name,
        MAX(title) AS title,
        max(product_type) as product_type
      FROM
      `sc-analytics.report_growth.cognac_product_type_mapping_*`
    WHERE {% condition date_filter %} TIMESTAMP(PARSE_DATE('%E4Y%m%d', _TABLE_SUFFIX)) {% endcondition %}
      GROUP BY
        1,
        2) AS game_meta
    ON
      game_summary.cognac_id = game_meta.cognac_id
      and game_summary.event_date = game_meta.ds

  ;;
}

  filter: date_filter {
    label: "Table Filter"
    description: "Adding this filter will only query specific tables in the YYYYMMDD format. Not adding this filter will query all tables, all time"
    type: date
    convert_tz: no
  }


    dimension_group: date {
      type: time
      timeframes: [date, day_of_week, week, month, year]
      sql: timestamp(${TABLE}.event_date) ;;
      convert_tz: no
      label: "UTC"
      description: "Please use date"
    }

    dimension: os_type {
      type: string
      sql: ${TABLE}.os_type;;
    }
#
#     dimension: age_group {
#       type: string
#       sql: ${TABLE}.age_group;;
#     }
#
#     dimension: friend_status {
#       type: string
#       sql: ${TABLE}.friend_status;;
#     }
#
#     dimension: app_version {
#       type: string
#       sql: ${TABLE}.app_version ;;
#     }

    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    dimension: ghost_user_id {
      type: string
      sql: ${TABLE}.ghost_user_id ;;
      hidden: yes
    }


  dimension: pk {
    type: string
    hidden: yes
    sql: CONCAT(${ghost_user_id}, ${game_time_sec_str}) ;;
    primary_key: yes
  }

    dimension: game_time_sec_str {
      type: string
      hidden: yes
      sql: CAST(${TABLE}.game_time_sec AS STRING)  ;;
    }

    dimension: publisher {
      type: string
      sql: ${TABLE}.publisher_name ;;
    }

    dimension: game_title {
      type: string
      sql: ${TABLE}.game_title ;;
    }

    dimension: game_type {
      type: string
      sql: ${TABLE}.game_type ;;
    }

    dimension: asset_type {
      type: string
      sql: ${TABLE}.asset_type ;;
    }


    dimension: product_type {
      type: string
      sql: ${TABLE}.product_type ;;
    }

    dimension: game_title_group {
      type: string
      sql: ${TABLE}.game_title_group ;;
    }


    measure: cognac_dau {
      type: sum
      sql: ${TABLE}.cognac_dau ;;
    }

    measure: cognac_dau_ready_to_start {
      type: sum
      sql: ${TABLE}.cognac_dau_ready_to_start ;;
    }

    measure: cognac_open {
      type: sum
      sql: ${TABLE}.cognac_open ;;
    }

    measure: game_ready_to_start {
      type: sum
      sql: ${TABLE}.game_ready_to_start ;;
    }

    measure: game_close {
      type: sum
      sql: ${TABLE}.game_close ;;
    }

    measure: game_time_sec {
      type: sum
      sql: ${TABLE}.game_time_sec ;;
    }

    measure: game_load_time_sec {
      type: sum
      sql: ${TABLE}.game_load_time_sec ;;
      value_format: "0.00"
    }

    measure: chat_sent {
      type: sum
      sql: ${TABLE}.chat_sent ;;
    }

    measure: invite_sent {
      type: sum
      sql: ${TABLE}.invite_sent ;;
    }

    measure: cognac_open_per_user {
      type: sum
      sql: SUM(${TABLE}.cognac_open)/SUM(${TABLE}.cognac_dau) ;;
    }

    measure: game_time_min_per_user {
      type: sum
      sql: (SUM(${TABLE}.game_time_sec)/SUM(${TABLE}.cognac_dau))/60 ;;
      value_format: "0.00"
    }

    measure: game_time_min_per_game_session {
      type: sum
      sql: (SUM(${TABLE}.game_time_sec)/SUM(${TABLE}.game_close))/60 ;;
      value_format: "0.00"
    }

    measure: loading_time_sec_per_game_session {
      type: sum
      sql: SUM(${TABLE}.game_load_time_sec)/SUM(${TABLE}.game_ready_to_start) ;;
      value_format: "0.00"
    }

    measure: any_share_attempt {
      type: sum
      sql: ${TABLE}.any_share_attempt ;;
    }

    measure: any_share_success {
      type: sum
      sql: ${TABLE}.any_share_success ;;
    }

    measure: canvas_share_attempt {
      type: sum
      sql: ${TABLE}.canvas_share_attempt ;;
    }

    measure: canvas_share_sent {
      type: sum
      sql: ${TABLE}.canvas_share_sent ;;
    }

    measure: snippet_attempt {
      type: sum
      sql: ${TABLE}.snippet_attempt ;;
    }

    measure: snippet_sent {
      type: sum
      sql: ${TABLE}.snippet_sent ;;
    }

    measure: any_share_attempt_uu {
      type: sum
      sql: ${TABLE}.any_share_attempt_uu ;;
    }

    measure: any_share_success_uu {
      type: sum
      sql: ${TABLE}.any_share_success_uu ;;
    }

    measure: canvas_share_attempt_uu {
      type: sum
      sql: ${TABLE}.canvas_share_attempt_uu ;;
    }

    measure: canvas_share_sent_uu {
      type: sum
      sql: ${TABLE}.canvas_share_sent_uu ;;
    }

    measure: snippet_attempt_uu {
      type: sum
      sql: ${TABLE}.snippet_attempt_uu ;;
    }

    measure: snippet_sent_uu {
      type: sum
      sql: ${TABLE}.snippet_sent_uu ;;
    }

  }
