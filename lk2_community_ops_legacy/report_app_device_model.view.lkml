view: report_app_device_model {
  sql_table_name: (
      select
        ua.user_agent as user_agent,
        dm.device_model as device_model,
        dm.resolution_width as resolution_width,
        dm.screen_width_in as screen_width_in,
        dm.num_processors as num_processors,
        dm.screen_height_in as screen_height_in,
        dm.screen_height_px as screen_height_px,
        dm.max_video_width as max_video_width,
        dm.screen_width_px as screen_width_px,
        dm.resolution_height as resolution_height,
        dm.display_density as display_density,
        dm.max_video_height as max_video_height,
        dm.year_class as year_class,
        dm.total_memory as total_memory
      from [sc-analytics:report_app.app_user_agent] ua
        left join[sc-analytics:report_app.device_model] dm on dm.device_model=ua.device_model
    )
     ;;

    dimension: user_agent_2 {
      primary_key: yes
      hidden: yes
      sql: ${TABLE}.user_agent ;;
    }

    dimension: device_model {
      hidden: yes
      sql: ${TABLE}.device_model ;;
    }

    dimension: screen_width_in {
      sql: ${TABLE}.screen_width_in ;;
    }

    dimension: num_processors {
      sql: ${TABLE}.num_processors ;;
    }

    dimension: screen_height_in {
      sql: ${TABLE}.screen_height_in ;;
    }

    dimension: screen_height_px {
      sql: ${TABLE}.screen_height_px ;;
    }

    dimension: max_video_width {
      sql: ${TABLE}.max_video_width ;;
    }

    dimension: screen_width_px {
      sql: ${TABLE}.screen_width_px ;;
    }

    dimension: resolution_height {
      sql: ${TABLE}.resolution_height ;;
    }

    dimension: display_density {
      sql: ${TABLE}.display_density ;;
    }

    dimension: max_video_height {
      sql: ${TABLE}.max_video_height ;;
    }

    dimension: year_class {
      sql: ${TABLE}.year_class ;;
    }

    dimension: total_memory {
      sql: ${TABLE}.total_memory ;;
    }
  }
