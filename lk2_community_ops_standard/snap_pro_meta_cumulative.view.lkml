# most active contributor jbabra@snapchat.com
view: snap_pro_meta_cumulative {
  view_label: "Snap Pro Users"
  derived_table: {
    sql:
        SELECT
        ghost_user_id,
        table_date,
        daily_active_follower_count,
        follower_count,
        is_official,
        is_snappro,
        IsBrandProfile,
        is_popular_user,
        is_blacklisted,
        is_mod_candidate,
        is_vip,
        os_type,
        days_since_creation,
        app_engagement_status,
        tier,
        creation_country
     FROM `search-analytics-156901.search_analysis_persistent.public_user_2*`
        WHERE {% condition date_filter%} TIMESTAMP(PARSE_DATE('%E4Y%m%d', CONCAT("2",_TABLE_SUFFIX))) {% endcondition %}

         ;;
  }

#Table filter

  filter: date_filter {
    label: "Table Filter"
    description: "Adding this filter will only query specific tables in the YYYYMMDD format. Not adding this filter will query all tables, all time"
    type: date
    convert_tz: no
  }

  dimension_group: table_date {
    type: time
    timeframes: [date, time, hour, week, day_of_week, month, year]
    convert_tz: no
  }

  dimension: ghost_user_id {
    type: string
    primary_key: yes
  }

  dimension: daily_active_follower_count {
    type: number
  }

  dimension: follower_count {
    type: number
  }

  dimension: is_official_h {
    type: yesno
    hidden: yes
    sql:  ${TABLE}.is_official ;;
  }

  dimension: is_official {
    type: string
    sql: CASE WHEN ${is_official_h} is true then "Yes"
              WHEN ${is_official_h} is false then "No"
              ELSE null
              End;;
  }


  dimension: is_snappro_h {
    type: yesno
    sql:  ${TABLE}.is_snappro ;;
    hidden: yes
  }

  dimension: is_snappro {
    type: string
    sql: CASE WHEN ${is_snappro_h} is true then "Yes"
              WHEN ${is_snappro_h} is false then "No"
              ELSE null
              End;;
              #this gives yes/no/null
    }

#   dimension: is_snappro_string {
#     type: string
#     sql:  CAST(${TABLE}.is_snappro AS STRING) ;;
#     #this gives true false null
#   }

    dimension: IsBrandProfile_h {
      type: yesno
      hidden: yes
      sql: ${TABLE}.IsBrandProfile ;;
    }

    dimension: IsBrandProfile {
      type: string
      label: "Is Brand Profile"
      sql: CASE WHEN ${IsBrandProfile_h} is true then "Yes"
              WHEN ${IsBrandProfile_h} is false then "No"
              ELSE null
              End;;
    }


    dimension: is_popular_user_h {
      type: yesno
      hidden: yes
      sql: ${TABLE}.is_popular_user ;;
    }

    dimension: is_popular_user {
      type: string
      sql: CASE WHEN ${is_popular_user_h} is true then "Yes"
              WHEN ${is_popular_user_h} is false then "No"
              ELSE null
              End;;
    }


    dimension: is_blacklisted_h {
      type: yesno
      hidden: yes
      sql: ${TABLE}.is_blacklisted ;;
    }

    dimension: is_blacklisted {
      type: string
      sql: CASE WHEN ${is_blacklisted_h} is true then "Yes"
              WHEN ${is_blacklisted_h} is false then "No"
              ELSE null
              End;;
    }


    dimension: is_mod_candidate_h {
      type: yesno
      hidden: yes
      sql: ${TABLE}.is_mod_candidate ;;
    }

    dimension: is_mod_candidate {
      type: string
      sql: CASE WHEN ${is_blacklisted_h} is true then "Yes"
              WHEN ${is_blacklisted_h} is false then "No"
              ELSE null
              End;;
    }


    dimension: moderation_status {
      sql: CASE
          WHEN ${is_mod_candidate} = "Yes" THEN "Eligible to appear in 'For You' "
          WHEN ${is_mod_candidate} = "No" THEN "Not eligible to appear in 'For You'"
          ELSE "Other"
          END ;;
      description: "Eligible for 'For You'"
    }

    dimension: is_vip_h {
      type: yesno
      sql:  ${TABLE}.is_vip ;;
      hidden: yes
    }

    dimension: is_vip {
      type: string
      sql: CASE WHEN ${is_vip_h} is true then "Yes"
              WHEN ${is_vip_h} is false then "No"
              ELSE null
              End;;
    }


    dimension: os_type {
      type: string
    }

    dimension: creation_country {
      type: string
    }

    dimension: days_since_creation {
      type: string
    }

    dimension: app_engagement_status {
      type: string
      description: "Idle, Casual, Regular, Power"
    }

    dimension: tier {
      type: string
    }

#   dimension: snap_pro_type_old {
#   type: string
#   sql: CASE
#       WHEN ${is_snappro} = "Yes" AND ${is_official} = "Yes" AND (${IsBrandProfile} is NULL OR ${IsBrandProfile} = "No")   THEN "Person (Official)"
#       WHEN ${is_snappro} = "Yes" AND (${is_official} = "No" OR ${is_official} is Null) AND (${IsBrandProfile} is NULL OR ${IsBrandProfile} = "No")  THEN "Person (no status)"
#       WHEN ${is_snappro} = "Yes" AND ${is_official} = "Yes" AND ${IsBrandProfile} = "Yes"  THEN "Business (Official)"
#       WHEN ${is_snappro} = "Yes" AND (${is_official} = "No" OR ${is_official} is Null) AND ${IsBrandProfile} = "Yes"  THEN "Business (no status)"
#       else "other" end
#   ;;
#   }

    dimension: snap_pro_type {
      type: string
      sql: CASE
        WHEN ${tier} = "TIER_PUBLIC" AND ${IsBrandProfile} = "Yes" THEN "General Brand"
        WHEN ${tier} = "TIER_PUBLIC_OFFICIAL" AND ${IsBrandProfile} = "Yes" THEN "Official Brand"
        WHEN ${tier} = "TIER_PUBLIC" AND (${IsBrandProfile} is NULL OR ${IsBrandProfile} = "No") THEN "General Creator"
        WHEN ${tier} = "TIER_PUBLIC_OFFICIAL" AND (${IsBrandProfile} is NULL OR ${IsBrandProfile} = "No") THEN "Snap Star"
        WHEN ${tier} = "TIER_STANDARD" AND (${IsBrandProfile} is NULL OR ${IsBrandProfile} = "No") THEN "Standard Snapchatter"
        ELSE "Other"
        END  ;;
      description: "General Brand -Customer contact coming from a non-verified Brand/Business.

      Official Brand -Customer contact coming from an Official Brand Profile.

      General Creator -Customer contact coming from a user with full Snap Pro but is not verified.

      Snap Star -Customer contact from from a Snap Star.

      Standard Snapchatter -Customer contact from a regular Snapchatter who opted into a Public Profile (AKA 'snap pro lite')."
    }


    #  description: "Business (no status), Business (Official), Person (no status), Person (Official)"

    measure: count_ghostid {
      type: count_distinct
      sql: ${ghost_user_id} ;;
      drill_fields: [drill*]
    }

    set: drill {
      fields: [
        ghost_user_id,
        follower_count,
        is_official,
        is_popular_user,
        is_mod_candidate,
        is_snappro,
        IsBrandProfile,
        is_vip,
        snap_pro_type,
        app_engagement_status,
        days_since_creation,
        moderation_status

      ]
    }



  }
